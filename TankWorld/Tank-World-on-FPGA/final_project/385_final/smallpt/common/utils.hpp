#pragma once

#include <cuda.h>
#include <cuda_runtime.h>

#include <cstdlib>
#include <queue>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <utility>
#include <vector>

#define ANSI_COLOR_RED "\x1b[31m"
#define ANSI_COLOR_GREEN "\x1b[32m"
#define ANSI_COLOR_YELLOW "\x1b[33m"
#define ANSI_COLOR_BLUE "\x1b[34m"
#define ANSI_COLOR_MAGENTA "\x1b[35m"
#define ANSI_COLOR_CYAN "\x1b[36m"
#define ANSI_COLOR_RESET "\x1b[0m"

#ifdef __GNUC__
#define UNUSED __attribute__((unused))
#else // __GNUC__
#define UNUSED
#endif // __GNUC__

#if defined(__CUDA_ARCH__)
#define ALWAYS_INLINE inline
#elif defined(__GNUC__)
#define ALWAYS_INLINE __attribute__((always_inline)) inline
#else // defined(__GNUC__)
#define ALWAYS_INLINE __forceinline
#endif // defined(__GNUC__)

namespace detail {
namespace logger {

  static ALWAYS_INLINE void trace(const std::string & s) {
    printf(ANSI_COLOR_YELLOW "Trace:: " ANSI_COLOR_RESET);
    printf("%s", s.c_str());
    printf("\n");
  }
  template <typename... Args>
  static ALWAYS_INLINE void trace(const Args... args) {
    printf(ANSI_COLOR_YELLOW "Trace:: " ANSI_COLOR_RESET);
    printf(args...);
    printf("\n");
  }

  static ALWAYS_INLINE void debug(const std::string &s) {
    printf(ANSI_COLOR_YELLOW "Debug:: " ANSI_COLOR_RESET);
    printf("%s", s.c_str());
    printf("\n");
  }
  template <typename... Args>
  static ALWAYS_INLINE void debug(const Args... args) {
    printf(ANSI_COLOR_YELLOW "Debug:: " ANSI_COLOR_RESET);
    printf(args...);
    printf("\n");
  }
  static ALWAYS_INLINE void verbose(const std::string &s) {
    printf(ANSI_COLOR_GREEN "Verbose:: " ANSI_COLOR_RESET);
    printf("%s", s.c_str());
    printf("\n");
  }
  template <typename... Args>
  static ALWAYS_INLINE void verbose(const Args... args) {
    printf(ANSI_COLOR_GREEN "Verbose:: " ANSI_COLOR_RESET);
    printf(args...);
    printf("\n");
  }
  static ALWAYS_INLINE void info(const std::string &s) {
    printf(ANSI_COLOR_BLUE "Info:: " ANSI_COLOR_RESET);
    printf("%s", s.c_str());
    printf("\n");
  }

  template <typename... Args>
  static ALWAYS_INLINE void info(const Args... args) {
    printf(ANSI_COLOR_BLUE "Info:: " ANSI_COLOR_RESET);
    printf(args...);
    printf("\n");
  }
  static ALWAYS_INLINE void error(const std::string &s) {
    printf(ANSI_COLOR_RED "Error:: " ANSI_COLOR_RESET);
    printf("%s", s.c_str());
    printf("\n");
  }
  template <typename... Args>
  static ALWAYS_INLINE void error(const Args... args) {
    printf(ANSI_COLOR_RED "Error:: " ANSI_COLOR_RESET);
    printf(args...);
    printf("\n");
  }
  static ALWAYS_INLINE void critical(const std::string & s) {
    printf(ANSI_COLOR_RED "Critical:: " ANSI_COLOR_RESET);
    printf("%s", s.c_str());
    printf("\n");
    assert(0);
  }
  template <typename... Args>
  static ALWAYS_INLINE void critical(const Args... args) {
    printf(ANSI_COLOR_RED "Critical:: " ANSI_COLOR_RESET);
    printf(args...);
    printf("\n");
    assert(0);
  }
  static ALWAYS_INLINE void fatal(const std::string &s) {
    printf(ANSI_COLOR_RED "Fatal:: " ANSI_COLOR_RESET);
    printf("%s", s.c_str());
    printf("\n");
    assert(0);
  }
  template <typename... Args>
  static ALWAYS_INLINE void fatal(const Args... args) {
    printf(ANSI_COLOR_RED "Critical:: " ANSI_COLOR_RESET);
    printf(args...);
    printf("\n");
    assert(0);
  }
} // namespace logger
} // namespace detail

#define LOG(level, ...) detail::logger::level(__VA_ARGS__)

namespace detail {

template <typename T>
static ALWAYS_INLINE const char *error_string(const T &err);

template <typename T>
static ALWAYS_INLINE bool is_success(const T &err);

template <typename T>
static ALWAYS_INLINE bool is_error(const T &err) {
  return !is_success<T>(err);
}

template <typename T>
static ALWAYS_INLINE bool throw_if_error(const T &err, const char *stmt, const char *file, const char *func, int line) {
  if (is_success<T>(err)) {
    return false;
  }
#if defined(__CUDA_ARCH__)
  LOG(critical,
      "ERROR[%s] on %s::%d In %s:(%s) at threadIdx = (%d, %d, %d) and blockDim = (%d, "
      "%d, %d) FAILED",
      error_string<T>(err), file, line, func, stmt, threadIdx.x, threadIdx.y, threadIdx.z, blockIdx.x, blockIdx.y, blockIdx.z);
  return true;
#else  // defined(__CUDA_ARCH__)
  LOG(critical, std::string(fmt::format("ERROR[{}] on {}::{} In {}:({}) FAILED", error_string<T>(err), file, line, func, stmt)));
#endif // defined(__CUDA_ARCH__)
}

static std::vector<std::pair<int, int>> nGpuArchCoresPerSM{{0x10, 8},   // Tesla Generation (SM 1.0) G80 class
                                                           {0x11, 8},   // Tesla Generation (SM 1.1) G8x class
                                                           {0x12, 8},   // Tesla Generation (SM 1.2) G9x class
                                                           {0x13, 8},   // Tesla Generation (SM 1.3) GT200 class
                                                           {0x20, 32},  // Fermi Generation (SM 2.0) GF100 class
                                                           {0x21, 48},  // Fermi Generation (SM 2.1) GF10x class
                                                           {0x30, 192}, // Kepler Generation (SM 3.0) GK10x class
                                                           {0x32, 192}, // Kepler Generation (SM 3.2) GK10x class
                                                           {0x35, 192}, // Kepler Generation (SM 3.5) GK11x class
                                                           {0x50, 128}, // Maxwell Generation (SM 5.0) GM10x class
                                                           {0x60, 64},  // Pascal Generation (SM 6.0) GP100 class
                                                           {0x61, 128}, // Pascal Generation (SM 6.1) GP10x class
                                                           {0x62, 128}, // Pascal Generation (SM 6.2) GP10x class
                                                           {0x70, 64},  // Volta Generation (SM 7.0) GV100 class
                                                           {-1, -1}};

template <>
ALWAYS_INLINE const char *error_string<cudaError_t>(const cudaError_t &status) {
  return cudaGetErrorString(status);
}

template <>
ALWAYS_INLINE bool is_success<cudaError_t>(const cudaError_t &err) {
  return err == cudaSuccess;
}

template <>
ALWAYS_INLINE const char *error_string<CUresult>(const CUresult &status) {

  switch (status) {
    case CUDA_SUCCESS:
      return "Success";
    case CUDA_ERROR_ALREADY_ACQUIRED:
      return "CUDA_ERROR_ALREADY_ACQUIRED";
    case CUDA_ERROR_ALREADY_MAPPED:
      return "CUDA_ERROR_ALREADY_MAPPED";
    case CUDA_ERROR_ARRAY_IS_MAPPED:
      return "CUDA_ERROR_ARRAY_IS_MAPPED";
    case CUDA_ERROR_ASSERT:
      return "CUDA_ERROR_ASSERT";
    case CUDA_ERROR_CONTEXT_ALREADY_CURRENT:
      return "CUDA_ERROR_CONTEXT_ALREADY_CURRENT";
    case CUDA_ERROR_CONTEXT_ALREADY_IN_USE:
      return "CUDA_ERROR_CONTEXT_ALREADY_IN_USE";
    case CUDA_ERROR_CONTEXT_IS_DESTROYED:
      return "CUDA_ERROR_CONTEXT_IS_DESTROYED";
    case CUDA_ERROR_DEINITIALIZED:
      return "CUDA_ERROR_DEINITIALIZED";
    case CUDA_ERROR_ECC_UNCORRECTABLE:
      return "CUDA_ERROR_ECC_UNCORRECTABLE";
    case CUDA_ERROR_FILE_NOT_FOUND:
      return "CUDA_ERROR_FILE_NOT_FOUND";
    case CUDA_ERROR_HARDWARE_STACK_ERROR:
      return "CUDA_ERROR_HARDWARE_STACK_ERROR";
    case CUDA_ERROR_HOST_MEMORY_ALREADY_REGISTERED:
      return "CUDA_ERROR_HOST_MEMORY_ALREADY_REGISTERED";
    case CUDA_ERROR_HOST_MEMORY_NOT_REGISTERED:
      return "CUDA_ERROR_HOST_MEMORY_NOT_REGISTERED";
    case CUDA_ERROR_ILLEGAL_ADDRESS:
      return "CUDA_ERROR_ILLEGAL_ADDRESS";
    case CUDA_ERROR_ILLEGAL_INSTRUCTION:
      return "CUDA_ERROR_ILLEGAL_INSTRUCTION";
    case CUDA_ERROR_INVALID_ADDRESS_SPACE:
      return "CUDA_ERROR_INVALID_ADDRESS_SPACE";
    case CUDA_ERROR_INVALID_CONTEXT:
      return "CUDA_ERROR_INVALID_CONTEXT";
    case CUDA_ERROR_INVALID_DEVICE:
      return "CUDA_ERROR_INVALID_DEVICE";
    case CUDA_ERROR_INVALID_GRAPHICS_CONTEXT:
      return "CUDA_ERROR_INVALID_GRAPHICS_CONTEXT";
    case CUDA_ERROR_INVALID_HANDLE:
      return "CUDA_ERROR_INVALID_HANDLE";
    case CUDA_ERROR_INVALID_IMAGE:
      return "CUDA_ERROR_INVALID_IMAGE";
    case CUDA_ERROR_INVALID_PC:
      return "CUDA_ERROR_INVALID_PC";
    case CUDA_ERROR_INVALID_PTX:
      return "CUDA_ERROR_INVALID_PTX";
    case CUDA_ERROR_INVALID_SOURCE:
      return "CUDA_ERROR_INVALID_SOURCE";
    case CUDA_ERROR_INVALID_VALUE:
      return "CUDA_ERROR_INVALID_VALUE";
    case CUDA_ERROR_LAUNCH_FAILED:
      return "CUDA_ERROR_LAUNCH_FAILED";
    case CUDA_ERROR_LAUNCH_INCOMPATIBLE_TEXTURING:
      return "CUDA_ERROR_LAUNCH_INCOMPATIBLE_TEXTURING";
    case CUDA_ERROR_LAUNCH_OUT_OF_RESOURCES:
      return "CUDA_ERROR_LAUNCH_OUT_OF_RESOURCES";
    case CUDA_ERROR_LAUNCH_TIMEOUT:
      return "CUDA_ERROR_LAUNCH_TIMEOUT";
    case CUDA_ERROR_MAP_FAILED:
      return "CUDA_ERROR_MAP_FAILED";
    case CUDA_ERROR_MISALIGNED_ADDRESS:
      return "CUDA_ERROR_MISALIGNED_ADDRESS";
    case CUDA_ERROR_NOT_FOUND:
      return "CUDA_ERROR_NOT_FOUND";
    case CUDA_ERROR_NOT_INITIALIZED:
      return "CUDA_ERROR_NOT_INITIALIZED";
    case CUDA_ERROR_NOT_MAPPED:
      return "CUDA_ERROR_NOT_MAPPED";
    case CUDA_ERROR_NOT_MAPPED_AS_ARRAY:
      return "CUDA_ERROR_NOT_MAPPED_AS_ARRAY";
    case CUDA_ERROR_NOT_MAPPED_AS_POINTER:
      return "CUDA_ERROR_NOT_MAPPED_AS_POINTER";
    case CUDA_ERROR_NOT_PERMITTED:
      return "CUDA_ERROR_NOT_PERMITTED";
    case CUDA_ERROR_NOT_READY:
      return "CUDA_ERROR_NOT_READY";
    case CUDA_ERROR_NOT_SUPPORTED:
      return "CUDA_ERROR_NOT_SUPPORTED";
    case CUDA_ERROR_NO_BINARY_FOR_GPU:
      return "CUDA_ERROR_NO_BINARY_FOR_GPU";
    case CUDA_ERROR_NO_DEVICE:
      return "CUDA_ERROR_NO_DEVICE";
    case CUDA_ERROR_NVLINK_UNCORRECTABLE:
      return "CUDA_ERROR_NVLINK_UNCORRECTABLE";
    case CUDA_ERROR_OPERATING_SYSTEM:
      return "CUDA_ERROR_OPERATING_SYSTEM";
    case CUDA_ERROR_OUT_OF_MEMORY:
      return "CUDA_ERROR_OUT_OF_MEMORY";
    case CUDA_ERROR_PEER_ACCESS_ALREADY_ENABLED:
      return "CUDA_ERROR_PEER_ACCESS_ALREADY_ENABLED";
    case CUDA_ERROR_PEER_ACCESS_NOT_ENABLED:
      return "CUDA_ERROR_PEER_ACCESS_NOT_ENABLED";
    case CUDA_ERROR_PEER_ACCESS_UNSUPPORTED:
      return "CUDA_ERROR_PEER_ACCESS_UNSUPPORTED";
    case CUDA_ERROR_PRIMARY_CONTEXT_ACTIVE:
      return "CUDA_ERROR_PRIMARY_CONTEXT_ACTIVE";
    case CUDA_ERROR_PROFILER_ALREADY_STARTED:
      return "CUDA_ERROR_PROFILER_ALREADY_STARTED";
    case CUDA_ERROR_PROFILER_ALREADY_STOPPED:
      return "CUDA_ERROR_PROFILER_ALREADY_STOPPED";
    case CUDA_ERROR_PROFILER_DISABLED:
      return "CUDA_ERROR_PROFILER_DISABLED";
    case CUDA_ERROR_PROFILER_NOT_INITIALIZED:
      return "CUDA_ERROR_PROFILER_NOT_INITIALIZED";
    case CUDA_ERROR_SHARED_OBJECT_INIT_FAILED:
      return "CUDA_ERROR_SHARED_OBJECT_INIT_FAILED";
    case CUDA_ERROR_SHARED_OBJECT_SYMBOL_NOT_FOUND:
      return "CUDA_ERROR_SHARED_OBJECT_SYMBOL_NOT_FOUND";
    case CUDA_ERROR_TOO_MANY_PEERS:
      return "CUDA_ERROR_TOO_MANY_PEERS";
    case CUDA_ERROR_UNKNOWN:
      return "CUDA_ERROR_UNKNOWN";
    case CUDA_ERROR_UNMAP_FAILED:
      return "CUDA_ERROR_UNMAP_FAILED";
    case CUDA_ERROR_UNSUPPORTED_LIMIT:
      return "CUDA_ERROR_UNSUPPORTED_LIMIT";
    default:
      return "CUDA Driver Unknown Error";
  }
}

template <>
ALWAYS_INLINE bool is_success<CUresult>(const CUresult &err) {
  return err == CUDA_SUCCESS;
}

} // namespace detail

#ifndef IS_ERROR
#define IS_ERROR(stmt) detail::is_error(stmt)
#endif // IS_ERROR

#ifndef THROW_IF_ERROR
#define THROW_IF_ERROR(stmt) detail::throw_if_error(stmt, #stmt, __FILE__, __func__, __LINE__)
#endif // THROW_IF_ERROR

#ifndef PRINT_IF_LAUNCH_ERROR
#define PRINT_IF_LAUNCH_ERROR(...)                                                                                                         \
  do {                                                                                                                                     \
    try {                                                                                                                                  \
      __VA_ARGS__;                                                                                                                         \
      THROW_IF_ERROR(cudaGetLastError());                                                                                                  \
    } catch (...) {                                                                                                                        \
    }                                                                                                                                      \
  } while (0)
#endif // PRINT_IF_LAUNCH_ERROR

namespace detail {
struct timer_entry {
  std::string msg{""};
  cudaEvent_t start, stop;
  timer_entry(const std::string msg) : msg(msg) {
    THROW_IF_ERROR(cudaEventCreate(&start));
    THROW_IF_ERROR(cudaEventCreate(&stop));
    THROW_IF_ERROR(cudaEventRecord(start));
  };

  void log() {
    float msecTotal = 0.0f;
    THROW_IF_ERROR(cudaEventRecord(stop));
    THROW_IF_ERROR(cudaEventSynchronize(stop));
    THROW_IF_ERROR(cudaEventElapsedTime(&msecTotal, start, stop));
    const std::string to_print = msg + " took " + ANSI_COLOR_GREEN + std::to_string(msecTotal) + "ms" + ANSI_COLOR_RESET;
    printf(ANSI_COLOR_BLUE "TIMER::" ANSI_COLOR_RESET " %s\n", to_print.c_str());
  }

  ~timer_entry() {
    cudaEventDestroy(start);
    cudaEventDestroy(stop);
  }
};

static std::queue<timer_entry *> timer_table{};

} // namespace detail

static void timer_start(const std::string &msg) {
  detail::timer_table.emplace(new detail::timer_entry(msg));
}

static void timer_stop() {
  auto entry = detail::timer_table.back();
  entry->log();
  detail::timer_table.pop();
  delete entry;
}

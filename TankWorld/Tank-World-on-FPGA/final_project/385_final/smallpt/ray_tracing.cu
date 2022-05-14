#include "common/fmt.hpp"
#include "common/utils.hpp"

#define PRINT(...) LOG(info, std::string(fmt::format(__VA_ARGS__)))

#define NUM_COUNT  100000

__global__ void vecAdd(float *in1, float *in2, float *out, int len) {
  int i = blockIdx.x * blockDim.x + threadIdx.x;
  if (i < len) out[i] = in1[i] + in2[i];
}

int main(int argc, char **argv) {
  float hostInput1[NUM_COUNT];
  float hostInput2[NUM_COUNT];
  float hostOutput[NUM_COUNT];
  float solution[NUM_COUNT];
  float *deviceInput1;
  float *deviceInput2;
  float *deviceOutput;

  for (int i = 0; i < NUM_COUNT; i++) {
    hostInput1[i] = NUM_COUNT / 1.0;
    hostInput2[i] = NUM_COUNT / 1.0;
    solution[i] = NUM_COUNT / 1.0 + NUM_COUNT / 1.0;
  }

  int size = NUM_COUNT * sizeof(float);
  cudaMalloc((void **) &deviceInput1, size);
  cudaMalloc((void **) &deviceInput2, size);
  cudaMalloc((void **) &deviceOutput, size);

  cudaMemcpy(deviceInput1, hostInput1, size, cudaMemcpyHostToDevice);
  cudaMemcpy(deviceInput2, hostInput2, size, cudaMemcpyHostToDevice);

  dim3 DimGrid(ceil(NUM_COUNT/1024.0),1,1);
  dim3 DimBlock(1024,1,1);

  timer_start("Start GPU Kernel");
  vecAdd<<<DimGrid, DimBlock>>>(deviceInput1, deviceInput2, deviceOutput, NUM_COUNT);
  cudaDeviceSynchronize();
  timer_stop();

  cudaMemcpy(hostOutput, deviceOutput, size, cudaMemcpyDeviceToHost);

  cudaFree(deviceInput1);
  cudaFree(deviceInput2);
  cudaFree(deviceOutput);

  int err_cnt = 0;
  for (int i = 0; i < NUM_COUNT; i++) {
    if (hostOutput[i] != solution[i])
      err_cnt = 1;
  }

  if (err_cnt)
    PRINT("ERROR!");
  else
    PRINT("CORRECT!");

  return 0;
}
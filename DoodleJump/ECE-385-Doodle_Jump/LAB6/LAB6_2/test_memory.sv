//-------------------------------------------------------------------------
//      test_memory.sv                                                   --
//      Stephen Kempf                                                    --
//      Summer 2005                                                      --
//                                                                       --
//      Revised 3-15-2006                                                --
//              3-22-2007                                                --
//              7-26-2013                                                --
//              10-19-2017 by Anand Ramachandran and Po-Han Huang        --
//                        Spring 2018 Distribution                       --
//                                                                       --
//      For use with ECE 385 Experment 6                                 --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------

// This memory has similar behavior to the SRAM IC on the DE2 board.  This
// file is for simulations only.  In simulation, this memory is guaranteed
// to work at least as well as the actual memory (that is, the actual
// memory may require more careful treatment than this test memory).
// At synthesis, this will be synthesized into a blank module.

module test_memory ( input          Clk,
                     input          Reset, // Active-high reset!
                     inout  [15:0]  I_O,   // Data
                     input  [19:0]  A,     // Address
                     input          CE,    // Chip enable
                                    UB,    // Upper byte enable
                                    LB,    // Lower byte enable
                                    OE,    // Output (read) enable
                                    WE     // Write enable
);

    parameter size          = 256; // expand memory as needed (currently it is 256 words)
    parameter init_external = 0;   // If init external is 0, it means you want to parse the memory_contents.sv file, otherwise you are providing a parsed .dat file

    integer ptr;
    integer x;

    logic [15:0] mem_array [0:size-1];
    logic [15:0] mem_out;
    logic [15:0] I_O_wire;
    logic [7:0] actual_address;
    assign actual_address = A[7:0];
    // A[7:0] is because size = 256, so we only use the lower 8 bits of the address.
    // It should be changed accordingly if size is modified.

    // Requires memory_contents.sv
    memory_parser #(.size(size)) parser();

// synthesis translate_off
// This line turns off Quartus' synthesis tool because test memory is NOT synthesizable.

    initial begin
        parser.memory_contents(mem_array);
      
        // Parse into machine code and write into file
        if (~init_external) begin
            ptr = $fopen("memory_contents.dat", "w");
            
            for (integer x = 0; x < size; x++) begin
                $fwrite(ptr, "@%0h %0h\n", x, mem_array[x]);
            end
            
            $fclose(ptr);
        end

        $readmemh("memory_contents.dat", mem_array, 0, size-1);
    end
    
    // Memory read logic
    always_ff @ (negedge Clk)
    begin
        mem_out <= mem_array[actual_address]; // Read a specific memory cell. 
        // Flip-flop with negedge Clk is used to simulate the 10ns access time.
        // (Assuming address changes at rising clock edge)
    end
    always_comb
    begin
        // By default, do not drive the IO bus
        I_O_wire = 16'bZZZZZZZZZZZZZZZZ;
        
        // Drvie the IO bus when chip select and read enable are active, and write enable is inactive
        if (~CE && ~OE && WE) begin
            if (~UB)
                I_O_wire[15:8] = mem_out[15:8]; // Read upper byte
            
            if (~LB)
                I_O_wire[7:0] = mem_out[7:0];   // Read lower byte
        end
    end

    // Memory write logic
    always_ff @ (posedge Clk or posedge Reset)
    begin
        // By default, mem_array holds its values.

        // If Reset is high, set the mem_array to initial memory contents.
        if(Reset) begin
            $readmemh("memory_contents.dat", mem_array, 0, size-1);
        end
        else if (~CE && ~WE) // Write to memory if chip select and write enable are active
        begin
            if(~UB)
                mem_array[actual_address][15:8] <= I_O[15:8]; // Write upper byte
            if(~LB)
                mem_array[actual_address][7:0] <= I_O[7:0];   // Write lower byte
        end

    end

    assign I_O = I_O_wire;

// synthesis translate_on
endmodule

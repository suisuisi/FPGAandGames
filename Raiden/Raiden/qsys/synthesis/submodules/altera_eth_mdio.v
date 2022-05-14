// (C) 2001-2018 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel FPGA IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Intel and sold by 
// Intel or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// Note: Only MDIO for Clause 45 (10GbE) is supported
//       Clause 22 (1GbE and below) is not supported

`timescale 1ns / 1ns
module altera_eth_mdio #(
    parameter MDC_DIVISOR = 32       // MDC frequency is Avalon clock / MDC_DIVISOR. Must be <2.5MHz
) (
    input               clk,
    input               reset,

    input               csr_read,
    input               csr_write,
    input   [5:0]       csr_address,
    input   [31:0]      csr_writedata,
    output  reg [31:0]  csr_readdata,
    output  wire        csr_waitrequest,

    output  reg         mdc,
    input               mdio_in,
    output  reg         mdio_out,
    output  reg         mdio_oen
);

    localparam P_MDC_DIVIDE_BITS = log2ceil(MDC_DIVISOR) - 1;    // Need to count to (MDC_DIVISOR/2) - 1
    
    //param for case state
    localparam S_PREAMBLE   = 4'b0000; // 0 
    localparam S_IDLE       = 4'b0001; // 1
    localparam S_CTRL_CL22  = 4'b0010; // 2
    localparam S_WRITE      = 4'b0011; // 3
    localparam S_READ       = 4'b0100; // 4
    localparam S_ADDR_CL45  = 4'b0101; // 5
    localparam S_WRITE_ADDR_CL45 = 4'b0110; // 6
    localparam S_CTRL_CL45  = 4'b0111; // 7
    localparam S_PREAMBLE2  = 4'b1000; // 8
    localparam S_PREAMBLE3  = 4'b1001; // 9
    
    
    
    
    
    reg [P_MDC_DIVIDE_BITS-1:0] mdc_divide;
    reg mdc_tick;
    reg mdc_sample;

    reg [3:0] state;
    reg [4:0] count;
    reg read_pending;
    reg write_pending;
    reg [4:0] address;
    reg [15:0] data;
    reg clause45_reg;
    reg [4:0] phy_address_latched;
    reg [4:0] prt_address_latched;
    reg [4:0] dev_address_latched;
    reg [15:0] cl45_reg_address_latched;
    
    // Address register and wiring
    reg [31:0] dev_prt_phy_address_reg;
    wire   [4:0]      phy_address = dev_prt_phy_address_reg[4:0];           // clause 22 PHYAD
    wire   [4:0]      dev_address = dev_prt_phy_address_reg[4:0];           // clause 45 DEVAD
    wire   [4:0]      prt_address = dev_prt_phy_address_reg[12:8];          // clasue 45 PRTAD
    wire              clause45    = csr_address[5];
    wire  [15:0]      cl45_reg_address = dev_prt_phy_address_reg[31:16];    // clause 45 ADDRESS
    
    // CSR waitrequest
    reg avalon_waitrequest_reg;
    assign csr_waitrequest = avalon_waitrequest_reg;

    // Identifies that avalon is accessing the Address Registers
    wire address_reg_acc;
    assign address_reg_acc = (csr_address == 6'h21);

    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            avalon_waitrequest_reg <= 1'b1;
        end
        else begin
            if (address_reg_acc && (csr_write || csr_read) && avalon_waitrequest_reg) begin
                avalon_waitrequest_reg <= 1'b0;
            end
            else begin
                if (mdc_tick && ((state == S_READ && count == 5'd16) || (state == S_WRITE && count == 5'd15))) begin
                    avalon_waitrequest_reg <= 1'b0;
                end else begin
                    avalon_waitrequest_reg <= 1'b1;
                end
            end
        end
    end

    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            mdc <= 1'b0;
            mdio_oen <= 1'b1;
            mdio_out <= 1'b1;
            mdc_divide <= 0;
            mdc_tick <= 1'b0;
            mdc_sample <= 1'b0;
            state <= S_PREAMBLE;
            count <= 5'h0;
            csr_readdata <= 32'h0;
            read_pending <= 1'b0;
            write_pending <= 1'b0;
            address <= 5'b0;
            data <= 16'b0;
            clause45_reg <= 1'b0;
            phy_address_latched <= {5{1'b0}};
            prt_address_latched <= {5{1'b0}};
            dev_address_latched <= {5{1'b0}};
            cl45_reg_address_latched <= {16{1'b0}};
            dev_prt_phy_address_reg <= {32{1'b0}};
        end
        else begin
            // Divide Avalon clock to make MDIO clock
            if (mdc_divide==0) begin
                mdc <= ~mdc;
                mdc_divide <= (MDC_DIVISOR/2) - 1'b1;
            end
            else begin
                mdc_divide <= mdc_divide - 1'b1;
            end

            // Data is output on mdc_tick. Delay it slightly from the clock to ensure setup and hold timing is met
            mdc_tick <= ~mdc & (mdc_divide==(MDC_DIVISOR/2) -1);

            // Sample read data just before rising edge of MDC
            mdc_sample <= ~mdc & (mdc_divide==2);

            
            // From MDIO readdata
            if (!address_reg_acc) begin
                if ((state==S_READ) & count>5'd0 & mdc_sample)
                    csr_readdata <= {16'h0, csr_readdata[14:0], mdio_in};
                end
                // Register space read
            else begin
                if(csr_write) begin
                    dev_prt_phy_address_reg <= csr_writedata;
                end
                
                if(csr_read) begin
                    csr_readdata <= dev_prt_phy_address_reg & {16'hffff, 3'b000, 5'b11111, 3'b000, 5'b11111};
                end
            end
            
            
            
            // Service Avalon read and write requests
            if (~address_reg_acc & csr_write & avalon_waitrequest_reg & ~write_pending & ~read_pending) begin
                write_pending <= 1'b1;
                address <= csr_address[4:0];
                phy_address_latched <= phy_address;
                prt_address_latched <= prt_address;
                dev_address_latched <= dev_address;
                cl45_reg_address_latched <= cl45_reg_address;
                data <= csr_writedata[15:0];
                clause45_reg <= clause45;
            end
            else if (~address_reg_acc & csr_read & avalon_waitrequest_reg & ~write_pending & ~read_pending) begin
                read_pending <= 1'b1;
                address <= csr_address[4:0];
                clause45_reg <= clause45;
                phy_address_latched <= phy_address;
                prt_address_latched <= prt_address;
                dev_address_latched <= dev_address;
                cl45_reg_address_latched <= cl45_reg_address;
            end

            // State machine to control access to PHY
            if (mdc_tick) begin
                case (state)
                    // Wait for 32 clocks before first operation in order to establish synchronization
                    S_PREAMBLE : begin
                        mdio_oen <= 1'b1;      // Use pullup resistor
                        mdio_out <= 1'b1;
                        count <= count + 5'h1;
                        
                        if (count==5'd31) begin
                            state <= S_IDLE;
                        end
                    end

                    // Wait for write or read request from Avalon
                    S_IDLE : begin
                        count <= 5'd0;
                        mdio_oen <= 1'b1;
                        mdio_out <= 1'b1;
                        
                        if(!address_reg_acc) begin
                            if (write_pending || read_pending) begin
                                mdio_out <= 1'b1;     // Output first bit of START word
                                mdio_oen <= 1'b0;
                                state <= S_PREAMBLE2;
                            end
                        end
                    end

                    S_PREAMBLE2 : begin
                        mdio_oen <= 1'b0;
                        mdio_out <= 1'b1;
                        count <= count + 5'd1;
                        
                        if (count==5'd31) begin
                            count <= 5'd0;
                            
                            if (write_pending) begin
                                mdio_out <= 1'b0;     // Output first bit of START word
                                mdio_oen <= 1'b0;
                                if (clause45_reg)
                                    state <= S_ADDR_CL45;
                                else
                                    state <= S_CTRL_CL22;
                            end
                            else if (read_pending) begin
                                mdio_out <= 1'b0;     // Output first bit of START word
                                mdio_oen <= 1'b0;
                                if (clause45_reg)
                                    state <= S_ADDR_CL45;
                                else
                                    state <= S_CTRL_CL22;
                            end
                        end 
                    end

                    // Send control data
                    S_CTRL_CL22 : begin
                        //
                        case (count)
                            // Second bit of START word
                            0  : mdio_out <= 1'b1;
                            // OPCODE. 1 then 0 for read, 0 then 1 for write
                            1  : mdio_out <= read_pending;
                            2  : mdio_out <= ~read_pending;
                            // PHY address
                            3  : mdio_out <= phy_address_latched[4];
                            4  : mdio_out <= phy_address_latched[3];
                            5  : mdio_out <= phy_address_latched[2];
                            6  : mdio_out <= phy_address_latched[1];
                            7  : mdio_out <= phy_address_latched[0];
                            // Register address
                            8  : mdio_out <= address[4];
                            9  : mdio_out <= address[3];
                            10 : mdio_out <= address[2];
                            11 : mdio_out <= address[1];
                            12 : mdio_out <= address[0];
                            // TA
                            13 : mdio_out <= 1'b1;
                            14 : mdio_out <= 1'b0;
                            default: mdio_out <= mdio_out;
                        endcase

                        count <= count + 5'd1;

                        // For read, turn off output for TA cycle
                        if (count==13 & read_pending)
                            mdio_oen <= 1'b1;

                        if (count==5'd14) begin
                            count <= 5'd0;
                            if (read_pending)
                                state <= S_READ;
                            else
                                state <= S_WRITE;
                        end

                    end

                    S_ADDR_CL45 : begin
                    //
                        case (count)
                            // Second bit of START word
                            0  : mdio_out <= 1'b0;
                            // OPCODE. 1 then 0 for read, 0 then 1 for write
                            1  : mdio_out <= 1'b0;
                            2  : mdio_out <= 1'b0;
                            // PHY address
                            3  : mdio_out <= prt_address_latched[4];
                            4  : mdio_out <= prt_address_latched[3];
                            5  : mdio_out <= prt_address_latched[2];
                            6  : mdio_out <= prt_address_latched[1];
                            7  : mdio_out <= prt_address_latched[0];
                            // Register address
                            8  : mdio_out <= dev_address_latched[4];
                            9  : mdio_out <= dev_address_latched[3];
                            10 : mdio_out <= dev_address_latched[2];
                            11 : mdio_out <= dev_address_latched[1];
                            12 : mdio_out <= dev_address_latched[0];
                            // TA
                            13 : mdio_out <= 1'b1;
                            14 : mdio_out <= 1'b0;
                            default: mdio_out <= mdio_out;
                        endcase

                        count <= count + 5'd1;

                        if (count==5'd14) begin
                            count <= 5'd16;
                            state <= S_WRITE_ADDR_CL45;
                        end

                    end
                    
                    // Send write data
                    S_WRITE_ADDR_CL45 : begin
                        mdio_out <= cl45_reg_address_latched[count -5'd1];
                        count <= count - 5'd1;
                        if (count==5'd0) begin
                            count <= 5'd0;
                            mdio_out <= 1'b1;     // Output first bit of START word
                            state <= S_PREAMBLE3;
                        end
                    end

                    S_PREAMBLE3 : begin
                        mdio_oen <= 1'b0;
                        mdio_out <= 1'b1;
                        count <= count + 5'd1;
                    
                        if (count==5'd31) begin
                            mdio_oen <= 1'b0;
                            count <= 5'd0;
                            mdio_out <= 1'b0;     // Output first bit of START word
                            state <= S_CTRL_CL45;
                        end
                    end

                    S_CTRL_CL45 : begin
                        //
                        case (count)
                        // Second bit of START word
                        0  : mdio_out <= 1'b0;
                        // OPCODE. 1 then 0 for read, 0 then 1 for write
                        1  : mdio_out <= read_pending;
                        2  : mdio_out <= 1'b1;
                        // PHY address
                        3  : mdio_out <= prt_address_latched[4];
                        4  : mdio_out <= prt_address_latched[3];
                        5  : mdio_out <= prt_address_latched[2];
                        6  : mdio_out <= prt_address_latched[1];
                        7  : mdio_out <= prt_address_latched[0];
                        // Register address
                        8  : mdio_out <= dev_address_latched[4];
                        9  : mdio_out <= dev_address_latched[3];
                        10 : mdio_out <= dev_address_latched[2];
                        11 : mdio_out <= dev_address_latched[1];
                        12 : mdio_out <= dev_address_latched[0];
                        // TA
                        13 : mdio_out <= 1'b1;
                        14 : mdio_out <= 1'b0;
                        default: mdio_out <= mdio_out;
                        endcase

                        count <= count + 5'd1;

                        // For read, turn off output for TA cycle
                        if (count==5'd13 & read_pending)
                            mdio_oen <= 1'b1;

                        if (count==5'd14) begin
                            count <= 5'd0;
                        if (read_pending)
                            state <= S_READ;
                        else
                            state <= S_WRITE;
                        end

                    end

                    // Send write data
                    S_WRITE : begin
                        mdio_out <= data[15];
                        data <= data << 1;
                        count <= count + 5'd1;
                        
                        if (count==5'd15) begin
                            count <= 5'd30;
                            state <= S_PREAMBLE;
                            write_pending <= 1'b0;
                            clause45_reg <= 1'b0;
                        end
                    end

                    // Wait for read data
                    S_READ : begin
                        count <= count + 5'd1;
                        
                        if (count==5'd16) begin
                            count <= 5'd30;
                            state <= S_PREAMBLE;
                            read_pending <= 1'b0;
                            clause45_reg <= 1'b0; 
                        end
                    end

                endcase

            end
        end
    end
    
    
    
    
    //---------------------------------------------------------------------------------------------------
    // Function - Calculates the log2ceil of the input value
    //---------------------------------------------------------------------------------------------------
    function integer log2ceil;
        input integer val;
        integer i;
        
        begin
            i = 1;
            log2ceil = 0;
            
            while (i < val) begin
                log2ceil = log2ceil + 1;
                i = i << 1; 
            end
        end
    endfunction
    
endmodule

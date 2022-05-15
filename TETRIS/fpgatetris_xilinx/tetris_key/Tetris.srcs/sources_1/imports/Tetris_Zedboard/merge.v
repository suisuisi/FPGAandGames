module merge #(
    parameter ROW = 20,
    parameter COL = 10
    )(
    input clk,
    input rst_n,
    input [(ROW+4)*COL-1:0] data_in,
    input [6:0] shape,
    input [3:0] x_pos,
    input [4:0] y_pos,
    output [ROW*COL-1:0] data_out
    );

    // latency = 2 period

    wire [8:0] loc;
    wire [8:0] left;
    wire [8:0] right;
    wire [8:0] up;
    wire [8:0] down;
    wire [8:0] up_left;
    wire [8:0] up_right;
    wire [8:0] down_left;
    wire [8:0] down_right;
    assign loc = y_pos*10+x_pos;
    assign left = loc - 1;
    assign right = loc + 1;
    assign up = loc - COL;
    assign down = loc + COL;
    assign up_left = up - 1;
    assign up_right = up + 1;
    assign down_left = down - 1;
    assign down_right = down + 1;

    localparam  A1 = 7'b0001000,
                B1 = 7'b0011000,
                B2 = 7'b0010100,
                B3 = 7'b0010010,
                B4 = 7'b0010001,
                C1 = 7'b0101000,
                C2 = 7'b0100100,
                C3 = 7'b0100010,
                C4 = 7'b0100001,
                D1 = 7'b0111000,
                D2 = 7'b0110100,
                E1 = 7'b1001000,
                E2 = 7'b1000100,
                E3 = 7'b1000010,
                E4 = 7'b1000001,
                F1 = 7'b1011000,
                F2 = 7'b1010100,
                G1 = 7'b1101000,
                G2 = 7'b1100100;

    reg [ROW*COL-1:0] data;
    reg [(ROW+4)*COL-1:0] merge_data;

    assign data_out = data | data_in[(ROW+4)*COL-1:40];
    //assign data_out = data | data_in[ROW*COL-1:0];
    
    always @ (posedge clk or negedge rst_n)
    begin
        if (!rst_n)
            data <= 0;
        else
            data <= merge_data[(ROW+4)*COL-1:40];
            //  data <= merge_data[ROW*COL-1:0];
    end

    always @ (*)
    begin
        merge_data = 0;
        case (shape)
        A1:
        begin
            merge_data[loc] = 1;
            merge_data[right] = 1;
            merge_data[down] = 1;
            merge_data[down_right] = 1;
        end 
        B1:
        begin
            merge_data[loc] = 1;
            merge_data[up] = 1;
            merge_data[down] = 1;
            merge_data[down_right] = 1;
        end
        B2:
        begin
            merge_data[loc] = 1;
            merge_data[left] = 1;
            merge_data[right] = 1;
            merge_data[up_right] = 1;
        end
        B3:
        begin
            merge_data[loc] = 1;
            merge_data[up] = 1;
            merge_data[up_left] = 1;
            merge_data[down] = 1;
        end
        B4:
        begin
            merge_data[loc] = 1;
            merge_data[left] = 1;
            merge_data[right] = 1;
            merge_data[down_left] = 1;
        end
        C1:
        begin
            merge_data[loc] = 1;
            merge_data[up] = 1;
            merge_data[down] = 1;
            merge_data[down_left] = 1;
        end
        C2:
        begin
            merge_data[loc] = 1;
            merge_data[left] = 1;
            merge_data[right] = 1;
            merge_data[down_right] = 1;
        end
        C3:
        begin
            merge_data[loc] = 1;
            merge_data[up] = 1;
            merge_data[down] = 1;
            merge_data[up_right] = 1;
        end
        C4:
        begin
            merge_data[loc] = 1;
            merge_data[left] = 1;
            merge_data[right] = 1;
            merge_data[up_left] = 1;
        end
        D1:
        begin
            merge_data[loc] = 1;
            merge_data[up] = 1;
            merge_data[down] = 1;
            merge_data[down+COL] = 1;
        end
        D2:
        begin
            merge_data[loc] = 1;
            merge_data[left] = 1;
            merge_data[right] = 1;
            merge_data[right+1] = 1;
        end
        E1:
        begin
            merge_data[loc] = 1;
            merge_data[left] = 1;
            merge_data[right] = 1;
            merge_data[up] = 1;
        end
        E2:
        begin
            merge_data[loc] = 1;
            merge_data[left] = 1;
            merge_data[down] = 1;
            merge_data[up] = 1;
        end
        E3:
        begin
            merge_data[loc] = 1;
            merge_data[down] = 1;
            merge_data[right] = 1;
            merge_data[left] = 1;
        end
        E4:
        begin
            merge_data[loc] = 1;
            merge_data[up] = 1;
            merge_data[down] = 1;
            merge_data[right] = 1;
        end
        F1:
        begin
            merge_data[loc] = 1;
            merge_data[up_right] = 1;
            merge_data[down] = 1;
            merge_data[right] = 1;
        end
        F2:
        begin
            merge_data[loc] = 1;
            merge_data[up] = 1;
            merge_data[up_left] = 1;
            merge_data[right] = 1;
        end
        G1:
        begin
            merge_data[loc] = 1;
            merge_data[up] = 1;
            merge_data[right] = 1;
            merge_data[down_right] = 1;
        end
        G2:
        begin
            merge_data[loc] = 1;
            merge_data[left] = 1;
            merge_data[up] = 1;
            merge_data[up_right] = 1;
        end
        default merge_data = 0;
        endcase
    end


endmodule

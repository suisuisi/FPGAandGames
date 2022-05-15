module Datapath_Unit #(
    parameter   A_1 = 7'b0001000,
                B_1 = 7'b0011000,
                B_2 = 7'b0010100,
                B_3 = 7'b0010010,
                B_4 = 7'b0010001,
                C_1 = 7'b0101000,
                C_2 = 7'b0100100,
                C_3 = 7'b0100010,
                C_4 = 7'b0100001,
                D_1 = 7'b0111000,
                D_2 = 7'b0110100,
                E_1 = 7'b1001000,
                E_2 = 7'b1000100,
                E_3 = 7'b1000010,
                E_4 = 7'b1000001,
                F_1 = 7'b1011000,
                F_2 = 7'b1010100,
                G_1 = 7'b1101000,
                G_2 = 7'b1100100
    )(
    output reg MOVE_ABLE,SHIFT_FINISH,DOWN_ABLE,DIE_TRUE,
    output     [239:0] M_OUT,
    output reg [4:0] n,
    output reg [3:0] m,
    output reg [6:0] BLOCK,
    //output reg REMOVE_1_FINISH,
    output reg REMOVE_2_FINISH,
    //output reg NEW_BLOCK,
   
    input clk,rst_n,MOVE,DOWN,DIE,SHIFT,REMOVE_1,REMOVE_2,NEW,STOP,AUTODOWN,
    input [3:0] KEYBOARD
    );

    reg [2:0] RAN;
    reg [9:0] R [23:0];
    reg [6:0] NEW_BLOCK;
    reg [6:0] BLOCK_P;
    reg [4:0] remove_cnt;
    reg [3:0] REMOVE_2_S;
    reg [3:0] REMOVE_FINISH;
    reg [4:0] REMOVE_2_C;
    reg       SIG;

    always @ (posedge clk or negedge rst_n)
    begin
        if (!rst_n) 
            RAN<=0;
        else if (RAN==7) RAN<=1;
        else RAN<=RAN+1;
    end 

    // MOVE_ABLE signal
    always @ (*)
    begin
     //   if (!rst_n)
        MOVE_ABLE = 0;
        if (MOVE)
        begin
            if (KEYBOARD[0])  //UP
            begin
               // MOVE_ABLE=1;
                case (BLOCK)
                A_1: MOVE_ABLE=0;
                B_1: if (m>=1)
                        begin if (!((R[n][m-1])|(R[n][m+1])|(R[n-1][m+1]))) MOVE_ABLE=1; else MOVE_ABLE=0;end
                B_2: if (n<=22)
                        begin if (!((R[n+1][m-1])|(R[n+1][m])|(R[n-1][m]))) MOVE_ABLE=1; else MOVE_ABLE=0;end
                B_3: if (m<=8)
                        begin if (!(R[n][m-1] | R[n][m+1] | R[n+1][m-1])) MOVE_ABLE=1; else MOVE_ABLE=0;      end   
                B_4:    begin if (!((R[n-1][m])|(R[n+1][m])|(R[n+1][m+1]))) MOVE_ABLE=1; else MOVE_ABLE=0;end
                C_1: if (m<=8)
                        begin if (!((R[n][m-1])|(R[n][m+1])|(R[n+1][m+1]))) MOVE_ABLE=1; else MOVE_ABLE=0;end
                C_2:    begin if (!((R[n-1][m])|(R[n-1][m+1])|(R[n-1][m]))) MOVE_ABLE=1; else MOVE_ABLE=0;end
                C_3: if (m>=1)
                        begin if (!((R[n-1][m-1])|(R[n][m-1])|(R[n][m+1]))) MOVE_ABLE=1; else MOVE_ABLE=0;end
                C_4: if (n<=22)
                        begin if (!((R[n-1][m])|(R[n+1][m-1])|(R[n+1][m]))) MOVE_ABLE=1; else MOVE_ABLE=0;end
                D_1: if ((m>=1)&(m<=7))
                        begin if (!((R[n][m-1])|(R[n][m+1])|(R[n][m+2]))) MOVE_ABLE=1; else MOVE_ABLE=0;end
                D_2: if (n<=21)
                        begin if (!((R[n-1][m])|(R[n+1][m])|(R[n+2][m]))) MOVE_ABLE=1; else MOVE_ABLE=0;end
                E_1: if (n<=22)
                        begin if (!(R[n+1][m])) MOVE_ABLE=1; else MOVE_ABLE=0;end
                E_2: if (m<=8)
                        begin if (!(R[n][m+1])) MOVE_ABLE=1; else MOVE_ABLE=0;end
                E_3:    begin if (!(R[n-1][m])) MOVE_ABLE=1; else MOVE_ABLE=0;end
                E_4: if (m>=1)
                        begin if (!(R[n][m-1])) MOVE_ABLE=1; else MOVE_ABLE=0;end
                F_1: if (m>=1)
                        begin if (!((R[n-1][m-1])|(R[n-1][m]))) MOVE_ABLE=1; else MOVE_ABLE=0;end
                F_2: if (n<=22)
                        begin if (!((R[n-1][m+1])|(R[n+1][m]))) MOVE_ABLE=1; else MOVE_ABLE=0;end
                G_1: if (m>=1)
                        begin if (!((R[n-1][m+1])|(R[n][m-1]))) MOVE_ABLE=1; else MOVE_ABLE=0;end
                G_2: if (n<=22)
                        begin if (!((R[n][m+1])|(R[n+1][m+1]))) MOVE_ABLE=1; else MOVE_ABLE=0;end
                default MOVE_ABLE=0;
                endcase 
            end
            else if (KEYBOARD[2])  //LEFT
            begin
             //     MOVE_ABLE<=0;
                case (BLOCK)
                A_1: if (m>=1) if (!((R[n+1][m-1])|(R[n][m-1]))) MOVE_ABLE=1; else MOVE_ABLE=0;
                B_1: if (m>=1) if (!((R[n-1][m-1])|(R[n][m-1])|(R[n+1][m-1]))) MOVE_ABLE=1; else MOVE_ABLE=0;
                B_2: if (m>=2) if (!((R[n][m-1])|(R[n-1][m]))) MOVE_ABLE=1; else MOVE_ABLE=0;
                B_3: if (m>=2) if (!((R[n-1][m-2])|(R[n][m-1])|(R[n+1][m-1]))) MOVE_ABLE=1; else MOVE_ABLE=0;
                B_4: if (m>=2) if (!((R[n][m-2])|(R[n+1][m-2]))) MOVE_ABLE=1; else MOVE_ABLE=0;
                C_1: if (m>=2) if (!((R[n-1][m-1])|(R[n][m-1])|(R[n+1][m-2]))) MOVE_ABLE=1; else MOVE_ABLE=0;
                C_2: if (m>=2) if (!((R[n][m-2])|(R[n+1][m]))) MOVE_ABLE=1; else MOVE_ABLE=0;
                C_3: if (m>=1) if (!((R[n-1][m-1])|(R[n][m-1])|(R[n+1][m-1]))) MOVE_ABLE=1; else MOVE_ABLE=0;
                C_4: if (m>=2) if (!((R[n-1][m-2])|(R[n][m-2]))) MOVE_ABLE=1; else MOVE_ABLE=0;
                D_1: if (m>=1) if (!((R[n-1][m-1])|(R[n][m-1])|(R[n+1][m-1])|(R[n+2][m-1]))) MOVE_ABLE=1; else MOVE_ABLE=0;
                D_2: if (m>=2) if (!(R[n][m-2])) MOVE_ABLE=1; else MOVE_ABLE=0;
                E_1: if (m>=2) if (!((R[n-1][m-1])|(R[n][m-2]))) MOVE_ABLE=1; else MOVE_ABLE=0;
                E_2: if (m>=2) if (!((R[n-1][m-1])|(R[n][m-2])|(R[n+1][m-1])))    MOVE_ABLE=1; else MOVE_ABLE=0;
                E_3: if (m>=2) if (!((R[n][m-2])|(R[n+1][m-1]))) MOVE_ABLE=1; else   MOVE_ABLE=0;
                E_4: if (m>=1) if (!((R[n-1][m-1])|(R[n][m-1])|(R[n+1][m-1])))    MOVE_ABLE=1; else MOVE_ABLE=0;
                F_1: if (m>=1) if (!((R[n-1][m])|(R[n][m-1])|(R[n+1][m-1])))  MOVE_ABLE=1; else MOVE_ABLE=0;
                F_2: if (m>=2) if (!((R[n-1][m-2])|(R[n][m-1]))) MOVE_ABLE=1; else   MOVE_ABLE=0;
                G_1: if (m>=1) if (!((R[n-1][m-1])|(R[n][m-1])|(R[n+1][m-1])))    MOVE_ABLE=1; else MOVE_ABLE=0;
                G_2: if (m>=2) if (!((R[n-1][m-1])|(R[n][m-2]))) MOVE_ABLE=1; else   MOVE_ABLE=0;
                default MOVE_ABLE=0;
                endcase
            end
            else if (KEYBOARD[3])  //RIGHT
            begin
                //MOVE_ABLE=1;   
                case (BLOCK)
                A_1: if (m<=7) if (!((R[n+1][m+2])|(R[n][m+2]))) MOVE_ABLE=1; else   MOVE_ABLE=0;
                B_1: if (m<=7) if (!((R[n+1][m+2])|(R[n][m+1])|(R[n-1][m+1])))    MOVE_ABLE=1; else MOVE_ABLE=0;
                B_2: if (m<=7) if (!((R[n][m+2])|(R[n+1][m+2]))) MOVE_ABLE=1; else   MOVE_ABLE<=0;
                B_3: if (m<=8) if (!((R[n-1][m+1])|(R[n][m+1])|(R[n+1][m+1])))    MOVE_ABLE=1; else MOVE_ABLE=0;
                B_4: if (m<=7) if (!((R[n][m+2])|(R[n+1][m]))) MOVE_ABLE=1; else     MOVE_ABLE=0;
                C_1: if (m<=8) if (!((R[n-1][m+1])|(R[n][m+1])|(R[n+1][m+1])))    MOVE_ABLE=1; else MOVE_ABLE=0;
                C_2: if (m<=7) if (!((R[n-1][m+2])|(R[n][m+2]))) MOVE_ABLE=1; else   MOVE_ABLE=0;
                C_3: if (m<=7) if (!((R[n-1][m+2])|(R[n][m+1])|(R[n+1][m+1])))    MOVE_ABLE=1; else MOVE_ABLE=0;
                C_4: if (m<=7) if (!((R[n-1][m])|(R[n][m+2]))) MOVE_ABLE=1; else     MOVE_ABLE=0;
                D_1: if (m<=8) if (!((R[n-1][m+1])|(R[n][m+1])|(R[n+1][m+1])|(R[n+2][m+1]))) MOVE_ABLE=1; else MOVE_ABLE=0;
                D_2: if (m<=6) if (!(R[n][m+3])) MOVE_ABLE=1; else MOVE_ABLE=0;
                E_1: if (m<=7) if (!((R[n-1][m+1])|(R[n][m+2]))) MOVE_ABLE=1; else   MOVE_ABLE=0;
                E_2: if (m<=8) if (!((R[n-1][m+1])|(R[n][m+1])|(R[n+1][m+1])))    MOVE_ABLE=1; else MOVE_ABLE=0;
                E_3: if (m<=7) if (!((R[n][m+2])|(R[n+1][m+1]))) MOVE_ABLE=1; else   MOVE_ABLE=0;
                E_4: if (m<=7) if (!((R[n-1][m+1])|(R[n][m+2])|(R[n+1][m+1])))    MOVE_ABLE=1; else MOVE_ABLE=0;
                F_1: if (m<=7) if (!((R[n-1][m+2])|(R[n][m+2])|(R[n+1][m+1])))    MOVE_ABLE=1; else MOVE_ABLE=0;
                F_2: if (m<=7) if (!((R[n-1][m+1])|(R[n][m+2]))) MOVE_ABLE=1; else   MOVE_ABLE=0;
                G_1: if (m<=7) if (!((R[n-1][m+1])|(R[n][m+2])|(R[n+1][m+2])))    MOVE_ABLE=1; else MOVE_ABLE=0;
                G_2: if (m<=7) if (!((R[n-1][m+2])|(R[n][m+1]))) MOVE_ABLE=1; else   MOVE_ABLE=0;
                default MOVE_ABLE=0;
                endcase
            end
        end
        else
            MOVE_ABLE = 0;
    end

    // M_OUT
    assign M_OUT = {R[23],R[22],R[21],R[20],R[19],R[18],R[17],R[16],R[15],R[14],R[13],R[12],R[11],R[10],R[9],R[8],R[7],R[6],R[5],R[4],R[3],R[2],R[1],R[0]};

    // R
    integer i,j;
    always @ (posedge clk or negedge rst_n)
    begin
        if (!rst_n)
            begin
                for (i = 0; i < 24; i = i + 1) R[i] <= 0;
                REMOVE_FINISH<=0;
            end
        else if (REMOVE_1)
        begin
            case (BLOCK)
            A_1: begin R[n][m]<=1;R[n][m+1]<=1;R[n+1][m]<=1;R[n+1][m+1]<=1;end
            B_1: begin R[n-1][m]<=1;R[n][m]<=1;R[n+1][m]<=1;R[n+1][m+1]<=1;end
            B_2: begin R[n-1][m+1]<=1;R[n][m-1]<=1;R[n][m]<=1;R[n][m+1]<=1;end
            B_3: begin R[n-1][m-1]<=1;R[n-1][m]<=1;R[n][m]<=1;R[n+1][m]<=1;end 
            B_4: begin R[n][m-1]<=1;R[n][m]<=1;R[n][m+1]<=1;R[n+1][m-1]<=1;end
            C_1: begin R[n-1][m]<=1;R[n][m]<=1;R[n+1][m]<=1;R[n+1][m-1]<=1;end
            C_2: begin R[n][m-1]<=1;R[n][m]<=1;R[n][m+1]<=1;R[n+1][m+1]<=1;end
            C_3: begin R[n-1][m]<=1;R[n-1][m+1]<=1;R[n][m]<=1;R[n+1][m]<=1;end
            C_4: begin R[n-1][m-1]<=1;R[n][m-1]<=1;R[n][m]<=1;R[n][m+1]<=1;end
            D_1: begin R[n-1][m]<=1;R[n][m]<=1;R[n+1][m]<=1;R[n+2][m]<=1;end
            D_2: begin R[n][m-1]<=1;R[n][m]<=1;R[n][m+1]<=1;R[n][m+2]<=1;end
            E_1: begin R[n-1][m]<=1;R[n][m-1]<=1;R[n][m]<=1;R[n][m+1]<=1;end
            E_2: begin R[n-1][m]<=1;R[n][m-1]<=1;R[n][m]<=1;R[n+1][m]<=1;end
            E_3: begin R[n][m-1]<=1;R[n][m]<=1;R[n][m+1]<=1;R[n+1][m]<=1;end
            E_4: begin R[n-1][m]<=1;R[n][m]<=1;R[n][m+1]<=1;R[n+1][m]<=1;end
            F_1: begin R[n-1][m+1]<=1;R[n][m]<=1;R[n][m+1]<=1;R[n+1][m]<=1;end
            F_2: begin R[n-1][m-1]<=1;R[n-1][m]<=1;R[n][m]<=1;R[n][m+1]<=1;end
            G_1: begin R[n-1][m]<=1;R[n][m]<=1;R[n][m+1]<=1;R[n+1][m+1]<=1;end
            G_2: begin R[n-1][m]<=1;R[n-1][m+1]<=1;R[n][m-1]<=1;R[n][m]<=1;end
            default
            begin
                for (i = 0; i < 24; i = i + 1)
                    R[i] <= R[i];
            end
            endcase
            REMOVE_2_S<=4'b1111;
        end
//        else if (REMOVE_2)
//        begin
//            case (remove_cnt)
//            3'd0: if (&R[n-2]) for (i=1; i<=n-2; i=i+1) R[i] <= R[i-1];
//            3'd1: if (&R[n-1]) for (i=1; i<=n-1; i=i+1) R[i] <= R[i-1];
//            3'd2: if (&R[n]) for (i=1; i<=n; i=i+1) R[i] <= R[i-1];
//            3'd3: if (&R[n+1]) for (i=1; i<=n+1; i=i+1) R[i] <= R[i-1];
//            3'd4: if (&R[n+2]) for (i=1; i<=n+2; i=i+1) R[i] <= R[i-1];
//            default for (i=0; i<24; i = i + 1) R[i] <= R[i];
//            endcase
 //             for (i=0; i<23; i=i+10)
 //               if (&R[i])
//                    for (j=i; j>=1; j=j-1)
 //                       R[j] <= R[j-1]; 
//        end

//    end
        else if (REMOVE_2)
        begin
            if (!REMOVE_FINISH[0])
            begin if ((&R[n-1])|(SIG))
                begin
                    if (REMOVE_2_S[0]) begin REMOVE_2_C<=n-1; REMOVE_2_S[0]<=0; SIG<=1;end
                    else begin
                        if (REMOVE_2_C>=1) begin R[REMOVE_2_C]<=R[REMOVE_2_C-1]; REMOVE_2_C<=REMOVE_2_C-1; SIG<=1;end
                        else begin REMOVE_FINISH[0]<=1;SIG<=0;end
                    end
                end
            else begin REMOVE_FINISH[0]<=1; SIG<=0; end
            end    
            else if (!REMOVE_FINISH[1])
            begin if ((&R[n])|(SIG))
                begin
                    if (REMOVE_2_S[1]) begin REMOVE_2_C<=n; REMOVE_2_S[1]<=0; SIG<=1; end
                    else begin
                        if (REMOVE_2_C>=1) begin R[REMOVE_2_C]<=R[REMOVE_2_C-1]; REMOVE_2_C<=REMOVE_2_C-1; SIG<=1; end
                        else begin REMOVE_FINISH[1]<=1; SIG<=0; end
                    end
                end
            else begin REMOVE_FINISH[1]<=1; SIG<=0; end
            end
            else if (!REMOVE_FINISH[2])
            begin
            if (n<=22)
                begin if ((&R[n+1])|(SIG))
                    begin
                        if (REMOVE_2_S[2]) begin REMOVE_2_C<=n+1; REMOVE_2_S[2]<=0;SIG<=1; end
                        else begin
                            if (REMOVE_2_C>=1) begin R[REMOVE_2_C]<=R[REMOVE_2_C-1]; REMOVE_2_C<=REMOVE_2_C-1; SIG<=1; end
                            else begin REMOVE_FINISH[2]<=1; SIG<=0; end
                        end
                    end
                    else begin REMOVE_FINISH[2]<=1; SIG<=0; end
                end
            else begin REMOVE_FINISH[2]<=1; SIG<=0; end
            end    
            else if (!REMOVE_FINISH[3])
            begin
            if (n<=21)
                begin if ((&R[n+2])|(SIG))
                    begin
                        if (REMOVE_2_S[3]) begin REMOVE_2_C<=n+2; REMOVE_2_S[3]<=0; SIG<=1; end
                        else begin
                            if (REMOVE_2_C>=1) begin R[REMOVE_2_C]<=R[REMOVE_2_C-1]; REMOVE_2_C<=REMOVE_2_C-1; SIG<=1; end
                            else begin REMOVE_FINISH[3]<=1; SIG<=1; end
                        end
                    end
                    else begin REMOVE_FINISH[3]<=1; SIG<=0; end
                end
           else begin REMOVE_FINISH[3]<=1; SIG<=0; end    
           end
          else
            begin
            for (i=0; i <24; i = i + 1) R[i] <= R[i];
            REMOVE_FINISH<=0;
            SIG<=0;
            end
     end
     else if (STOP) for (i=0;i<=23;i=i+1) R[i]<=0;
end

    //BLOCK_P
    always @ (*)
    begin
        case (BLOCK)
        A_1: BLOCK_P = A_1;
        B_1: BLOCK_P = B_2;
        B_2: BLOCK_P = B_3;
        B_3: BLOCK_P = B_4;
        B_4: BLOCK_P = B_1;
        C_1: BLOCK_P = C_2;
        C_2: BLOCK_P = C_3;
        C_3: BLOCK_P = C_4;
        C_4: BLOCK_P = C_1;
        D_1: BLOCK_P = D_2;
        D_2: BLOCK_P = D_1;
        E_1: BLOCK_P = E_2;
        E_2: BLOCK_P = E_3;
        E_3: BLOCK_P = E_4;
        E_4: BLOCK_P = E_1;
        F_1: BLOCK_P = F_2;
        F_2: BLOCK_P = F_1;
        G_1: BLOCK_P = G_2;
        G_2: BLOCK_P = G_1;
        default BLOCK_P = 7'b0000000;
        endcase
    end

    // BLOCK
    always @ (posedge clk or negedge rst_n)
    begin
        if (!rst_n)
            BLOCK <= 7'b0000000;
        else if (NEW)
            BLOCK <= NEW_BLOCK;
        else if (SHIFT && KEYBOARD[0])
            BLOCK <= BLOCK_P;
        else
            BLOCK <= BLOCK;
    end

    // DOWN_ABLE
    always @ (*)
    begin
      //  if (!rst_n)
        DOWN_ABLE = 0;
        if (DOWN)
        begin
            //DOWN_ABLE<=1;
            case (BLOCK)
            A_1: if (n<=21) begin if (!(R[n+2][m] | R[n+2][m+1])) DOWN_ABLE = 1; else DOWN_ABLE = 0; end else DOWN_ABLE=0;
            B_1: if (n<=21) begin if (!(R[n+2][m] | R[n+2][m+1])) DOWN_ABLE = 1; else DOWN_ABLE = 0; end else DOWN_ABLE=0;
            B_2: if (n<=22) begin if (!(R[n+1][m] | R[n+1][m-1] | R[n+1][m+1])) DOWN_ABLE = 1; else DOWN_ABLE = 0; end else DOWN_ABLE=0;
            B_3: if (n<=21) begin if (!(R[n+2][m] | R[n][m-1])) DOWN_ABLE = 1; else DOWN_ABLE = 0; end else DOWN_ABLE=0;
            B_4: if (n<=21) begin if (!(R[n+1][m] | R[n+1][m+1] | R[n+2][m-1])) DOWN_ABLE = 1; else DOWN_ABLE = 0; end else DOWN_ABLE=0;
            C_1: if (n<=21) begin if (!(R[n+2][m] | R[n+2][m-1])) DOWN_ABLE = 1; else DOWN_ABLE = 0; end else DOWN_ABLE=0;
            C_2: if (n<=21) begin if (!(R[n+1][m] | R[n+1][m-1] | R[n+2][m+1])) DOWN_ABLE = 1; else DOWN_ABLE = 0; end else DOWN_ABLE=0;
            C_3: if (n<=21) begin if (!(R[n+2][m] | R[n][m+1])) DOWN_ABLE = 1; else DOWN_ABLE = 0; end else DOWN_ABLE=0;
            C_4: if (n<=22) begin if (!(R[n+1][m] | R[n+1][m-1] | R[n+1][m+1])) DOWN_ABLE = 1; else DOWN_ABLE = 0; end else DOWN_ABLE=0;
            D_1: if (n<=20) begin if (!(R[n+3][m])) DOWN_ABLE = 1; else DOWN_ABLE = 0; end else DOWN_ABLE=0;
            D_2: if (n<=22) begin if (!(R[n+1][m] | R[n+1][m-1] | R[n+1][m+1] | R[n+1][m+1])) DOWN_ABLE = 1; else DOWN_ABLE = 0; end else DOWN_ABLE=0;
            E_1: if (n<=22) begin if (!(R[n+1][m] | R[n+1][m-1] | R[n+1][m+1])) DOWN_ABLE = 1; else DOWN_ABLE = 0; end else DOWN_ABLE=0;
            E_2: if (n<=21) begin if (!(R[n+2][m] | R[n+1][m-1])) DOWN_ABLE = 1; else DOWN_ABLE = 0; end else DOWN_ABLE=0;
            E_3: if (n<=21) begin if (!(R[n+2][m] | R[n+1][m-1] | R[n+1][m+1])) DOWN_ABLE = 1; else DOWN_ABLE = 0; end else DOWN_ABLE=0;
            E_4: if (n<=21) begin if (!(R[n+2][m] | R[n+1][m+1])) DOWN_ABLE = 1; else DOWN_ABLE = 0; end else DOWN_ABLE=0;
            F_1: if (n<=21) begin if (!(R[n+2][m] | R[n+1][m+1])) DOWN_ABLE = 1; else DOWN_ABLE = 0; end else DOWN_ABLE=0;
            F_2: if (n<=22) begin if (!(R[n+1][m] | R[n][m-1] | R[n+1][m+1])) DOWN_ABLE = 1; else DOWN_ABLE = 0; end else DOWN_ABLE=0;
            G_1: if (n<=21) begin if (!(R[n+1][m] | R[n+2][m+1])) DOWN_ABLE = 1; else DOWN_ABLE = 0; end else DOWN_ABLE=0;
            G_2: if (n<=22) begin if (!(R[n+1][m] | R[n+1][m-1] | R[n][m+1])) DOWN_ABLE = 1; else DOWN_ABLE = 0; end else DOWN_ABLE=0;
            default DOWN_ABLE = 0;
            endcase
        end
        else
            DOWN_ABLE = 0;
    end

    // n
    always @ (posedge clk or negedge rst_n)
    begin
        if (!rst_n)
            n <= 0;
        else if (NEW)
            n <= 1;
        else if ((SHIFT)&(AUTODOWN))
            n<=n+1;
        else if ((SHIFT)&(KEYBOARD[1]))
            n <= n + 1;
        else
            n <= n;
    end

    // m
    always @ (posedge clk or negedge rst_n)
    begin
        if (!rst_n)
            m <= 0;
        else if (NEW)
            m <= 5;
        else if (SHIFT)
        begin
            if (AUTODOWN) m<=m;
            else if (KEYBOARD[2])
                m <= m - 1;
            else if (KEYBOARD[3])
                m <= m + 1;
            else
                m <= m;
        end
        else
            m <= m;
    end

    // NEW_BLOCK
    always @(*)
    begin
        if (!rst_n)
            NEW_BLOCK = A_1;
        else if (NEW)
        begin
            case (RAN)
            1: NEW_BLOCK = A_1;
            2: NEW_BLOCK = B_1;
            3: NEW_BLOCK = C_1;
            4: NEW_BLOCK = D_1;
            5: NEW_BLOCK = E_1;
            6: NEW_BLOCK = F_1;
            7: NEW_BLOCK = G_1;
            default NEW_BLOCK = A_1;
            endcase
        end
        else
            NEW_BLOCK = A_1;
    end

    // SHIFT_FINISH
    always @(posedge clk or negedge rst_n)
    begin
        if (!rst_n)
            SHIFT_FINISH <= 0;
        else if (SHIFT)
            SHIFT_FINISH <= 1;
        else
            SHIFT_FINISH <= 0;
    end

    // REMOVE_1_FINISH
//        always @(posedge clk or negedge rst_n)
//        begin
//            if (!rst_n)
//                REMOVE_1_FINISH <= 0;
//            else if (REMOVE_1)
//                REMOVE_1_FINISH <= 1;
//            else
//                REMOVE_1_FINISH <= 0;
//        end1

    // REMOVE_2_FINISH
    always @(posedge clk or negedge rst_n)
    begin
        if (!rst_n)
            REMOVE_2_FINISH <= 0;
        else if (&REMOVE_FINISH)
            REMOVE_2_FINISH <= 1;
        else
            REMOVE_2_FINISH <= 0;
    end

    // remove_cnt
    always @(posedge clk or negedge rst_n)
    begin
        if (!rst_n)
            remove_cnt <= 0;
        else if ((remove_cnt < 23) && (REMOVE_2 == 1))
            remove_cnt <= remove_cnt + 1;
        else
            remove_cnt <= 0;
    end

    // DIE_TRUE
    always @(*)
    begin
       if (DIE) begin
            if (|R[3]) DIE_TRUE = 1;
            else DIE_TRUE = 0;
       end
       else DIE_TRUE=0;
    end
    

endmodule

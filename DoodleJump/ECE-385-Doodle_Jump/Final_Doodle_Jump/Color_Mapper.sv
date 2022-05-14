//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  10-06-2017                               --
//                                                                       --
//    Fall 2017 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------
//    Modified by Yuhao Ge & Haina Lou                                   --
//-------------------------------------------------------------------------


// color_mapper: Decide which color to be output to VGA for each pixel.
module  color_mapper ( input         is_ball, is_stair, is_doodle, is_monster, is_bullet, is_tool, // Whether current pixel belongs to ball 
                       input 			 Clk, frame_clk, Reset,        
                       input        [9:0]  Ball_X_Pos, Ball_Y_Pos,
                       input  [13:0][9:0]  stair_x, stair_y,
                       input [9:0] monster_x, monster_y,
                       input [9:0] monster_size_x, monster_size_y,
                       input active, death, drop,
                       input [13:0][9:0] tool_x, tool_y, tool_size,
                       input [15:0] keycode,
                       input [2:0] show,
                       input [31:0] tot_distance,
                       input [1:0] doodle_state,
                       input logic is_score,

                       input        [9:0] DrawX, DrawY,       // Current pixel coordinates
                       output logic [7:0] VGA_R, VGA_G, VGA_B // VGA RGB output
                       
                     );

    
    logic [7:0] Red, Green, Blue;
    
    // Output colors to VGA
    assign VGA_R = Red;
    assign VGA_G = Green;
    assign VGA_B = Blue;
    

 // Assign(load) doodle sprite and stairs
    logic [10:0] d_addr,dl_addr;
    logic [11:0]dup_addr;
	 logic [13:0][18:0] st_addr;
	 logic [9:0] st_addr_min;
    logic [18:0] back_addr;
    parameter height = 35;
    parameter width = 35;
    parameter sheight = 10;
    parameter swidth = 40;

    parameter upheight = 49;
    parameter upwidth = 49;

    int hfheight,hfwidth,dx,dy,mid_addr;
    int shfheight,shfwidth,smid_addr;
    int uphfheight,uphfwidth,upmid_addr,updx,updy;

	 int sdx0,sdx1,sdx2,sdx3,sdx4,sdx5,sdx6,sdx7,sdx8,sdx9,sdx10,sdx11,sdx12,sdx13;
	 int sdy0,sdy1,sdy2,sdy3,sdy4,sdy5,sdy6,sdy7,sdy8,sdy9,sdy10,sdy11,sdy12,sdy13;
	 
    logic[3:0] d_palt,s_palt,back_palt,dl_palt,dup_palt, ms_palt,tl1_palt;
    logic[23:0] RGBdoodle,RGBdoodlel,RGBdoodleup, RGBstair,RGBback,RGBms,RGBtl;

    // logic[1:0]doodle_state;
	
//		logic check;
//	always_ff @( posedge Clk)
//	begin 
//		if (Reset)
//			check <= 0;
//		else if (death||drop)
//			check <= 1;
//		else 
//			check <= check;
//	
//	end




    always_comb 
    begin 
        hfheight = (height-1)/2;
        hfwidth = (width-1)/2;
        shfheight = sheight/2;
        shfwidth = swidth/2;
        dx = DrawX - Ball_X_Pos;
        dy = DrawY - Ball_Y_Pos;
        mid_addr = (hfheight) * width + hfwidth;
        d_addr = mid_addr + dy * width + dx;
        dl_addr = mid_addr + dy * width + dx; 


        uphfheight = (upheight-1)/2;
        uphfwidth = (upwidth-1)/2;
        updx = DrawX - Ball_X_Pos;
        updy = DrawY - Ball_Y_Pos;
        upmid_addr = (uphfheight) * upwidth + uphfwidth;
        dup_addr = upmid_addr + updy * upwidth + updx;


        smid_addr = (shfheight-1) * swidth + shfwidth;
		  
		  for (int j=0;j<14; j++)
				begin
				    st_addr[j] = smid_addr + int'(DrawY - stair_y[j]) * swidth + int'(DrawX - stair_x[j]);  
				end
		  
		  st_addr_min = 0 ;
		  
		  for (int i=0; i<14; i++)
				if (st_addr[i] < 400)
				begin
					st_addr_min = st_addr[i];
					break;
				end
				else
					begin
					st_addr_min = 0;
					end
		

        back_addr = (100 * DrawY + DrawX-160)%12000 ;
    end

	// Assign(load) monster
    int msdx,msdy;
    logic [9:0]mid_msaddr, ms_addr;

    //monster address
    always_comb begin : monster
    mid_msaddr = monster_size_y * (2*monster_size_x+1) + monster_size_x;
    msdx = DrawX - monster_x;
    msdy = DrawY - monster_y;
    ms_addr = msdy*(2*monster_size_x+1) + msdx+ mid_msaddr;       
    end 


    // Assign(load) monster
    int tldx,tldy,tl_addr_min,temp;
    int tool1 = 7; //15*15 size
    logic [9:0]mid_tladdr, tl1_addr_min;
    logic [13:0][9:0]tl1_addr;

    //tool address
    
    always_comb begin : tool
    mid_tladdr = tool1 * (2*tool1+1) + tool1;
    // for (int s=0; s<14;s++)
    //     begin
    //         tldx = DrawX - tool_x[s];
    //         tldy = DrawY - tool_y[s];
    //         tl1_addr[s] = tldy*(2*tool1+1) + tldx + mid_tladdr; 
            // if (temp > 1000 || temp < 0)
            //     tl1_addr[i] = 1000;
            // else
            //     tl1_addr[i] = temp;



    for (int j=0;j<14; j++)
        begin
            if (tool_size[j]!=0)
                tl1_addr[j] = mid_tladdr + int'(DrawY - tool_y[j]) * (2*tool1+1) + int'(DrawX - tool_x[j]); 
            else
                tl1_addr[j] = 500; 
        end
    tl1_addr_min = 0 ;
		  
    for (int k=0; k<14; k++)
        if (tl1_addr[k] < (2*tool1+1)*(2*tool1+1))
        begin
            tl1_addr_min = tl1_addr[k];
            break;
        end
        else
            begin
            tl1_addr_min = 0;
            end
    end

    //record score 
    // logic is_score;
    // logic [10:0] scorex = 200;
    // logic [10:0] new_scorex;
    // logic [10:0] scorey = 50;
    // logic [10:0] score_addr;
    // int score,score_sing,score_ten,score_hund,score_thous;
    // logic [7:0] score_data;


    // assign out_score = score;
    // always_comb 
    // begin 
    // score = int'(tot_distance/500);
    // if (score < 10'd10 && DrawY >=scorey &&DrawY <= scorey + 10'd16 && DrawX >=scorex &&DrawX < scorex + 10'd8 )
    //     begin
    //         new_scorex = scorex;
    //         score_ten = 0;
    //         score_sing = 0;
    //         score_addr = (8'h2f+1) * 16 + score*16 + DrawY-scorey;
    //         score_on = 1'b1;
    //     end
    // else if(score < 10'd100 && score >= 10'd10 ) 
    //     begin
    //         if (DrawY >=scorey &&DrawY <= scorey + 10'd16 && DrawX >=scorex &&DrawX < scorex + 10'd8)
    //         begin
    //             new_scorex = scorex;
    //             score_sing = 0;
    //             score_ten = int'(score/10);
    //             score_addr = (8'h2f+1) * 10'd16 + score_ten*10'd16 + DrawY-scorey;
    //             score_on = 1'b1;                
    //         end
    //         else if (DrawY >=scorey &&DrawY <= scorey + 16 && DrawX >=scorex+10 &&DrawX < scorex + 10'd18)
    //         begin
    //             new_scorex = scorex + 10'd10;
    //             score_ten = int'(score/10);
    //             score_sing = score - 10*score_ten;
    //             score_addr = (8'h2f+1) * 10'd16 + score_sing*10'd16 + DrawY-scorey;
    //             score_on = 1'b1; 
    //         end
    //         else
    //             new_scorex = scorex;
    //             score_addr = 11'b0;
    //             score_on = 1'b0; 
    //             score_ten = 0;
    //             score_sing = 0;        
    //     end
    // else
    // begin
    //     new_scorex = scorex;
    //     score_addr = 11'b0;
    //     score_on = 1'b0; 
    //     score_ten = 0;
    //     score_sing = 0;
    // end
             
    // end

    int start_addr;
    assign start_addr = 300*DrawY+DrawX-160;


    logic [18:0]start1_addr,start2_addr,start3_addr,start4_addr;
    logic [3:0]start1_palt,start2_palt,start3_palt,start4_palt;
    logic [23:0]RGB_start1,RGB_start2,RGB_start3,RGB_start4;


    logic [18:0]dead1_addr,dead2_addr,dead3_addr,dead4_addr;
    logic [3:0]dead1_palt,dead2_palt,dead3_palt,dead4_palt;
    logic [23:0]RGB_dead1,RGB_dead2,RGB_dead3,RGB_dead4;
    always_comb 
    begin
        if (DrawX < 10'd160 || DrawX > 10'd460)
        begin
            // Background with nice color gradient
            Red = 8'h00; 
            Green = 8'h00;
            Blue = 8'h00;
        end
		  else if (show==3'd3 && is_score)
		  begin
            Red = 8'h00; 
            Green = 8'h00;
            Blue = 8'h00;         
        end		  
        else if(show != 0)
        begin
            case(show)
            3'd1:
            begin
                if (DrawX>=160 && DrawX <460 &&DrawY>=0 &&DrawY <120)
                begin
                    Red = RGB_start1[23:16]; 
                    Green = RGB_start1[15:8];
                    Blue = RGB_start1[7:0];
                end
                else if(DrawX>=160 && DrawX <460 &&DrawY>=120 &&DrawY <240)
                begin
                    Red = RGB_start2[23:16]; 
                    Green = RGB_start2[15:8];
                    Blue = RGB_start2[7:0];
                end
                else if(DrawX>=160 && DrawX <460 &&DrawY>=240 &&DrawY <360)
                begin
                    Red = RGB_start3[23:16]; 
                    Green = RGB_start3[15:8];
                    Blue = RGB_start3[7:0];
                end
                else if(DrawX>=160 && DrawX <460 &&DrawY>=360 &&DrawY <480)
                begin
                    Red = RGB_start4[23:16]; 
                    Green = RGB_start4[15:8];
                    Blue = RGB_start4[7:0];
                end
                else
                begin
                Red = 8'h00; 
                Green = 8'h00;
                Blue = 8'h00;
                end
            end                
            3'd2:
            begin
                Red = 8'h00; 
                Green = 8'hff;
                Blue = 8'h00;
            end
            3'd3:
            begin
                if (DrawX>=160 && DrawX <460 &&DrawY>=0 &&DrawY <120)
                begin
                    Red = RGB_dead1[23:16]; 
                    Green = RGB_dead1[15:8];
                    Blue = RGB_dead1[7:0];
                end
                else if(DrawX>=160 && DrawX <460 &&DrawY>=120 &&DrawY <240)
                begin
                    Red = RGB_dead2[23:16]; 
                    Green = RGB_dead2[15:8];
                    Blue = RGB_dead2[7:0];
                end
                else if(DrawX>=160 && DrawX <460 &&DrawY>=240 &&DrawY <360)
                begin
                    Red = RGB_dead3[23:16]; 
                    Green = RGB_dead3[15:8];
                    Blue = RGB_dead3[7:0];
                end
                else if(DrawX>=160 && DrawX <460 &&DrawY>=360 &&DrawY <480)
                begin
                    Red = RGB_dead4[23:16]; 
                    Green = RGB_dead4[15:8];
                    Blue = RGB_dead4[7:0];
                end
                else
                begin
                Red = 8'h00; 
                Green = 8'h00;
                Blue = 8'h00;
                end
            end 
            default:
            begin
                Red = 8'h00; 
                Green = 8'h00;
                Blue = 8'h00;               
            end

            endcase
        end
        else if(is_score)
        begin
            Red = 8'h00; 
            Green = 8'h00;
            Blue = 8'h00;         
        end
        else if (is_bullet)
        begin
            Red = 8'h7d; 
            Green = 8'h4a;
            Blue = 8'h1c;
        end	
		else if (is_monster && ms_palt!=4'hd && active == 1)
        begin
            Red = RGBms[23:16];
            Green = RGBms[15:8];
            Blue = RGBms[7:0];          
        end	
        else if (is_doodle ) 
            case(doodle_state)
                2'b00:
                    if (d_palt != 0)
                    begin
                        Red = RGBdoodle[23:16];
                        Green = RGBdoodle[15:8];
                        Blue = RGBdoodle[7:0];
                    end 
                    else if (is_stair && s_palt != 0)
                    begin  
                        Red = RGBstair[23:16];
                        Green = RGBstair[15:8];
                        Blue = RGBstair[7:0];             
                    end
                    else if (is_tool && tl1_palt != 4'h0)
                    begin
                            Red = RGBtl[23:16];
                            Green = RGBtl[15:8];
                            Blue = RGBtl[7:0];                                      
                    end    
                    else
                    begin
                        Red = RGBback[23:16];
                        Green = RGBback[15:8];
                        Blue = RGBback[7:0];
                    end
                2'b01:
                    if (dl_palt != 0)
                    begin
                        Red = RGBdoodlel[23:16];
                        Green = RGBdoodlel[15:8];
                        Blue = RGBdoodlel[7:0];
                    end
                    else if (is_stair && s_palt != 0)
                    begin  
                        Red = RGBstair[23:16];
                        Green = RGBstair[15:8];
                        Blue = RGBstair[7:0];             
                    end
                    else if (is_tool && tl1_palt != 4'h0)
                    begin

                            Red = RGBtl[23:16];
                            Green = RGBtl[15:8];
                            Blue = RGBtl[7:0];  
                                    
                    end    
                    else
                    begin
                        Red = RGBback[23:16];
                        Green = RGBback[15:8];
                        Blue = RGBback[7:0];
                    end
                2'b10:
                    if (dup_palt != 0)
                    begin
                        Red = RGBdoodleup[23:16];
                        Green = RGBdoodleup[15:8];
                        Blue = RGBdoodleup[7:0];
                    end 
                    else if (is_stair && s_palt != 0)
                    begin  
                        Red = RGBstair[23:16];
                        Green = RGBstair[15:8];
                        Blue = RGBstair[7:0];             
                    end
                    else if (is_tool&& tl1_palt != 4'h0)
                        begin
                            Red = RGBtl[23:16];
                            Green = RGBtl[15:8];
                            Blue = RGBtl[7:0];  
                        end     
                    else
                    begin
                        Red = RGBback[23:16];
                        Green = RGBback[15:8];
                        Blue = RGBback[7:0];
                    end
                2'b11:
                    if (dup_palt != 0)
                    begin
                        Red = RGBdoodleup[23:16];
                        Green = RGBdoodleup[15:8];
                        Blue = RGBdoodleup[7:0];
                    end 
                    else if (is_stair && s_palt != 0)
                    begin  
                        Red = RGBstair[23:16];
                        Green = RGBstair[15:8];
                        Blue = RGBstair[7:0];             
                    end
                    else if (is_tool&& tl1_palt != 4'h0)
                        begin
                            Red = RGBtl[23:16];
                            Green = RGBtl[15:8];
                            Blue = RGBtl[7:0];  
                        end     
                    else
                    begin
                        Red = RGBback[23:16];
                        Green = RGBback[15:8];
                        Blue = RGBback[7:0];
                    end
                default: ;
            endcase
            
        else if (is_stair && s_palt != 0)
                begin  
                    Red = RGBstair[23:16];
                    Green = RGBstair[15:8];
                    Blue = RGBstair[7:0];             
                end 
        else if (is_tool&& tl1_palt != 4'h0)
                begin
                        Red = RGBtl[23:16];
                        Green = RGBtl[15:8];
                        Blue = RGBtl[7:0];       
                end  
        else
        begin
            Red = RGBback[23:16];
            Green = RGBback[15:8];
            Blue = RGBback[7:0];
        end  
    end


    
    always_comb 
    begin
        case(d_palt)
            4'h0:RGBdoodle = 24'hFFFFFF;
            4'h1:RGBdoodle = 24'h000000;
            4'h2:RGBdoodle = 24'h110C00;
            4'h3:RGBdoodle = 24'h8E928D;
            4'h4:RGBdoodle = 24'h272B28;
            4'h5:RGBdoodle = 24'h6b9644;
            4'h6:RGBdoodle = 24'h979A3E;
            4'h7:RGBdoodle = 24'hA8AC2A;
            4'h8:RGBdoodle = 24'hC7C872;
            4'h9:RGBdoodle = 24'hC0C626;
            4'ha:RGBdoodle = 24'hD9D38D;
            4'hb:RGBdoodle = 24'h2E4621;
            4'hc:RGBdoodle = 24'h2C3F21;
            4'hd:RGBdoodle = 24'h73A04B;
            4'he:RGBdoodle = 24'h24321B;
            4'hf:RGBdoodle = 24'h5f9247;
       default:RGBdoodle = 24'hFFFFFF;
        endcase
        
        
        case(dl_palt)
            4'h0:RGBdoodlel = 24'hFFFFFF;
            4'h1:RGBdoodlel = 24'h000000;
            4'h2:RGBdoodlel = 24'h110C00;
            4'h3:RGBdoodlel = 24'h8E928D;
            4'h4:RGBdoodlel = 24'h272B28;
            4'h5:RGBdoodlel = 24'h6b9644;
            4'h6:RGBdoodlel = 24'h979A3E;
            4'h7:RGBdoodlel = 24'hA8AC2A;
            4'h8:RGBdoodlel = 24'hC7C872;
            4'h9:RGBdoodlel = 24'hC0C626;
            4'ha:RGBdoodlel = 24'hD9D38D;
            4'hb:RGBdoodlel = 24'h2E4621;
            4'hc:RGBdoodlel = 24'h2C3F21;
            4'hd:RGBdoodlel = 24'h73A04B;
            4'he:RGBdoodlel = 24'h24321B;
            4'hf:RGBdoodlel = 24'h5f9247;
            default:RGBdoodlel = 24'hFFFFFF;
        endcase

        case(dup_palt)
            4'h0:RGBdoodleup = 24'hFFFFFF;
            4'h1:RGBdoodleup = 24'h000000;
            4'h2:RGBdoodleup = 24'h110C00;
            4'h3:RGBdoodleup = 24'h8E928D;
            4'h4:RGBdoodleup = 24'h272B28;
            4'h5:RGBdoodleup = 24'h6b9644;
            4'h6:RGBdoodleup = 24'h979A3E;
            4'h7:RGBdoodleup = 24'hA8AC2A;
            4'h8:RGBdoodleup = 24'hC7C872;
            4'h9:RGBdoodleup = 24'hC0C626;
            4'ha:RGBdoodleup = 24'hD9D38D;
            4'hb:RGBdoodleup = 24'h2E4621;
            4'hc:RGBdoodleup = 24'h2C3F21;
            4'hd:RGBdoodleup = 24'h73A04B;
            4'he:RGBdoodleup = 24'h24321B;
            4'hf:RGBdoodleup = 24'h5f9247;
            default:RGBdoodleup = 24'hFFFFFF;
        endcase

        case(s_palt)
            4'h0:RGBstair = 24'hFFFFFF;
            4'h1:RGBstair = 24'h000000; 
            4'h2:RGBstair = 24'h188137; 
            4'h3:RGBstair= 24'hC7E712;
            4'h4:RGBstair = 24'h1C9741;
            4'h5:RGBstair = 24'h23CB23;
            4'h6:RGBstair = 24'h3411F9;
            4'h7:RGBstair = 24'hFBF7F4;
            4'h8:RGBstair = 24'hE3DFDE;
            4'h9:RGBstair = 24'hF3EFEE; 
            4'ha:RGBstair = 24'hAEACAE; 
            4'hb:RGBstair = 24'h6C6C01;
            4'hc:RGBstair = 24'hBBBD00; 
            4'hd:RGBstair = 24'h88D500;
            4'he:RGBstair = 24'h398802;
            4'hf:RGBstair = 24'hF0FFFF;
            default:RGBstair = 24'hFFFFFF;
        endcase

        case(back_palt)
            4'h0:RGBback = 24'hFFFFFF;
            4'h1:RGBback = 24'h000000; 
            4'h2:RGBback = 24'h188137; 
            4'h3:RGBback = 24'hC7E712;
            4'h4:RGBback = 24'h1C9741;
            4'h5:RGBback = 24'h23CB23;
            4'h6:RGBback = 24'h3411F9;
            4'h7:RGBback = 24'hFBF7F4;
            4'h8:RGBback = 24'hE3DFDE;
            4'h9:RGBback = 24'hF3EFEE; 
            4'ha:RGBback = 24'hAEACAE; 
            4'hb:RGBback = 24'h6C6C01;
            4'hc:RGBback = 24'hBBBD00; 
            4'hd:RGBback = 24'h88D500;
            4'he:RGBback = 24'h398802;
            4'hf:RGBback = 24'hF0FFFF;
            default:RGBback = 24'hFFFFFF;
        endcase

        case(ms_palt)
            4'h0:RGBms = 24'hC6C778;
            4'h1:RGBms = 24'h172339;
            4'h2:RGBms = 24'h1C253C;
            4'h3:RGBms = 24'h34313C;
            4'h4:RGBms = 24'h272C42;
            4'h5:RGBms = 24'h194162;
            4'h6:RGBms = 24'h30628C;
            4'h7:RGBms = 24'h295774;
            4'h8:RGBms = 24'h63B2E5;
            4'h9:RGBms = 24'h4A6171;
            4'ha:RGBms = 24'h314353;
            4'hb:RGBms = 24'h2A4442;
            4'hc:RGBms = 24'h6D6B28;
            4'hd:RGBms = 24'hFFFFFF;
            4'he:RGBms = 24'h080B11;
            4'hf:RGBms = 24'h0C2324;
            default:RGBms = 24'hFFFFFF;
        endcase

        case(tl1_palt)
            4'h0:RGBtl = 24'hFFFFFF;
            4'h1:RGBtl = 24'h141312;
            4'h2:RGBtl = 24'h181717;
            4'h3:RGBtl = 24'h252424;
            4'h4:RGBtl = 24'h302C2B;
            4'h5:RGBtl = 24'h3A3939;
            4'h6:RGBtl = 24'h474443;
            4'h7:RGBtl = 24'h6E6967;
            4'h8:RGBtl = 24'h7C7978;
            4'h9:RGBtl = 24'h8B8582;
            4'ha:RGBtl = 24'hACA9A7;
            4'hb:RGBtl = 24'hCDC7C3;
            4'hc:RGBtl = 24'h9B938C;
            4'hd:RGBtl = 24'hD4CAC1;
            4'he:RGBtl = 24'hD1CBC4;
            4'hf:RGBtl = 24'h0B0A08;
            default:RGBtl = 24'hFFFFFF;
        endcase

        
    end

    //
    



    //
    doodleRAM doodleram(.read_address(d_addr),.Clk(Clk),.data_Out(d_palt));
    doodleleftRAM doodleramleft(.read_address(dl_addr),.Clk(Clk),.data_Out(dl_palt));
    doodleupRAM doodleupram(.read_address(dup_addr),.Clk(Clk),.data_Out(dup_palt));

    stairRAM stairram(.read_address(st_addr_min),.Clk(Clk),.data_Out(s_palt));
    backgroundRAM backgroundram(.read_address(back_addr),.Clk(Clk),.data_Out(back_palt));
    monster1RAM monster1ram(.read_address(ms_addr),.Clk(Clk),.data_Out(ms_palt));
    tool1RAM tool1ram(.read_address(tl1_addr_min),.Clk(Clk),.data_Out(tl1_palt));
    //score
    // font_rom myscore(.addr(score_addr),.data(score_data));

    //start_background

    //address
    
    always_comb begin : start
        start1_addr = DrawY*300 + DrawX-160;
        start2_addr = DrawY*300 + DrawX-160-300*120;
        start3_addr = DrawY*300 + DrawX-160-2*300*120;
        start4_addr = DrawY*300 + DrawX-160-3*300*120;

        case(start1_palt)
            4'h0:RGB_start1 = 24'hFFFFFF;
            4'h1:RGB_start1 = 24'h000000;
            4'h2:RGB_start1 = 24'h9BAB4B;
            4'h3:RGB_start1 = 24'hA6AE60;
            4'h4:RGB_start1 = 24'h4D5121;
            4'h5:RGB_start1 = 24'hB0AA8F;
            4'h6:RGB_start1 = 24'hA3A673;
            4'h7:RGB_start1 = 24'h5A5550;
            4'h8:RGB_start1 = 24'hE9E0D9;
            4'h9:RGB_start1 = 24'hF7EEE7;
            4'ha:RGB_start1 = 24'hE4DAD0;
            4'hb:RGB_start1 = 24'h56070A;
            4'hc:RGB_start1 = 24'h8F0A14;
            4'hd:RGB_start1 = 24'hEBB9B2;
            4'he:RGB_start1 = 24'hA0B824;
            4'hf:RGB_start1 = 24'h555B1A;
            default:RGB_start1 = 24'hFFFFFF;
        endcase
        case(start2_palt)
            4'h0:RGB_start2 = 24'hFFFFFF;
            4'h1:RGB_start2 = 24'h000000;
            4'h2:RGB_start2 = 24'hEBE2DB;
            4'h3:RGB_start2 = 24'hF6C073;
            4'h4:RGB_start2 = 24'hF6E7D3;
            4'h5:RGB_start2 = 24'h6F655C;
            4'h6:RGB_start2 = 24'h183847;
            4'h7:RGB_start2 = 24'h89B3BB;
            4'h8:RGB_start2 = 24'h324A53;
            4'h9:RGB_start2 = 24'hCFB27F;
            4'ha:RGB_start2 = 24'hEEE5DE;
            4'hb:RGB_start2 = 24'h393939;
            4'hc:RGB_start2 = 24'hB5B5B2;
            4'hd:RGB_start2 = 24'hF7EEE5;
            4'he:RGB_start2 = 24'hE4C191;
            4'hf:RGB_start2 = 24'h3E1800;
            default:RGB_start2 = 24'hFFFFFF;
        endcase
        case(start3_palt)
            4'h0:RGB_start3 = 24'hFFFFFF;
            4'h1:RGB_start3 = 24'h000000;
            4'h2:RGB_start3 = 24'hF9F0E9;
            4'h3:RGB_start3 = 24'hF8F1E9;
            4'h4:RGB_start3 = 24'hECE5DD;
            4'h5:RGB_start3 = 24'hC69F65;
            4'h6:RGB_start3 = 24'h7C5E34;
            4'h7:RGB_start3 = 24'h7E7F83;
            4'h8:RGB_start3 = 24'hF2C784;
            4'h9:RGB_start3 = 24'h0A3953;
            4'ha:RGB_start3 = 24'h62A3C8;
            4'hb:RGB_start3 = 24'hC7562B;
            4'hc:RGB_start3 = 24'hD4CD65;
            4'hd:RGB_start3 = 24'hCFCE15;
            4'he:RGB_start3 = 24'h7D954E;
            4'hf:RGB_start3 = 24'h334A14;
            default:RGB_start3 = 24'hFFFFFF;
        endcase
        case(start4_palt)
            4'h0:RGB_start4 = 24'hFFFFFF;
            4'h1:RGB_start4 = 24'h000000;
            4'h2:RGB_start4 = 24'hF6EDE6;
            4'h3:RGB_start4 = 24'hEFE8E0;
            4'h4:RGB_start4 = 24'hE2DBD3;
            4'h5:RGB_start4 = 24'h090708;
            4'h6:RGB_start4 = 24'h686964;
            4'h7:RGB_start4 = 24'hC3C4C6;
            4'h8:RGB_start4 = 24'hE2E2E3;
            4'h9:RGB_start4 = 24'h7EB52D;
            4'ha:RGB_start4 = 24'h96E241;
            4'hb:RGB_start4 = 24'h243700;
            4'hc:RGB_start4 = 24'h7A9E3C;
            4'hd:RGB_start4 = 24'hC2F479;
            4'he:RGB_start4 = 24'hBCFD7E;
            4'hf:RGB_start4 = 24'h152500;
            default:RGB_start4 = 24'hFFFFFF;
        endcase

        
    end
     
    start1RAM mystatr1(.read_address(start1_addr),.Clk(Clk),.data_Out(start1_palt));
    start2RAM mystatr2(.read_address(start2_addr),.Clk(Clk),.data_Out(start2_palt));
    start3RAM mystatr3(.read_address(start3_addr),.Clk(Clk),.data_Out(start3_palt));
    start4RAM mystatr4(.read_address(start4_addr),.Clk(Clk),.data_Out(start4_palt));
    



//dead background

always_comb begin : dead
        dead1_addr = DrawY*300 + DrawX-160;
        dead2_addr = DrawY*300 + DrawX-160-300*120;
        dead3_addr = DrawY*300 + DrawX-160-2*300*120;
        dead4_addr = DrawY*300 + DrawX-160-3*300*120;

        case(dead1_palt)
            4'h0:RGB_dead1 = 24'hF7F1ED;
            4'h1:RGB_dead1 = 24'hF0DECA;
            4'h2:RGB_dead1 = 24'hF4EADE;
            4'h3:RGB_dead1 = 24'hF1E5D9;
            4'h4:RGB_dead1 = 24'hA0A09F;
            4'h5:RGB_dead1 = 24'hCCD4D9;
            4'h6:RGB_dead1 = 24'hC4C6C5;
            4'h7:RGB_dead1 = 24'hCDD2D9;
            4'h8:RGB_dead1 = 24'h7C756A;
            4'h9:RGB_dead1 = 24'h958B81;
            4'ha:RGB_dead1 = 24'h635A4F;
            4'hb:RGB_dead1 = 24'h6C6A67;
            4'hc:RGB_dead1 = 24'hADB3B8;
            4'hd:RGB_dead1 = 24'hA19F9B;
            4'he:RGB_dead1 = 24'h730000;
            4'hf:RGB_dead1 = 24'h831816;
            default:RGB_dead1 = 24'hFFFFFF;
        endcase
        case(dead2_palt)
            4'h0:RGB_dead2 = 24'hF7F0E9;
            4'h1:RGB_dead2 = 24'hF7EDE6;
            4'h2:RGB_dead2 = 24'hEFDDCB;
            4'h3:RGB_dead2 = 24'hF2E7DE;
            4'h4:RGB_dead2 = 24'hF0E3D5;
            4'h5:RGB_dead2 = 24'h710000;
            4'h6:RGB_dead2 = 24'h943837;
            4'h7:RGB_dead2 = 24'hB87D7A;
            4'h8:RGB_dead2 = 24'hE5CBC4;
            4'h9:RGB_dead2 = 24'h892322;
            4'ha:RGB_dead2 = 24'h7F766F;
            4'hb:RGB_dead2 = 24'h464544;
            4'hc:RGB_dead2 = 24'hE7D9BE;
            4'hd:RGB_dead2 = 24'hEBD8C3;
            4'he:RGB_dead2 = 24'hF4EEE7;
            4'hf:RGB_dead2 = 24'h7D7466;
            default:RGB_dead2 = 24'hFFFFFF;
        endcase
        case(dead3_palt)
            4'h0:RGB_dead3 = 24'hFFFFFF;
            4'h1:RGB_dead3 = 24'h000000;
            4'h2:RGB_dead3 = 24'hF7F0EA;
            4'h3:RGB_dead3 = 24'hF2EBE4;
            4'h4:RGB_dead3 = 24'hE49430;
            4'h5:RGB_dead3 = 24'hEBCCA5;
            4'h6:RGB_dead3 = 24'hECD9C6;
            4'h7:RGB_dead3 = 24'hF0CB8E;
            4'h8:RGB_dead3 = 24'hDA9335;
            4'h9:RGB_dead3 = 24'h938D80;
            4'ha:RGB_dead3 = 24'h494542;
            4'hb:RGB_dead3 = 24'h423F3E;
            4'hc:RGB_dead3 = 24'h030302;
            4'hd:RGB_dead3 = 24'h605F5D;
            4'he:RGB_dead3 = 24'hDD9333;
            4'hf:RGB_dead3 = 24'hF5D29B;
            default:RGB_dead3 = 24'hFFFFFF;
        endcase
        case(dead4_palt)
            4'h0:RGB_dead4 = 24'hFFFFFF;
            4'h1:RGB_dead4 = 24'h000000;
            4'h2:RGB_dead4 = 24'hF7F0E8;
            4'h3:RGB_dead4 = 24'hF7EEE6;
            4'h4:RGB_dead4 = 24'hEAD9C0;
            4'h5:RGB_dead4 = 24'hF3E4D6;
            4'h6:RGB_dead4 = 24'hF4E4D5;
            4'h7:RGB_dead4 = 24'h373635;
            4'h8:RGB_dead4 = 24'h5E6268;
            4'h9:RGB_dead4 = 24'h4A4848;
            4'ha:RGB_dead4 = 24'h878F91;
            4'hb:RGB_dead4 = 24'hBCBFC6;
            4'hc:RGB_dead4 = 24'hB5B6B9;
            4'hd:RGB_dead4 = 24'h42414B;
            4'he:RGB_dead4 = 24'h64686C;
            4'hf:RGB_dead4 = 24'hDBDAE2;
            default:RGB_dead4 = 24'hFFFFFF;
        endcase

        
    end
     
    dead1RAM mydead1(.read_address(dead1_addr),.Clk(Clk),.data_Out(dead1_palt));
    dead2RAM mydead2(.read_address(dead2_addr),.Clk(Clk),.data_Out(dead2_palt));
    dead3RAM mydead3(.read_address(dead3_addr),.Clk(Clk),.data_Out(dead3_palt));
    dead4RAM mydead4(.read_address(dead4_addr),.Clk(Clk),.data_Out(dead4_palt));
    



 
    
endmodule

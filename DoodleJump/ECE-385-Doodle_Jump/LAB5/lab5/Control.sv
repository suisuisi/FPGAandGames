//Two-always example for state machine

module control (input  logic Clk, Reset, Run,
                output logic Shift, Add, Sub, cleara_remainb);

    // Declare signals curr_state, next_state of type enum
    // with enum values of A, B, ..., F as the state values
	 // Note that the length implies a max of 8 states, so you will need to bump this up for 8-bits
    enum logic [5:0] {s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s_n }   curr_state, next_state; 

	//updates flip flop, current state is the only one
    always_ff @ (posedge Clk)  
    begin
        if (Reset)
            curr_state <= s0;
        else 
            curr_state <= next_state;
    end

    // Assign outputs based on state
	always_comb
    begin
        
		  next_state  = curr_state;	//required because I haven't enumerated all possibilities below
        unique case (curr_state) 

            s0 :    if (Run)
                       next_state = s_n;
				s_n: 	  next_state = s1;
            s1 :    next_state = s2;
				s2 :    next_state = s3;
            s3 :    next_state = s4;
				s4 :    next_state = s5;
            s5 :    next_state = s6;
				s6 :    next_state = s7;
				s7 :    next_state = s8;
            s8 :    next_state = s9;
				s9 :    next_state = s10;
				s10 :    next_state = s11;
				s11 :    next_state = s12;
				s12 :    next_state = s13;
            s13 :    next_state = s14;
				s14 :    next_state = s15;
            s15 :    next_state = s16;
				s16 :    next_state = s17;
            s17 :    if (~Run) 
                       next_state = s0;
							  
        endcase
   
		  // Assign outputs based on ‘state’
        case (curr_state) 
	   	   s0: 
	         begin
					 cleara_remainb = 1'b0;
					 Shift = 1'b0;
					 Add = 1'b0;
					 Sub = 1'b0;
		      end
				s_n: 
	         begin
					 cleara_remainb = 1'b1;
					 Shift = 1'b0;
					 Add = 1'b0;
					 Sub = 1'b0;
		      end
	   	   s1: 
	         begin
					 cleara_remainb = 1'b0;
					 Shift = 1'b0;
					 Add = 1'b1;
					 Sub = 1'b0;
		      end
				s2: 
	         begin
					 cleara_remainb = 1'b0;
					 Shift = 1'b1;
					 Add = 1'b0;
					 Sub = 1'b0;
		      end
				s3: 
	         begin
				    cleara_remainb = 1'b0;
					 Shift = 1'b0;
					 Add = 1'b1;
					 Sub = 1'b0;
		      end
				s4: 
	         begin
				    cleara_remainb = 1'b0;
					 Shift = 1'b1;
					 Add = 1'b0;
					 Sub = 1'b0;
		      end
				s5: 
	         begin
				    cleara_remainb = 1'b0;
					 Shift = 1'b0;
					 Add = 1'b1;
					 Sub = 1'b0;
		      end
				s6: 
	         begin
				    cleara_remainb = 1'b0;
					 Shift = 1'b1;
					 Add = 1'b0;
					 Sub = 1'b0;
		      end
				s7: 
	         begin
				    cleara_remainb = 1'b0;
					 Shift = 1'b0;
					 Add = 1'b1;
					 Sub = 1'b0;
		      end
				s8: 
	         begin
				    cleara_remainb = 1'b0;
					 Shift = 1'b1;
					 Add = 1'b0;
					 Sub = 1'b0;
		      end
				s9: 
	         begin
				    cleara_remainb = 1'b0;
					 Shift = 1'b0;
					 Add = 1'b1;
					 Sub = 1'b0;
		      end
				s10: 
	         begin
				    cleara_remainb = 1'b0;
					 Shift = 1'b1;
					 Add = 1'b0;
					 Sub = 1'b0;
		      end
				s11: 
	         begin
				    cleara_remainb = 1'b0;
					 Shift = 1'b0;
					 Add = 1'b1;
					 Sub = 1'b0;
		      end
				s12: 
	         begin
				    cleara_remainb = 1'b0;
					 Shift = 1'b1;
					 Add = 1'b0;
					 Sub = 1'b0;
		      end
				s13: 
	         begin
				    cleara_remainb = 1'b0;
					 Shift = 1'b0;
					 Add = 1'b1;
					 Sub = 1'b0;
		      end
				s14: 
	         begin
				    cleara_remainb = 1'b0;
					 Shift = 1'b1;
					 Add = 1'b0;
					 Sub = 1'b0;
		      end
				s15: 
	         begin
				    cleara_remainb = 1'b0;
					 Shift = 1'b0;
					 Add = 1'b1;
					 Sub = 1'b1;
		      end
				s16: 
	         begin
				    cleara_remainb = 1'b0;
					 Shift = 1'b1;
					 Add = 1'b0;
					 Sub = 1'b0;
		      end
				s17: 
	         begin
				    cleara_remainb = 1'b0;
					 Shift = 1'b0;
					 Add = 1'b0;
					 Sub = 1'b0;
				end
	   	   default:  //default case, can also have default assignments for Ld_A and Ld_B before case
		      begin 
					 cleara_remainb = 1'b0;
					 Shift = 1'b0;
					 Add = 1'b0;
					 Sub = 1'b0;
		      end
        endcase
    end

endmodule

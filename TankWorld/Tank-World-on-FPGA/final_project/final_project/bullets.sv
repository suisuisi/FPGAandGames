module bullets(input [1:0] is_tank_in,
					input Clk, 
					input frame_clk,
					input Reset, 
					input keycode,
					input enemy_action,
					input  [9:0] DrawX, DrawY,
					output [9:0]  Right_mid_X, Right_mid_Y, 
					output [9:0]  Up_mid_X, Up_mid_Y,
					output [9:0]  Left_mid_X, Left_mid_Y,
					output [9:0]  Down_mid_X, Down_mid_Y,
					output is_bullet, 
					output [1:0] is_bullet_out
					);

logic [3:0] counter;
logic [1:0] is_bullet_out_in;
logic [9:0] Bullet_X_Pos_in, Bullet_Y_Pos_in, Bullet_X_Motion_in, Bullet_Y_Motion_in;
logic [9:0] Bullet_X_Pos, Bullet_Y_Pos, Bullet_X_Motion, Bullet_Y_Motion;

always_ff @ (posedge Clk)
begin 
	if (Reset)
		begin
		counter <= 4'd0;
		is_bullet_out <= 2'b00; //00 Right, 01 up, 10 left, 11 down
		end
	else 
		begin
		counter <= counter_in;
		is_bullet_out <= is_bullet_out_in;
		end
end

logic frame_clk_delayed, frame_clk_rising_edge;
always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
end

// Update registers
always_ff @ (posedge Clk)
begin
if (Reset)
   begin
	Bullet_X_Pos <= Bullet_X_Start;
   Bullet_Y_Pos <= Bullet_Y_Start;
   Bullet_X_Motion <= 10'd0;
   Bullet_Y_Motion <= Ball_Y_Step;
   end
	else
   begin
      Ball_X_Pos <= Ball_X_Pos_in;
      Ball_Y_Pos <= Ball_Y_Pos_in;
      Ball_X_Motion <= Ball_X_Motion_in;
      Ball_Y_Motion <= Ball_Y_Motion_in;
   end
end


enum logic [1:0] {NOBULLET, NOBULLET_WAIT, BULLET} State, Next_State;

always_ff @ (posedge Clk) 
begin
	if (Reset) 
		State <= NOBULLET;
	else
		State <= Next_State;
end


always_comb
begin 
	is_bullet_out_in = is_bullet_out_in;
	unique case (State)
	NOBULLET:
		begin
		if (keycode == 8'h28 || keycode == 8'h2c) 
			Next_State = NOBULLET_WAIT;
		else 
			Next_State = NOBULLET;
		end
	NOBULLET_WAIT:
		begin
		if (keycode == 8'h00) 
			Next_State = BULLET;
		else
			Next_State = NOBULLET_WAIT;
		end
	BULLET:
		begin
		if (counter == 4'd10)
			Next_State = NOBULLET;
		else
			Next_State = BULLET;
		end
	endcase
	
	case (State) 
	NOBULLET:
		counter = 4'd0;
		is_bullet_out_in = is_tank_in;
	NOBULLET_WAIT:
		counter = 4'd0;
		is_bullet_out_in = is_tank_in;
	BULLET:
		counter = counter + 4'd1;
		
end
endmodule 
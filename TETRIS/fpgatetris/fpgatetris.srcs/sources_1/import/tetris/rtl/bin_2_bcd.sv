module bin_2_bcd
#( 
  parameter BIN_WIDTH = 8,
  parameter BCD_WIDTH = 3
)
(
  input        [BIN_WIDTH-1:0]      bin_i,

  output logic [BCD_WIDTH-1:0][3:0] bcd_o

);

always_comb
  begin
    bcd_o = '0;

    for( int b = BIN_WIDTH - 1; b >= 0; b-- )
      begin
        for( int bcd = 0; bcd < BCD_WIDTH; bcd++ )
          begin
            if( bcd_o[ bcd ] >= 4'd5 )
              bcd_o[ bcd ] += 4'd3;
          end

        for( int bcd = BCD_WIDTH - 1; bcd >= 0; bcd-- )
          begin
            bcd_o[ bcd ]    = bcd_o[ bcd ] << 1;

            if( bcd == 0 )
              bcd_o[ bcd ][0] = bin_i[ b ];
            else
              bcd_o[ bcd ][0] = bcd_o[ bcd - 1 ][3];
          end
      end
  end


endmodule

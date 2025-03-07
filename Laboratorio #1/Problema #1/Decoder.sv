module Decoder (input logic [3:0]BCD,
					 output logic [0:13]double7segment);
	always @(BCD) begin
	
		case(BCD)
		  4'b0000 : double7segment= 14'b00000010000001; //00
		  4'b0001 : double7segment= 14'b10011110000001; //01
		  4'b0010 : double7segment= 14'b00100100000001; //02
		  4'b0011 : double7segment= 14'b00001100000001; //03
		  4'b0100 : double7segment= 14'b10011000000001; //04 
		  4'b0101 : double7segment= 14'b01001000000001; //05
		  4'b0110 : double7segment= 14'b01000000000001; //06
		  4'b0111 : double7segment= 14'b00011110000001; //07
		  4'b1000 : double7segment= 14'b00000000000001; //08
		  4'b1001 : double7segment= 14'b00001000000001; //09
		  4'b1010 : double7segment= 14'b00010000000001; //10
		  4'b1011 : double7segment= 14'b11000000000001; //11
		  4'b1100 : double7segment= 14'b01100010000001; //12
		  4'b1101 : double7segment= 14'b10000100000001; //13
		  4'b1110 : double7segment= 14'b01100000000001; //14
		  4'b1111 : double7segment= 14'b01100000000001; //15
		  default : double7segment= 14'b00000010000001; //16
	endcase
	end
endmodule
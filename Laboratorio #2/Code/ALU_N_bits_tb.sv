`timescale 1ns/1ps

module ALU_N_bits_tb ();
	// wiring
	logic[7:0] a,b,result;
	logic[3:0] select, flags;
	
	// device under test
	ALU_N_bits#(8) dut(.a(a),
							 .b(b),
							 .control(select),
							 .result(result),
							 .v(flags[3]),
							 .c(flags[2]),
							 .n(flags[1]),
							 .z(flags[0]));
	
	// test
	initial begin
		a=8'b00010001; b=8'b10001000; select=4'b0100; // OR, expects result=8'b10011001
		#10;
		a=8'b01010011; b=8'b01001001; select=4'b0000; // SUB, expects result=8'b10011100 v=1 n=1
		#10; 
	end

endmodule
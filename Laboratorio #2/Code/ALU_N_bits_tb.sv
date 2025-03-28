`timescale 1ns/1ps

/* Mux operation order
	s = 0000 => d0 ADD
	s = 0001 => d1 SUB
	s = 0010 => d2 AND
	s = 0011 => d3 OR
	s = 0100 => d4 XOR
	s = 0101 => d5 LSR
	s = 0110 => d6 LSL
	s = 0111 => d7 mod
	s = 1000 => d8 Mult
	s = 1001 => d9 Div
*/ 


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
		// Operation tests
		a=8'b00001001; b=8'b00101001; select=4'b0000;
		#10;
		$display("Addition Test: %d + %d = %d", a, b, result);
		
		a=8'b00110001; b=8'b00010001; select=4'b0001;
		#10;
		$display("Substraction Test: %d - %d = %d", a, b, result);
		
		a=8'b00110101; b=8'b01010001; select=4'b0010;
		#10;
		$display("AND Test: %b & %b = %b", a, b, result);
		
		a=8'b00110101; b=8'b01010001; select=4'b0011;
		#10;
		$display("OR Test: %b | %b = %b", a, b, result);
		
		a=8'b00110101; b=8'b01010001; select=4'b0100;
		#10;
		$display("XOR Test: %b ^ %b = %b", a, b, result);
		
		a=8'b00110101; b=8'b00000001; select=4'b0101;
		#10;
		$display("Logical Shift Right Test: %b >> %d = %b", a, b, result);
		
		a=8'b00110101; b=8'b00000010; select=4'b0110;
		#10;
		$display("Logical Shift Left Test: %b << %d = %b", a, b, result);
		
		a=8'b00011001; b=8'b00000111; select=4'b0111;
		#10;
		$display("Modulus Test: %d %% %d = %d", a, b, result);
		
		a=8'b00000011; b=8'b00100000; select=4'b1000;
		#10;
		$display("Multiplication Test: %d * %d = %d", a, b, result);
		
		a=8'b01110001; b=8'b00000111; select=4'b1001;
		#10;
		$display("Divition Test: %d / %d = %d", a, b, result);
		
		// Flags test
		a=8'b11111111; b=8'b00000000; select=4'b0010;
		#10;
		$display("FLAGS Test (VCNZ:%b): %b & %b = %b", flags, a, b, result);
		/*
		a=8'b00000011; b=8'b00010001; select=4'b0001;
		#10;
		$display("FLAGS Test (VCNZ:%b): %d - %d = %d", flags, a, b, $signed(result));
		*/
		a=8'b11000011; b=8'b10010001; select=4'b0000;
		#10;
		$display("FLAGS Test (VCNZ:%b): %b + %b = %b", flags, a, b, result);
		
		a=8'b01011101; b=8'b01111110; select=4'b0000;
		#10;
		$display("FLAGS Test (VCNZ:%b): %d + %d = %d", flags, a, b, $signed(result));
	end

endmodule
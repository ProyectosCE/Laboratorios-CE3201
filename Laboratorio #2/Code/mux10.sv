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


// This is works on conditionals to get a mux10
// unsure what happens when select line is outside of range
// should be fixed to handle out of range select, later though
module mux10
	#(parameter N=4)
	 (input logic [N-1:0] d0, d1, d2, d3, d4, d5, d6, d7, d8, d9,
	  input logic [3:0] s,
	  output logic [N-1:0] y);

	assign y = s[3] ? (s[0] ? d9 : d8) : (s[2] ? (s[1] ? (s[0] ? d7 : d6) : (s[0] ? d5 : d4)) : (s[1] ? (s[0] ? d3 : d2) : (s[0] ? d1 : d0)));
endmodule

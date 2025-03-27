// Pg. 249 H&H
/* s = 00 => d0 ADD
	s = 01 => d1 SUB
	s = 10 => d2 AND
	s = 11 => d3 OR
*/ 
/*
mux4#(.N(N)) alu_controller(.d0(res_sum), 
									 .d1(res_sum),
									 .d2(res_and),
									 .d3(res_or),
									 .s(control),
									 .y(result)); 	
*/


// Pg. 182 H&H
module mux4
	#(parameter N=4)
	 (input logic [N-1:0] d0, d1, d2, d3,
	  input logic [1:0] s,
	  output logic [N-1:0] y);
assign y = s[1] ? (s[0] ? d3 : d2)
: (s[0] ? d1 : d0);
endmodule
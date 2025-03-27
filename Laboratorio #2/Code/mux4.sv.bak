module mux4
	#(parameter width=4)
	 (input logic [width-1:0] d0, d1, d2, d3,
	  input logic [1:0] s,
     output logic [width-1:0] y);
	// Internal wires
	logic [width-1:0] low, hi;
	// Using three 2;1 mux to create a 4:1 mux
	mux2 lowmux(d0, d1, s[0], low);
	mux2 himux(d2, d3, s[0], hi);
	mux2 outmux(low, hi, s[1], y);
endmodule
// Pg. 246 H&H
	 
module sum 
	#(parameter N=4)
	 (input logic [N-1:0] a, b,
	  input logic cin,
	  output logic[N-1:0] s,
	  output logic cout);
	  
	assign {cout, s} = a + b + cin;
endmodule
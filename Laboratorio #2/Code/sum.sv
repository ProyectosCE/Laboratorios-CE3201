// Pg. 246 H&H
/* 
module sum 
	#(parameter N=4)
	 (input logic [N-1:0] a, b,
	  input logic cin,
	  output logic[N-1:0] s,
	  output logic cout);
	  
	assign {cout, s} = a + b + cin;
endmodule

*/

module full_adder (input logic a, b, cin,
						 output logic s, cout);
	assign s = a ^ b ^ cin;
	assign cout = (a & b) | (cin & (a ^ b));
endmodule

module ripple_carry_adder_N_bits 
	#(parameter N=4)
	 (input logic[N-1:0] a, b,
	  input logic cin,
     output logic[N-1:0] s, cout);
	  
    wire [N:0] carry; // for sending carries between FAs
	 assign carry[0] = cin;
	 
	 genvar i;
    generate
      for (i = 0;i < N;i = i + 1) begin: adder_stage
          full_adder fa (.a(a[i]),
								 .b(b[i]),
								 .cin(carry[i]),
								 .s(s[i]),
								 .cout(carry[i+1]));
      end  
        assign cout = carry[N];
    endgenerate
endmodule
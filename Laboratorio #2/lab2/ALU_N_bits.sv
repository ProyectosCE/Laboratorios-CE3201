module ALU_N_bits 
	#(parameter N=4)
	 (input logic[N-1:0] a, b,
	  input logic[1:0] control, // Need 4 bits to select from 10 operations
	  output logic[N-1:0] result,
	  output logic v, c, n, z);
	
	// Wires

	logic[N-1:0] b_sum, res_sum, res_and, res_or;
	logic sum_carry;
	assign b_sum = control[0] ? ~b : b;
		
	// Operations

	assign res_and = a & b;
	assign res_or = a | b;	
	sum#(.N(N)) alu_sum(.a(a),
							  .b(b_sum),
							  .cin(control[0]),
							  .s(res_sum),
							  .cout(sum_carry));
		
	// Multiplexer
		
	mux4#(.N(N)) alu_controller(.d0(res_sum), 
										 .d1(res_sum),
										 .d2(res_and),
										 .d3(res_or),
										 .s(control),
										 .y(result)); 									 
										 
	// Flags
	
	assign z = &(~result);
	assign n = result[N-1];
	assign c = ~control[1] & sum_carry;
	assign v = ~(control[1] ^ a[N-1] ^ b[N-1]) & (a[N-1] ^ res_sum[N-1]) & ~control[1];

endmodule

module ALU_N_bits 
	#(parameter N=4)
	 (input logic[N-1:0] a, b,
	  input logic[3:0] control,
	  output logic[N-1:0] result,
	  output logic v, c, n, z);
	
	/* WIRING */
	// These are for the output of operations, they connect to the mux
	logic[N-1:0] res_sum, res_and, res_or, res_xor, res_lsr, res_lsl;
	
	// These handle the carry out and the negative b for substraction
	logic sum_carry;
	logic[N-1:0] b_sum;
	assign b_sum = control[0] ? ~b : b;
		
	/* OPERATIONS */
	// Logic
	assign res_and = a & b;
	assign res_or = a | b;
	assign res_xor = a ^ b;
	assign res_lsr = a >> b;
	assign res_lsl = a << b;
	
	// Arithmetic
	sum#(.N(N)) alu_sum(.a(a),
							  .b(b_sum),
							  .cin(control[0]),
							  .s(res_sum),
							  .cout(sum_carry));
		
	/* MULTIPLEXER */
	// Controls which operation goes as the result
	mux10#(.N(N)) alu_controller(.d0(res_sum), 
										  .d1(res_sum),
										  .d2(res_and),
										  .d3(res_or),
										  .d4(res_xor),
										  .d5(res_lsr),
										  .d6(res_lsl),
										  .d7(a), //wip
										  .d8(a),
										  .d9(a),
										  .s(control),
										  .y(result)); 
	
	/* Flags */
	assign z = &(~result);
	assign n = result[N-1];
	assign c = ~control[1] & sum_carry;
	assign v = ~(control[1] ^ a[N-1] ^ b[N-1]) & (a[N-1] ^ res_sum[N-1]) & ~control[1];

endmodule

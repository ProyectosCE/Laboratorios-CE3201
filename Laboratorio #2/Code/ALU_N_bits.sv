module ALU_N_bits 
	#(parameter N=4)
	 (input logic[N-1:0] a, b,
	  input logic[3:0] control,
	  output logic[N-1:0] result,
	  output logic v, c, n, z);
	
	/* WIRING */
	// These are for the output of operations, they connect to the mux
	logic[N-1:0] res_sum, res_and, res_or, res_xor, res_lsr, res_lsl, res_div, res_mod, res_mul;
	
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
	
	assign res_div = a / b
	assign res_mod = a % b
	
	/*
	sum#(.N(N)) alu_sum(.a(a),
							  .b(b_sum),
							  .cin(control[0]),
							  .s(res_sum),
							  .cout(sum_carry));
	*/

	ripple_carry_adder_N_bits#(.N(N)) alu_sum(.a(a),
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
										  .d7(res_mod),
										  .d8(a), //de momento se debe quedar en a
										  .d9(res_div),
										  .s(control),
										  .y(result)); 
	
	/* FLAGS */
	assign z = &(~result);
	assign n = result[N-1];
	assign c = ~control[1] & sum_carry;
	assign v = ~(control[1] ^ a[N-1] ^ b[N-1]) & (a[N-1] ^ res_sum[N-1]) & ~control[1];

endmodule


module ALU_TOP_BTN (
    input  logic [3:0] a,
    input  logic [3:0] b,
    input  logic btn_sumador,
    input  logic btn_restador,
    output logic [6:0] alu_out_7seg,
    output logic [6:0] oper_7seg
);

    logic [3:0] control = 4'd0;
    logic [3:0] result;

    // Instancia de la ALU
    ALU_N_bits #(.N(4)) alu_inst (
        .a(a),
        .b(b),
        .control(control),
        .result(result),
        .v(), .c(), .n(), .z()
    );

    // Lógica con botones (flancos negativos)
    always_ff @(negedge btn_sumador or negedge btn_restador) begin
        if (!btn_sumador) begin
            if (control == 4'd9)
                control <= 4'd0;
            else
                control <= control + 1;
        end else if (!btn_restador) begin
            if (control == 4'd0)
                control <= 4'd9;
            else
                control <= control - 1;
        end
    end

    // Visualización de resultado de la ALU en 7 segmentos (hexadecimal)
    Print_Single_Hex res_disp (
        .hex(result),
        .segment(alu_out_7seg)
    );

    // Visualización del código de operación en 7 segmentos (hexadecimal)
    Print_Single_Hex ctrl_disp (
        .hex(control),
        .segment(oper_7seg)
    );

endmodule

module Print_Single_Hex (
    input  logic [3:0] hex,
    output logic [6:0] segment
);
    always_comb begin
        case (hex)
            4'h0: segment = 7'b0000001;
            4'h1: segment = 7'b1001111;
            4'h2: segment = 7'b0010010;
            4'h3: segment = 7'b0000110;
            4'h4: segment = 7'b1001100;
            4'h5: segment = 7'b0100100;
            4'h6: segment = 7'b0100000;
            4'h7: segment = 7'b0001111;
            4'h8: segment = 7'b0000000;
            4'h9: segment = 7'b0000100;
            4'hA: segment = 7'b0001000;
            4'hB: segment = 7'b1100000;
            4'hC: segment = 7'b0110001;
            4'hD: segment = 7'b1000010;
            4'hE: segment = 7'b0110000;
            4'hF: segment = 7'b0111000;
            default: segment = 7'b1111111;
        endcase
    end
endmodule

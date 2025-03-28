/* 
================================== LICENCIA ================================================== 
MIT License
Copyright (c) 2025 José Bernardo Barquero Bonilla,
                   Alexander Montero Vargas,
                   Alvaro Vargas Molina
Consulta el archivo LICENSE para más detalles.
==============================================================================================
*/

/* 
Module: ALU_N_bits
Implementa una Unidad Aritmética Lógica (ALU) parametrizable en el número de bits.
Params:
- N: Entero - Número de bits de las entradas y salidas.
Inputs:
- a: Logic input [N bits] - Primer operando.
- b: Logic input [N bits] - Segundo operando.
- control: Logic input [4 bits] - Código de operación.
Outputs:
- result: Logic output [N bits] - Resultado de la operación.
- v: Logic output - Flag de overflow.
- c: Logic output - Flag de carry.
- n: Logic output - Flag de negativo.
- z: Logic output - Flag de cero.
Restriction:
- El parámetro N debe ser estrictamente mayor a 0.
Example:
ALU_N_bits #(.N(8)) alu_instance (
    .a(8'b00011011),
    .b(8'b00000101),
    .control(4'b0010),
    .result(result_output),
    .v(v_flag),
    .c(c_flag),
    .n(n_flag),
    .z(z_flag)
);
References:
[1] D. Harris y S. Harris, "Digital Design and Computer Architecture", 4th ed., ARM
edition, Morgan Kaufmann, 2021.
*/

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
	
	assign res_mod = (b != 0) ? (a % b) : 0;
	assign res_div = (b != 0) ? (a /	b) : 0;
	
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
	multiplier_cla #(.MULTICAND_WID(N), .MULTIPLIER_WID(N)) alu_mul (
    .multicand(a),
    .multiplier(b),
    .product(res_mul)
	);


	
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
										  .d8(res_mul), //de momento se debe quedar en a
										  .d9(res_div),
										  .s(control),
										  .y(result)); 
	
	/* FLAGS */
	assign z = &(~result);
	assign n = result[N-1];
	assign c = ~control[1] & sum_carry;
	assign v = ~(control[1] ^ a[N-1] ^ b[N-1]) & (a[N-1] ^ res_sum[N-1]) & ~control[1];

endmodule

/* 
Module: ALU_TOP_BTN
Controla la ALU mediante botones para seleccionar operaciones y muestra los resultados en displays de 7 segmentos.
Inputs:
- a: Logic input [4 bits] - Primer operando.
- b: Logic input [4 bits] - Segundo operando.
- clk: Logic input - Reloj para sincronización.
- btn_sumador: Logic input - Botón para incrementar el código de operación.
- btn_restador: Logic input - Botón para decrementar el código de operación.
Outputs:
- alu_out_7seg: Logic output [7 bits] - Resultado de la ALU en formato de 7 segmentos.
- oper_7seg: Logic output [7 bits] - Código de operación en formato de 7 segmentos.
- v: Logic output - Flag de overflow.
- c: Logic output - Flag de carry.
- n: Logic output - Flag de negativo.
- z: Logic output - Flag de cero.
- result: Logic output [4 bits] - Resultado de la operación.
Restriction:
- Los botones deben generar flancos negativos para cambiar el código de operación.
Example:
ALU_TOP_BTN alu_top_instance (
    .a(4'b1010),
    .b(4'b0101),
    .clk(clk_signal),
    .btn_sumador(btn_up),
    .btn_restador(btn_down),
    .alu_out_7seg(display_result),
    .oper_7seg(display_control),
    .v(v_flag),
    .c(c_flag),
    .n(n_flag),
    .z(z_flag),
    .result(result_output)
);
References:
[1] D. Harris y S. Harris, "Digital Design and Computer Architecture", 4th ed., ARM
edition, Morgan Kaufmann, 2021.
*/

module ALU_TOP_BTN (
    input  logic [3:0] a,
    input  logic [3:0] b,
	 input  logic clk,
    input  logic btn_sumador,
    input  logic btn_restador,
    output logic [0:6] alu_out_7seg,
    output logic [0:6] oper_7seg,
	 output logic v,
	 output logic c,
	 output logic n,
	 output logic z,
	 output logic [3:0] result
);

    logic [3:0] control = 4'd0;
    

    // Instancia de la ALU
    ALU_N_bits #(.N(4)) alu_inst (
        .a(a),
        .b(b),
        .control(control),
        .result(result),
        .v(v), .c(c), .n(n), .z(z)
    );

    // Lógica con botones (flancos negativos)
	logic btn_sumador_prev, btn_restador_prev;

	// Detener flancos
	always_ff @(posedge clk) begin
		 btn_sumador_prev   <= btn_sumador;
		 btn_restador_prev  <= btn_restador;
	end

	// Control de operación con flanco
	always_ff @(posedge clk) begin
		 // Detecta flanco de bajada en btn_sumador
		 if (btn_sumador_prev && !btn_sumador) begin
			  control <= (control >= 4'd9) ? 4'd0 : control + 1;
		 end
		 // Detecta flanco de bajada en btn_restador
		 else if (btn_restador_prev && !btn_restador) begin
			  control <= (control == 4'd0) ? 4'd9 : control - 1;
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

/* 
Module: Print_Single_Hex
Convierte un valor hexadecimal de 4 bits en su representación en un display de 7 segmentos.
Inputs:
- hex: Logic input [4 bits] - Valor hexadecimal a convertir.
Outputs:
- segment: Logic output [7 bits] - Representación en 7 segmentos.
Restriction:
- El valor de entrada debe estar en el rango de 0 a F (hexadecimal).
Example:
Print_Single_Hex hex_to_7seg (
    .hex(4'b1010),
    .segment(display_output)
);
References:
[1] D. Harris y S. Harris, "Digital Design and Computer Architecture", 4th ed., ARM
edition, Morgan Kaufmann, 2021.
*/

module Print_Single_Hex (
    input  logic [3:0] hex,
    output logic [0:6] segment
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

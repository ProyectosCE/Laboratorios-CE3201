/* 
================================== LICENCIA ================================================== 
MIT License
Copyright (c) 2025 José Bernardo Barquero Bonilla,
                   Alexander Montero Vargas,
                   Alvaro Vargas Molina
Consulta el archivo LICENSE para más detalles.
==============================================================================================
*/

/* Module: carry_lookahead_adder
Implementa un sumador de anticipación de acarreo (Carry Lookahead Adder) de N bits.
Este sumador mejora el rendimiento en comparación con un sumador en cascada al
reducir
la propagación del acarreo.
Params:
- DATA_WID: Parameter [Integer] - Ancho de los operandos de entrada y salida.
- in1: Logic input [DATA_WID bits] - Primer operando de entrada.
- in2: Logic input [DATA_WID bits] - Segundo operando de entrada.
- carry_in: Logic input [1 bit] - Bit de acarreo de entrada.
- sum: Logic output [DATA_WID bits] - Resultado de la suma.
- carry_out: Logic output [1 bit] - Bit de acarreo de salida.
Restriction:
- DATA_WID debe ser un número entero positivo.
- La suma se realiza bit a bit considerando la propagación del acarreo.
Example:
// Instanciación del módulo para 8 bits
carry_lookahead_adder #(8) cla_8bit (
.in1(8'b00011011),
.in2(8'b00100101),
.carry_in(1'b0),
.sum(result_sum),
.carry_out(result_carry)
);
Problems:
References:
[1] S. Harris y D. Harris, "Diseño digital y arquitectura de computadoras: Edición
ARM", Morgan Kaufmann, 2015.
*/

module carry_lookahead_adder #(parameter int DATA_WID = 32) (
    input  logic [DATA_WID-1:0] in1,
    input  logic [DATA_WID-1:0] in2,
    input  logic carry_in,
    output logic [DATA_WID-1:0] sum,
    output logic carry_out
);

    logic [DATA_WID-1:0] gen;   // Generación de acarreo (G)
    logic [DATA_WID-1:0] pro;   // Propagación de acarreo (P)
    logic [DATA_WID:0]   carry_tmp; // Acarreo intermedio

    always_comb begin
        carry_tmp[0] = carry_in;

        for (int j = 0; j < DATA_WID; j++) begin
            gen[j] = in1[j] & in2[j];   // Generación de acarreo
            pro[j] = in1[j] | in2[j];   // Propagación de acarreo
            carry_tmp[j+1] = gen[j] | (pro[j] & carry_tmp[j]); // Cálculo del acarreo
        end

        for (int i = 0; i < DATA_WID; i++) begin
            sum[i] = in1[i] ^ in2[i] ^ carry_tmp[i]; // Cálculo de suma
        end
    end

    assign carry_out = carry_tmp[DATA_WID]; // Asignación de salida

endmodule

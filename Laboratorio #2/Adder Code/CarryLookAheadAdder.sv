

module CarryLookAheadAdder (
    input  logic [3:0] i_add1,       // Operando 1
    input  logic [3:0] i_add2,       // Operando 2
    input  logic       i_carry_in,   // Entrada de acarreo
    output logic [4:0] o_result      // Resultado de 5 bits (incluye carry out)
);

    // Señales internas
    logic [3:0] w_G;  // Generación de acarreo
    logic [3:0] w_P;  // Propagación de acarreo
    logic [4:0] w_C;  // Acarreo en cada bit
    logic [3:0] w_SUM; // Suma parcial

    // Cálculo de los términos de generación (G) y propagación (P)
    assign w_G = i_add1 & i_add2; // Gi = Ai * Bi
    assign w_P = i_add1 | i_add2; // Pi = Ai + Bi

    // Cálculo de los acarreos en paralelo
    assign w_C[0] = i_carry_in;
    assign w_C[1] = w_G[0] | (w_P[0] & w_C[0]);
    assign w_C[2] = w_G[1] | (w_P[1] & w_G[0]) | (w_P[1] & w_P[0] & w_C[0]);
    assign w_C[3] = w_G[2] | (w_P[2] & w_G[1]) | (w_P[2] & w_P[1] & w_G[0]) | (w_P[2] & w_P[1] & w_P[0] & w_C[0]);
    assign w_C[4] = w_G[3] | (w_P[3] & w_G[2]) | (w_P[3] & w_P[2] & w_G[1]) | (w_P[3] & w_P[2] & w_P[1] & w_G[0]) | (w_P[3] & w_P[2] & w_P[1] & w_P[0] & w_C[0]);

    // Instancias de los sumadores completos (Usar el nombre correcto)
    Full_Adder FA0 (.i_bit1(i_add1[0]), .i_bit2(i_add2[0]), .i_carry(w_C[0]), .o_sum(w_SUM[0]));
    Full_Adder FA1 (.i_bit1(i_add1[1]), .i_bit2(i_add2[1]), .i_carry(w_C[1]), .o_sum(w_SUM[1]));
    Full_Adder FA2 (.i_bit1(i_add1[2]), .i_bit2(i_add2[2]), .i_carry(w_C[2]), .o_sum(w_SUM[2]));
    Full_Adder FA3 (.i_bit1(i_add1[3]), .i_bit2(i_add2[3]), .i_carry(w_C[3]), .o_sum(w_SUM[3]));

    // Resultado final
    assign o_result = {w_C[4], w_SUM};

endmodule

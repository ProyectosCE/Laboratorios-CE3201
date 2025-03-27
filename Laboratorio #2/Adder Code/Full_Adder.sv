module Full_Adder (
    input  logic i_bit1,  // Bit del primer operando
    input  logic i_bit2,  // Bit del segundo operando
    input  logic i_carry, // Entrada de acarreo
    output logic o_sum    // Resultado de la suma
);

    assign o_sum = i_bit1 ^ i_bit2 ^ i_carry; // Suma XOR

endmodule

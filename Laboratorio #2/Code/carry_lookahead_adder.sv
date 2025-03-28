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

module multiplier_cla #(
    parameter int MULTICAND_WID = 32,
    parameter int MULTIPLIER_WID = 32
) (
    input  logic [MULTICAND_WID-1:0] multicand,
    input  logic [MULTIPLIER_WID-1:0] multiplier,
    output logic [(MULTICAND_WID + MULTIPLIER_WID - 1):0] product
);

    logic [MULTICAND_WID-1:0] multicand_tmp [MULTIPLIER_WID];
    logic [MULTICAND_WID-1:0] product_tmp [MULTIPLIER_WID];
    logic [MULTIPLIER_WID-1:0] carry_tmp;

    // Generación de productos parciales
    always_comb begin
        for (int j = 0; j < MULTIPLIER_WID; j++) begin
            multicand_tmp[j] = multicand & {MULTICAND_WID{multiplier[j]}};
        end
    end

    // Inicialización de los primeros valores
    assign product_tmp[0] = multicand_tmp[0];
    assign carry_tmp[0] = 1'b0;
    assign product[0] = product_tmp[0][0];

    // Uso de CLA para sumas parciales
    genvar i;
    generate
        for (i = 1; i < MULTIPLIER_WID; i++) begin : adders
            carry_lookahead_adder #(.DATA_WID(MULTICAND_WID)) add1 (
                .sum(product_tmp[i]),
                .carry_out(carry_tmp[i]),
                .carry_in(carry_tmp[i-1]), 
                .in1(multicand_tmp[i]),
                .in2({carry_tmp[i-1], product_tmp[i-1][MULTICAND_WID-1:1]})
            );
        end
    endgenerate

    // Asignación de productos parciales
    genvar j;
    generate
        for (j = 1; j < MULTIPLIER_WID; j++) begin : product_assignments
            assign product[j] = product_tmp[j][0];  
        end
    endgenerate

    // Resultado final
    assign product[(MULTICAND_WID + MULTIPLIER_WID - 1):MULTIPLIER_WID] =
        {carry_tmp[MULTIPLIER_WID-1], product_tmp[MULTIPLIER_WID-1][MULTICAND_WID-1:1]};

endmodule

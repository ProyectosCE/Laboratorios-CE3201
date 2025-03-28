/* 
================================== LICENCIA ================================================== 
MIT License
Copyright (c) 2025 José Bernardo Barquero Bonilla,
                   Alexander Montero Vargas,
                   Alvaro Vargas Molina
Consulta el archivo LICENSE para más detalles.
==============================================================================================
*/

/* Module: multiplier_cla
Implementa un multiplicador basado en Carry Lookahead Adder (CLA) para mejorar la
velocidad de propagación de sumas parciales.
Se generan productos parciales y se suman usando un esquema de adición en cascada con
CLA.
Params:
- MULTICAND_WID: Entero - Ancho de bits del multiplicando.
- MULTIPLIER_WID: Entero - Ancho de bits del multiplicador.
Inputs:
- multicand: Logic input [MULTICAND_WID bits] - Multiplicando.
- multiplier: Logic input [MULTIPLIER_WID bits] - Multiplicador.
Outputs:
- product: Logic output [(MULTICAND_WID + MULTIPLIER_WID - 1) bits] -
Resultado de la multiplicación.
Restriction:
- Se asume que MULTICAND_WID y MULTIPLIER_WID son valores positivos y
predefinidos.
- No se ha implementado manejo de overflows explícito.
Example:
multiplier_cla #(.MULTICAND_WID(8), .MULTIPLIER_WID(8)) multiplier_instance
(
.multicand(8'b00011011),
.multiplier(8'b00000101),
.product(product_output)
);
Problems:
References:
[1] D. Harris y S. Harris, "Digital Design and Computer Architecture, ARM Edition",
2nd ed., Morgan Kaufmann, 2015.
*/
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
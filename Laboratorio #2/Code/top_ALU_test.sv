module top_ALU_test #(parameter N = 4)(
    input  logic tclk,
    input  logic reset,
    input  logic [3:0] control,
    input  logic [N-1:0] in_data,
    output logic [N-1:0] out_data
);

    // Registros
    logic [N-1:0] reg_in, alu_result;
    logic v, c, n, z;

    // Registro de entrada
    always_ff @(posedge tclk or posedge reset) begin
        if (reset)
            reg_in <= '0;
        else
            reg_in <= in_data;
    end

    // Instancia de la ALU
    ALU_N_bits #(.N(N)) alu_inst (
        .a(reg_in),
        .b(reg_in),            // Puedes cambiar esto si quieres usar otro operando
        .control(control),
        .result(alu_result),
        .v(v), .c(c), .n(n), .z(z)
    );

    // Registro de salida
    always_ff @(posedge tclk or posedge reset) begin
        if (reset)
            out_data <= '0;
        else
            out_data <= alu_result;
    end

endmodule

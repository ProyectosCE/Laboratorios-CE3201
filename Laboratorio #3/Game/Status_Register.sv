// -----------------------------------------------------------------------------
// Status_Register.sv
// Registro de estado del sistema (FSM, errores, fin de juego, etc.)
// -----------------------------------------------------------------------------

module Status_Register (
    input  logic       clk,
    input  logic       rst,
    input  logic       write_en,
    input  logic [7:0] new_state,
    output logic [7:0] current_state
);

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            current_state <= 8'h00;  // Estado por defecto: jugando
        end else if (write_en) begin
            current_state <= new_state;
        end
    end

endmodule

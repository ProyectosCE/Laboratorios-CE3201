// Captura de jugadas del Jugador 1 desde switches y botón de confirmación

module Player1_Input (
    input  logic       clk,
    input  logic       rst,
    input  logic       btn_confirm,
    input  logic [2:0] switches,      // Selección de columna (0-6)
    output logic       valid_move,    // Pulso de confirmación de jugada
    output logic [2:0] selected_col   // Columna seleccionada
);

    logic btn_confirm_sync, btn_confirm_prev;

    // Registro de switches en flanco positivo de confirmación
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            selected_col <= 3'd0;
            btn_confirm_prev <= 0;
            valid_move <= 0;
        end else begin
            btn_confirm_prev <= btn_confirm;

            // Detectar flanco de subida del botón
            if (btn_confirm && !btn_confirm_prev) begin
                selected_col <= switches;
                valid_move <= 1;
            end else begin
                valid_move <= 0;
            end
        end
    end

endmodule

module Restador #(
    parameter N = 6  // Ancho de bits
)(
    input  logic        clk,      // Reloj
    input  logic        rst,      // Reset asíncrono
    input  logic        btn_sub,  // Botón para restar
    input  logic [N-1:0] data_in, // Valor inicial (switches)
    output logic [N-1:0] data_out // Valor actual
);

    // Registro para almacenar el valor y sincronizar el botón
    // Se usan dos registros para sincronización y detección de flanco
    logic btn_sync, btn_sync_2, btn_edge;
    
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            data_out   <= data_in;  // Inicializa data_out con data_in
            btn_sync   <= 1'b0;
            btn_sync_2 <= 1'b0;
        end else begin
            btn_sync   <= btn_sub;
            btn_sync_2 <= btn_sync;
            // Detecta el flanco ascendente del botón
            if (btn_sync & ~btn_sync_2) begin
                data_out <= data_out - 1;
            end
        end
    end
endmodule

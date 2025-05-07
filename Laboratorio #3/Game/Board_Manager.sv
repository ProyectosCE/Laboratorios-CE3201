// Gestión de tablero Connect 4 (6x7) - Inserción de fichas y reinicio
module Board_Manager (
    input logic clk,
    input logic rst,
    input logic insert_en,
    input logic [1:0] player_id,  // 01 jugador 1, 10 jugador 2
    input logic [2:0] col_sel,    // columna seleccionada (0-6)
    output logic col_full,        // indica si columna está llena
    output logic [1:0] board [0:5][0:6]  // matriz 6 filas x 7 columnas
);

    // Inicializar la matriz del tablero
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            integer i, j;
            for (i = 0; i < 6; i = i + 1) begin
                for (j = 0; j < 7; j = j + 1) begin
                    board[i][j] <= 2'b00; // Vacío
                end
            end
        end else begin
            if (insert_en) begin
                // Buscar la primera posición libre de abajo hacia arriba en la columna seleccionada
                integer row;
                logic inserted;
                inserted = 0;
                for (row = 5; row >= 0; row = row - 1) begin
                    if (!inserted && board[row][col_sel] == 2'b00) begin
                        board[row][col_sel] <= player_id;
                        inserted = 1;
                    end
                end
            end
        end
    end

    // Comprobar si la columna está llena
    always_comb begin
        if (board[0][col_sel] != 2'b00)
            col_full = 1;
        else
            col_full = 0;
    end

endmodule

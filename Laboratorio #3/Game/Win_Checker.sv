// Módulo que detecta si hay 4 fichas iguales alineadas (jugador gana)
module Win_Checker (
    input  logic clk,
    input  logic rst,
    input  logic check_en,
    input  logic [1:0] board [0:5][0:6],
    output logic win_flag,
    output logic [1:0] winner_id
);

    logic [1:0] current_cell;
    integer row, col;
    logic found;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            win_flag   <= 0;
            winner_id  <= 2'b00;
        end else if (check_en) begin
            found = 0;
            win_flag <= 0;
            winner_id <= 2'b00;

            for (row = 0; row < 6; row = row + 1) begin
                for (col = 0; col < 7; col = col + 1) begin
                    current_cell = board[row][col];
                    if (current_cell != 2'b00) begin

                        // Horizontal →
                        if (col <= 3 &&
                            current_cell == board[row][col+1] &&
                            current_cell == board[row][col+2] &&
                            current_cell == board[row][col+3]) begin
                            found = 1;
                            win_flag <= 1;
                            winner_id <= current_cell;
                        end

                        // Vertical ↓
                        if (row <= 2 &&
                            current_cell == board[row+1][col] &&
                            current_cell == board[row+2][col] &&
                            current_cell == board[row+3][col]) begin
                            found = 1;
                            win_flag <= 1;
                            winner_id <= current_cell;
                        end

                        // Diagonal ↘
                        if (row <= 2 && col <= 3 &&
                            current_cell == board[row+1][col+1] &&
                            current_cell == board[row+2][col+2] &&
                            current_cell == board[row+3][col+3]) begin
                            found = 1;
                            win_flag <= 1;
                            winner_id <= current_cell;
                        end

                        // Diagonal ↗
                        if (row >= 3 && col <= 3 &&
                            current_cell == board[row-1][col+1] &&
                            current_cell == board[row-2][col+2] &&
                            current_cell == board[row-3][col+3]) begin
                            found = 1;
                            win_flag <= 1;
                            winner_id <= current_cell;
                        end
                    end
                end
            end
        end else begin
            win_flag <= 0;
            winner_id <= 2'b00;
        end
    end

endmodule

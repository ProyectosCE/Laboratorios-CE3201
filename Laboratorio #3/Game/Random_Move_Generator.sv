// Genera una columna aleatoria válida entre las que no están llenas
module Random_Move_Generator (
    input  logic clk,
    input  logic rst,
    input  logic enable,
    input  logic [1:0] board [0:5][0:6],
    output logic [2:0] valid_col,
    output logic       valid
);

    logic [2:0] rand_col;
    integer attempt;
    logic found;

    // LFSR pseudoaleatorio de 3 bits (0–6)
	 // Referencia: https://www.analog.com/en/resources/design-notes/random-number-generation-using-lfsr.html
    always_ff @(posedge clk or negedge rst) begin
        if (!rst) begin
            rand_col <= 3'd1;
        end else if (enable) begin
            rand_col <= {rand_col[1:0], rand_col[2] ^ rand_col[1]};
        end
    end

    // Selección de columna válida
    always_ff @(posedge clk or negedge rst) begin
        if (!rst) begin
            valid_col <= 3'd0;
            valid     <= 0;
        end else if (enable) begin
            found = 0;
            for (attempt = 0; attempt < 7; attempt = attempt + 1) begin
                if (board[0][(rand_col + attempt) % 7] == 2'b00 && !found) begin
                    valid_col <= (rand_col + attempt) % 7;
                    valid <= 1;
                    found = 1;
                end
            end
            if (!found) begin
                valid <= 0;
                valid_col <= 3'd0;
            end
        end else begin
            valid <= 0;
        end
    end

endmodule

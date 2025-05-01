// Testbench para el módulo Random_Move_Generator
`timescale 1ns / 1ps

module tb_Random_Move_Generator;

    logic clk, rst, enable;
    logic [1:0] board [0:5][0:6];
    logic [2:0] valid_col;
    logic valid;

    // DUT instanciado
    Random_Move_Generator dut (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .board(board),
        .valid_col(valid_col),
        .valid(valid)
    );

    // Generador de reloj
    always #10 clk = ~clk;

    // Limpia el tablero
    task clear_board();
        integer i, j;
        begin
            for (i = 0; i < 6; i++) begin
                for (j = 0; j < 7; j++) begin
                    board[i][j] = 2'b00;
                end
            end
        end
    endtask

    // Llena todas las columnas
    task fill_board();
        integer j;
        begin
            for (j = 0; j < 7; j++) begin
                board[0][j] = 2'b01;  // Solo la fila 0 importa
            end
        end
    endtask

    initial begin
        $display("Inicio del test para Random_Move_Generator");

        clk = 0;
        rst = 1;
        enable = 0;

        @(negedge clk);
        rst = 0;

        // CASO 1: Tablero vacío
        clear_board();
        @(negedge clk);
        enable = 1;
        @(negedge clk);
        enable = 0;

        @(negedge clk);
        $display("Columna válida: %0d | valid = %b (esperado 1)", valid_col, valid);

        // CASO 2: Tablero parcialmente lleno
        clear_board();
        board[0][0] = 2'b10;
        board[0][1] = 2'b10;
        board[0][2] = 2'b10;
        board[0][3] = 2'b10;
        board[0][4] = 2'b10;
        board[0][5] = 2'b10;

        @(negedge clk);
        enable = 1;
        @(negedge clk);
        enable = 0;

        @(negedge clk);
        $display("Columna válida: %0d | valid = %b (esperado 1, única libre col 6)", valid_col, valid);

        // CASO 3: Tablero lleno
        fill_board();
        @(negedge clk);
        enable = 1;
        @(negedge clk);
        enable = 0;

        @(negedge clk);
        $display("Columna válida: %0d | valid = %b (esperado 0)", valid_col, valid);

        $display("Fin del test para Random_Move_Generator");
        $finish;
    end

endmodule

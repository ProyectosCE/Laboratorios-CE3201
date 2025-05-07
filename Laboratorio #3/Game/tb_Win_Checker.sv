// Testbench para el módulo Win_Checker
`timescale 1ns / 1ps

module tb_Win_Checker;

    logic clk, rst, check_en;
    logic [1:0] board [0:5][0:6];
    logic win_flag;
    logic [1:0] winner_id;

    Win_Checker dut (
        .clk(clk),
        .rst(rst),
        .check_en(check_en),
        .board(board),
        .win_flag(win_flag),
        .winner_id(winner_id)
    );

    // Generador de reloj
    always #10 clk = ~clk;

    // Tarea para reiniciar tablero
    task clear_board();
        integer i, j;
        for (i = 0; i < 6; i++) begin
            for (j = 0; j < 7; j++) begin
                board[i][j] = 2'b00;
            end
        end
    endtask

    // Tarea para imprimir resultado de prueba
    task print_result(string desc);
        $display(">>> %s", desc);
        $display("WIN: %0b, WINNER: %0d", win_flag, winner_id);
        $display("---------------------------\n");
    endtask

    // Tarea para activar verificación
    task check();
        @(negedge clk);
        check_en = 1;
        @(negedge clk);
        check_en = 0;
        @(negedge clk);
    endtask

    initial begin
        $display("Inicio del test para Win_Checker");

        // Inicialización
        clk = 0;
        rst = 1;
        check_en = 0;
        clear_board();

        @(negedge clk);
        rst = 0;
        @(negedge clk);

        // Caso 1: Horizontal →
        clear_board();
        board[5][0] = 2'b01;
        board[5][1] = 2'b01;
        board[5][2] = 2'b01;
        board[5][3] = 2'b01;
        check();
        print_result("Horizontal - Jugador 1");

        // Caso 2: Vertical ↓
        clear_board();
        board[2][4] = 2'b10;
        board[3][4] = 2'b10;
        board[4][4] = 2'b10;
        board[5][4] = 2'b10;
        check();
        print_result("Vertical - Jugador 2");

        // Caso 3: Diagonal ↘
        clear_board();
        board[2][0] = 2'b01;
        board[3][1] = 2'b01;
        board[4][2] = 2'b01;
        board[5][3] = 2'b01;
        check();
        print_result("Diagonal ↘ - Jugador 1");

        // Caso 4: Diagonal ↗
        clear_board();
        board[5][0] = 2'b10;
        board[4][1] = 2'b10;
        board[3][2] = 2'b10;
        board[2][3] = 2'b10;
        check();
        print_result("Diagonal ↗ - Jugador 2");

        // Caso 5: No hay ganador
        clear_board();
        board[5][0] = 2'b01;
        board[5][1] = 2'b10;
        board[5][2] = 2'b01;
        board[5][3] = 2'b10;
        check();
        print_result("Sin ganador");

        $display("Fin del test.");
        $finish;
    end

endmodule

// Testbench para módulo Player1_Input
`timescale 1ns / 1ps

module tb_Player1_Input;

    logic clk, rst;
    logic btn_confirm;
    logic [2:0] switches;
    logic valid_move;
    logic [2:0] selected_col;

    Player1_Input dut (
        .clk(clk),
        .rst(rst),
        .btn_confirm(btn_confirm),
        .switches(switches),
        .valid_move(valid_move),
        .selected_col(selected_col)
    );

    always #10 clk = ~clk;  // 50MHz clock

    initial begin
        $display("Inicio del test para Player1_Input");

        // Inicialización
        clk = 0;
        rst = 1;
        btn_confirm = 0;
        switches = 3'd0;

        @(negedge clk);
        rst = 0;

        // Jugada 1: columna 4
        @(negedge clk);
        switches = 3'd4;
        btn_confirm = 1;
        @(negedge clk);
        btn_confirm = 0;

        // Esperar y verificar pulso
        repeat (2) @(negedge clk);
        $display("Jugada confirmada: col = %0d, valid_move = %b", selected_col, valid_move);

        // Jugada 2: columna 6
        @(negedge clk);
        switches = 3'd6;
        btn_confirm = 1;
        @(negedge clk);
        btn_confirm = 0;

        repeat (2) @(negedge clk);
        $display("Jugada confirmada: col = %0d, valid_move = %b", selected_col, valid_move);

        $display("Fin del test para Player1_Input.");
        $finish;
    end

endmodule

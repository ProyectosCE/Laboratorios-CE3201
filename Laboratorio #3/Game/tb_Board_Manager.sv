// Testbench para módulo Board_Manager

`timescale 1ns / 1ps

module tb_Board_Manager;

    // Señales de prueba
    logic clk;
    logic rst;
    logic insert_en;
    logic [1:0] player_id;
    logic [2:0] col_sel;
    logic col_full;
    logic [1:0] board [0:5][0:6];

    // Instanciar el DUT (Device Under Test)
    Board_Manager dut (
        .clk(clk),
        .rst(rst),
        .insert_en(insert_en),
        .player_id(player_id),
        .col_sel(col_sel),
        .col_full(col_full),
        .board(board)
    );

    // Generar el reloj (50 MHz típico)
    always #10 clk = ~clk;

    // Tarea para imprimir el estado del tablero
    task print_board;
        integer i, j;
        begin
            $display("------------- TABLERO -------------");
            for (i = 0; i < 6; i++) begin
                for (j = 0; j < 7; j++) begin
                    $write("%0d ", board[i][j]);
                end
                $write("\n");
            end
            $display("-----------------------------------\n");
        end
    endtask

    // Tarea para insertar una ficha
    task insert_piece(input [1:0] p_id, input [2:0] col);
        begin
            @(negedge clk);
            player_id = p_id;
            col_sel = col;
            insert_en = 1;
            @(negedge clk);
            insert_en = 0;
            @(negedge clk);  // esperar a que se estabilice
            print_board();
            $display("col_full = %0b\n", col_full);
        end
    endtask

    // Secuencia de prueba
    initial begin
        $display("Inicio del testbench para Board_Manager");

        // Inicializar señales
        clk = 0;
        rst = 1;
        insert_en = 0;
        player_id = 2'b00;
        col_sel = 3'b000;

        // Reset
        @(negedge clk);
        rst = 0;
        @(negedge clk);
        rst = 1;
        @(negedge clk);
        rst = 0;

        print_board();

        // Insertar fichas en columna 3
        insert_piece(2'b01, 3);  // Jugador 1
        insert_piece(2'b10, 3);  // Jugador 2
        insert_piece(2'b01, 3);
        insert_piece(2'b10, 3);
        insert_piece(2'b01, 3);
        insert_piece(2'b10, 3);  // Esta debería llenar la columna

        // Intentar insertar en columna ya llena
        insert_piece(2'b01, 3);

        // Insertar en otra columna
        insert_piece(2'b10, 0);

        $display("Fin del test.");
        $finish;
    end

endmodule

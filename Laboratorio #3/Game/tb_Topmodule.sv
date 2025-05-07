// -----------------------------------------------------------------------------
// tb_TopModule.sv
// Testbench para TopModule del juego Connect 4
// Simula una jugada por jugador y una victoria para P2
// -----------------------------------------------------------------------------

`timescale 1ns / 1ps

module tb_TopModule;

    logic clk, rst, fsm_reset;
    logic btn_confirm_p1;
    logic [2:0] switches_p1;
    logic spi_clk, spi_mosi, spi_cs;
    logic hsync, vsync;
    logic [7:0] red, green, blue;
    logic [6:0] seg;

    TopModule dut (
        .clk(clk), .rst(rst), .fsm_reset(fsm_reset),
        .btn_confirm_p1(btn_confirm_p1),
        .switches_p1(switches_p1),
        .spi_clk(spi_clk), .spi_mosi(spi_mosi), .spi_cs(spi_cs),
        .hsync(hsync), .vsync(vsync),
        .red(red), .green(green), .blue(blue),
        .seg(seg)
    );

    // Generador de reloj
    always #10 clk = ~clk;

    initial begin
        $display("Inicio del test para TopModule (juego Connect 4)");

        clk = 0;
        rst = 1;
        fsm_reset = 0;
        btn_confirm_p1 = 0;
        switches_p1 = 3'd0;
        spi_clk = 0;
        spi_mosi = 0;
        spi_cs = 1;  // CS desactivado

        @(negedge clk);
        rst = 0;

        // --- Turno de Jugador 1 ---
        @(negedge clk);
        switches_p1 = 3'd2; // columna 2
        btn_confirm_p1 = 1;
        @(negedge clk);
        btn_confirm_p1 = 0;

        // --- Turno de Jugador 2 (SPI simulado: columna 3 = 00000011) ---
        spi_cs = 0;
        send_spi_byte(8'b00000011); // columna 3
        spi_cs = 1;

        // Simula victoria de jugador 2
        force dut.win_flag = 1;
        force dut.winner_id = 2'b10;
        @(negedge clk);
        release dut.win_flag;
        release dut.winner_id;

        // Reset manual
        fsm_reset = 1;
        @(negedge clk);
        fsm_reset = 0;

        $display("Fin del test para TopModule");
        $finish;
    end

    // Tarea para enviar un byte por SPI simuladamente (MSB first)
    task send_spi_byte(input [7:0] data);
        integer i;
        begin
            for (i = 7; i >= 0; i = i - 1) begin
                spi_mosi = data[i];
                spi_clk = 0;
                #10;
                spi_clk = 1;
                #10;
            end
        end
    endtask

endmodule

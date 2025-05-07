// Testbench para módulo Turn_Timer con frecuencia reducida (10Hz simulado)
`timescale 1ns / 1ps

module tb_Turn_Timer;

    parameter CLK_FREQ = 10;  // Simulación rápida: 1 tick por 0.1 s aprox

    logic clk, rst, enable, reset_timer;
    logic timeout;
    logic [3:0] count_seconds;

    Turn_Timer #(
        .CLK_FREQ(CLK_FREQ)
    ) dut (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .reset_timer(reset_timer),
        .timeout(timeout),
        .count_seconds(count_seconds)
    );

    // Generador de reloj (simulado rápido)
    always #10 clk = ~clk;  // 50 MHz reloj virtual

    initial begin
        $display("Inicio del test para Turn_Timer");

        // Inicialización
        clk = 0;
        rst = 1;
        enable = 0;
        reset_timer = 0;

        @(negedge clk);
        rst = 0;

        // Activar temporizador
        enable = 1;

        repeat (12) begin
            @(negedge clk);
            $display("Tiempo: %0t | count_seconds = %0d | timeout = %b", $time, count_seconds, timeout);
        end

        // Reiniciar temporizador
        $display("Reiniciando...");
        reset_timer = 1;
        @(negedge clk);
        reset_timer = 0;

        repeat (5) begin
            @(negedge clk);
            $display("Tiempo: %0t | count_seconds = %0d | timeout = %b", $time, count_seconds, timeout);
        end

        $display("Fin del test para Turn_Timer");
        $finish;
    end

endmodule

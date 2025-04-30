// Testbench para módulo SevenSeg_Controller
`timescale 1ns / 1ps

module tb_SevenSeg_Controller;

    logic clk, rst;
    logic [3:0] seconds;
    logic [6:0] segments;

    // Instancia del módulo
    SevenSeg_Controller dut (
        .clk(clk),
        .rst(rst),
        .seconds(seconds),
        .segments(segments)
    );

    // Reloj simple
    always #10 clk = ~clk;

    initial begin
        $display("Inicio del test para SevenSeg_Controller");

        clk = 0;
        rst = 1;
        seconds = 0;

        @(negedge clk);
        rst = 0;

        // Recorrer valores de 0 a 10
        repeat (11) begin
            @(negedge clk);
            $display("seconds = %0d -> segments = %b", seconds, segments);
            seconds = seconds + 1;
        end

        // Probar valor inválido (11)
        @(negedge clk);
        seconds = 4'd11;
        @(negedge clk);
        $display("seconds = %0d -> segments = %b (esperado apagado)", seconds, segments);

        $display("Fin del test para SevenSeg_Controller");
        $finish;
    end

endmodule

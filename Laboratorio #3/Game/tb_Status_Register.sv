// Testbench para módulo Status_Register
`timescale 1ns / 1ps

module tb_Status_Register;

    logic clk, rst;
    logic write_en;
    logic [7:0] new_state;
    logic [7:0] current_state;

    // Instancia del DUT
    Status_Register dut (
        .clk(clk),
        .rst(rst),
        .write_en(write_en),
        .new_state(new_state),
        .current_state(current_state)
    );

    // Generador de reloj
    always #10 clk = ~clk;

    initial begin
        $display("Inicio del test para Status_Register");

        clk = 0;
        rst = 1;
        write_en = 0;
        new_state = 8'h00;

        @(negedge clk);
        rst = 0;

        // Estado tras reset
        @(negedge clk);
        $display("Estado inicial (reset): 0x%02h (esperado 00)", current_state);

        // Escribir 0x01 (Ganó Jugador 1)
        new_state = 8'h01;
        write_en = 1;
        @(negedge clk);
        write_en = 0;
        @(negedge clk);
        $display("Escribir 0x01: estado = 0x%02h", current_state);

        // No escribir: write_en = 0
        new_state = 8'hFF;
        @(negedge clk);
        $display("Sin escritura: estado = 0x%02h (esperado aún 0x01)", current_state);

        // Escribir 0x02 (Ganó Jugador 2)
        new_state = 8'h02;
        write_en = 1;
        @(negedge clk);
        write_en = 0;
        @(negedge clk);
        $display("Escribir 0x02: estado = 0x%02h", current_state);

        // Reset de nuevo
        rst = 1;
        @(negedge clk);
        rst = 0;
        @(negedge clk);
        $display("Estado tras nuevo reset: 0x%02h (esperado 00)", current_state);

        $display("Fin del test para Status_Register");
        $finish;
    end

endmodule

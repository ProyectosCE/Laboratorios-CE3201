// Temporizador de 10 segundos para controlar el turno de cada jugador
module Turn_Timer #(
    parameter integer CLK_FREQ = 50_000_000  // Frecuencia del reloj (50 MHz)
)(
    input  logic       clk,
    input  logic       rst,
    input  logic       enable,
    input  logic       reset_timer,
    output logic       timeout,
    output logic [3:0] count_seconds
);

    // Contador para generar pulso de 1 segundo
    logic [$clog2(CLK_FREQ)-1:0] cycle_counter;
    logic tick_1s;

    // Pulso de 1 segundo
    always_ff @(posedge clk) begin
        if (rst || reset_timer || !enable) begin
            cycle_counter <= 0;
            tick_1s <= 0;
        end else if (cycle_counter == CLK_FREQ - 1) begin
            cycle_counter <= 0;
            tick_1s <= 1;
        end else begin
            cycle_counter <= cycle_counter + 1;
            tick_1s <= 0;
        end
    end

    // Contador de segundos
    always_ff @(posedge clk) begin
        if (rst || reset_timer) begin
            count_seconds <= 0;
            timeout <= 0;
        end else if (enable && tick_1s) begin
            if (count_seconds == 4'd10) begin
                timeout <= 1;
            end else begin
                count_seconds <= count_seconds + 1;
                timeout <= 0;
            end
        end else begin
            timeout <= 0;
        end
    end

endmodule

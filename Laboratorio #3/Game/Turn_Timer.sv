module Turn_Timer #(
    parameter integer CLK_FREQ = 50_000_000  // Frecuencia del reloj (50 MHz)
)(
    input  logic       clk,
    input  logic       rst,
    input  logic       enable,
    input  logic       reset_timer,
    output logic       timeout,
    output logic [3:0] time_remaining
);

    // Contador de ciclos para 1 segundo
    localparam ONE_SECOND = CLK_FREQ - 1;
    logic [31:0] counter_1sec;

    // Contador de segundos (0 a 10)
    logic [3:0] seconds_cnt;

    always_ff @(posedge clk or negedge rst) begin
        if (!rst) begin
            counter_1sec <= 0;
            seconds_cnt  <= 0;
            timeout      <= 0;
        end else if (reset_timer) begin
            counter_1sec <= 0;
            seconds_cnt  <= 0;
            timeout      <= 0;
        end else if (enable) begin
            if (counter_1sec == ONE_SECOND) begin
                counter_1sec <= 0;
                if (seconds_cnt == 4'd10) begin
                    seconds_cnt <= 0;
                    timeout <= 1;
                end else begin
                    seconds_cnt <= seconds_cnt + 1;
                    timeout <= 0;
                end
            end else begin
                counter_1sec <= counter_1sec + 1;
                timeout <= 0;
            end
        end else begin
            timeout <= 0;
        end
    end

    assign time_remaining = seconds_cnt;

endmodule

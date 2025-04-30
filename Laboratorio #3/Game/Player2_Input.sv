// Comunicación SPI básica para recibir jugada del Jugador 2 desde Arduino

// Referencias:
// - https://zipcpu.com/blog/2018/08/16/spiflash.html
// - https://www.fpga4student.com/2017/08/spi-verilog-code-tb.html
// - https://docs.arduino.cc/learn/communication/spi/
// - https://www.fpga4fun.com/SPI.html
// - https://github.com/ZipCPU/wbspi/blob/master/rtl/rawslave.v

module Player2_Input (
    input  logic       clk,         // Reloj de FPGA
    input  logic       rst,         // Reset
    input  logic       spi_clk,     // Reloj SPI desde Arduino
    input  logic       spi_mosi,    // Dato SPI (MSB first)
    input  logic       spi_cs,      // Chip Select SPI (activo bajo)
    output logic [2:0] selected_col, // Columna recibida
    output logic       valid_move    // Jugada válida recibida
);

    logic [7:0] shift_reg;
    logic [2:0] bit_count;
    logic       spi_clk_prev;

    // Detección de flanco de subida en spi_clk
    always_ff @(posedge clk) begin
        spi_clk_prev <= spi_clk;
    end

    wire spi_clk_rising = (spi_clk == 1) && (spi_clk_prev == 0);

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            shift_reg     <= 8'd0;
            bit_count     <= 0;
            selected_col  <= 3'd0;
            valid_move    <= 0;
        end else if (~spi_cs) begin  // Activo cuando CS está bajo
            if (spi_clk_rising) begin
                shift_reg <= {shift_reg[6:0], spi_mosi};
                bit_count <= bit_count + 1;

                if (bit_count == 7) begin
                    // Último bit recibido: tomar parte baja como columna
                    selected_col <= shift_reg[2:0];  // bits 2:0
                    valid_move <= 1;
                end else begin
                    valid_move <= 0;
                end
            end
        end else begin
            bit_count <= 0;
            valid_move <= 0;
        end
    end

endmodule

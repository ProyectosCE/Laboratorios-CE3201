// Controlador VGA sin implementación, para integración inicial
module VGA_Controller (
    input  logic        clk,
    input  logic        rst,
    input  logic [1:0]  board [0:5][0:6], // estado del tablero
    output logic        hsync,
    output logic        vsync,
    output logic [7:0]  red,
    output logic [7:0]  green,
    output logic [7:0]  blue
);

    // Señales VGA fijas mientras no haya implementación
    assign hsync = 1'b1;
    assign vsync = 1'b1;
    assign red   = 8'd0;
    assign green = 8'd0;
    assign blue  = 8'd0;

endmodule

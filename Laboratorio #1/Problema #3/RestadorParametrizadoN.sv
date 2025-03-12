module Restador #(
    parameter N = 6  // Ancho de bits
)(
    input  logic         btn_sub,  // Botón para restar (activo bajo)
    input  logic         btn_rst,  // Botón de reset (activo bajo)
    input  logic [N-1:0] data_in,  // Valor inicial (switches)
    output logic [N-1:0] data_out  // Valor actual
);


    // Bloque secuencial para la resta y el reset
    always_ff @(negedge btn_sub, negedge btn_rst) begin
        if (!btn_rst) begin
            data_out <= data_in; // Reset: cargar el valor de data_in
        end else if (!btn_sub) begin
            data_out <= data_out - 1; // Restar en flanco negativo de btn_sub
        end
    end

endmodule



module Binario_a_BCD(
    input  logic [5:0] bin_in,   // Entrada binaria de 6 bits
    output logic [7:0] bcd_out   // Salida BCD: [7:4]=decenas, [3:0]=unidades
);
    always_comb begin
        bcd_out[7:4] = bin_in / 10; // Decenas
        bcd_out[3:0] = bin_in % 10; // Unidades
    end
endmodule


module Decodificador7Segmentos (
    input  logic [7:0] BCD,         // Entrada BCD: [7:4] decenas, [3:0] unidades
    output logic [0:13] seg_out     // Salida para dos displays de 7 segmentos
);
    logic [6:0] seg_unidades, seg_decenas;

    always_comb begin
        // Decodificación para unidades
        case(BCD[3:0])
            4'd0: seg_unidades = 7'b0000001;
            4'd1: seg_unidades = 7'b1001111;
            4'd2: seg_unidades = 7'b0010010;
            4'd3: seg_unidades = 7'b0000110;
            4'd4: seg_unidades = 7'b1001100;
            4'd5: seg_unidades = 7'b0100100;
            4'd6: seg_unidades = 7'b0100000;
            4'd7: seg_unidades = 7'b0001111;
            4'd8: seg_unidades = 7'b0000000;
            4'd9: seg_unidades = 7'b0000100;
            default: seg_unidades = 7'b0000001;
        endcase

        // Decodificación para decenas
        case(BCD[7:4])
            4'd0: seg_decenas = 7'b0000001;
            4'd1: seg_decenas = 7'b1001111;
            4'd2: seg_decenas = 7'b0010010;
            4'd3: seg_decenas = 7'b0000110;
            4'd4: seg_decenas = 7'b1001100;
            4'd5: seg_decenas = 7'b0100100;
            4'd6: seg_decenas = 7'b0100000;
            default: seg_decenas = 7'b0000001;
        endcase

        // Concatena decenas y unidades (big-endian)
        seg_out = {seg_unidades,seg_decenas};
    end
endmodule

module RestadorParametrizableN (
    //input  logic       clk,      // Reloj
    input  logic       btn_rst,      // Reset asíncrono
    input  logic       btn_sub,  // Botón para restar
    input  logic [5:0] data_in,  // Valor inicial (switches)
    output logic [0:13] seg_out   // Salida para displays de 7 segmentos
);

    // Señales internas para interconexión
    logic [5:0] data_out;
    logic [7:0] bcd;

    // Instanciación del módulo Restador (lógica principal)
    Restador #(.N(6)) u_restador (
        .btn_rst(btn_rst),
        .btn_sub(btn_sub),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Instanciación del módulo de conversión a BCD
    Binario_a_BCD u_bin2bcd (
        .bin_in(data_out),
        .bcd_out(bcd)
    );

    // Instanciación del módulo decodificador a 7 segmentos
    Decodificador7Segmentos u_decodificador (
        .BCD(bcd),
        .seg_out(seg_out)
    );

endmodule


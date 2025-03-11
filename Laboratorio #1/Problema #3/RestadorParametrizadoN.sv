module Subtractor #(
    parameter N = 6  // Parámetro para definir el ancho de bits
)(
    input  logic [N-1:0] data_in,  // Valor inicial (de los switches)
    input  logic         clk,      // Reloj
    input  logic         btn_sub,  // Botón para restar
    output logic [N-1:0] data_out  // Valor actual (salida)
);

    // Registros internos para detección de flanco
    logic btn_sync;
    logic btn_sync_2;

    // Sincronizar el botón al reloj para evitar metastabilidad
    always_ff @(posedge clk) begin
        btn_sync   <= btn_sub;
        btn_sync_2 <= btn_sync;
    end

    // Detección de flanco ascendente (btn_edge = 1 cuando hay transición 0->1)
    logic btn_edge;
    assign btn_edge = (btn_sync & ~btn_sync_2);

    // Lógica secuencial para restar 1
    always_ff @(posedge clk) begin
        if (btn_edge) begin
            // Cada flanco en el botón descuenta 1
            data_out <= data_out - 1;
        end
        // De lo contrario, no hay cambio
    end

endmodule

module ResetHandler #(
    parameter N = 6  // Parámetro para definir el ancho de bits
)(
    input  logic [N-1:0] data_in,  // Valor inicial (de los switches)
    input  logic         rst,      // Reset asíncrono
    output logic [N-1:0] data_out  // Valor actual (salida)
);

    // Lógica secuencial con reset asíncrono
    always_ff @(posedge rst) begin
        if (rst) begin
            // Al reset, volver al valor de los switches
            data_out <= data_in;
        end
    end

endmodule

module Binario_a_BCD(
    input  logic [5:0] bin_in,  // Entrada de 6 bits
    output logic [7:0] bcd_out
);
    always_comb begin
        // Convierte la entrada binaria a BCD usando división y módulo
        bcd_out[7:4] = bin_in / 10; // Decenas
        bcd_out[3:0] = bin_in % 10; // Unidades
    end
endmodule

module BCD_Print_Segment (
    input  logic [7:0] BCD,
    output logic [0:13] double7segment
);
    logic [6:0] unidades_segment;
    logic [6:0] decenas_segment;

    always_comb begin
        // Decodificación de las unidades
        if (BCD[3:0] == 4'd0) unidades_segment = 7'b0000001;
        else if (BCD[3:0] == 4'd1) unidades_segment = 7'b1001111;
        else if (BCD[3:0] == 4'd2) unidades_segment = 7'b0010010;
        else if (BCD[3:0] == 4'd3) unidades_segment = 7'b0000110;
        else if (BCD[3:0] == 4'd4) unidades_segment = 7'b1001100;
        else if (BCD[3:0] == 4'd5) unidades_segment = 7'b0100100;
        else if (BCD[3:0] == 4'd6) unidades_segment = 7'b0100000;
        else if (BCD[3:0] == 4'd7) unidades_segment = 7'b0001111;
        else if (BCD[3:0] == 4'd8) unidades_segment = 7'b0000000;
        else if (BCD[3:0] == 4'd9) unidades_segment = 7'b0000100;
        else unidades_segment = 7'b0000001; // Por defecto, muestra 0

        // Decodificación de las decenas
        if (BCD[7:4] == 4'd0) decenas_segment = 7'b0000001;
        else if (BCD[7:4] == 4'd1) decenas_segment = 7'b1001111;
        else if (BCD[7:4] == 4'd2) decenas_segment = 7'b0010010;
        else if (BCD[7:4] == 4'd3) decenas_segment = 7'b0000110;
        else if (BCD[7:4] == 4'd4) decenas_segment = 7'b1001100;
        else if (BCD[7:4] == 4'd5) decenas_segment = 7'b0100100;
        else if (BCD[7:4] == 4'd6) decenas_segment = 7'b0100000;
        else decenas_segment = 7'b0000001; // Por defecto, muestra 0

        // Combinación de los segmentos en BIG-ENDIAN
        double7segment = {decenas_segment, unidades_segment};
    end
endmodule

module RestadorParametrizableN(
    input  logic         clk,      // Reloj
    input  logic         rst,      // Reset asíncrono
    input  logic [5:0]   data_in,  // Valor inicial (switches)
    input  logic         btn_sub,  // Botón para restar
    output logic [5:0]   data_out  // Valor actual
);

    // Sincronización del botón y detección de flanco
    logic btn_sync, btn_sync_2;
    always_ff @(posedge clk) begin
        btn_sync   <= btn_sub;
        btn_sync_2 <= btn_sync;
    end

    // Asignación combinacional para la detección de flanco
    logic btn_edge;
    assign btn_edge = btn_sync & ~btn_sync_2;

    // Lógica secuencial (un único registro) con reset asíncrono
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            // Al reset, cargamos data_in
            data_out <= data_in;
        end 
        else if (btn_edge) begin
            // Cada flanco de btn_sub, resta 1
            data_out <= data_out - 1;
        end
        // En caso contrario, no hacemos nada, conserva el valor
    end
endmodule


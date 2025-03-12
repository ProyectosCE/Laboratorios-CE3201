/* 
================================== LICENCIA ================================================== 
MIT License
Copyright (c) 2025 José Bernardo Barquero Bonilla,
                   Alexander Montero Vargas,
                   Alvaro Vargas Molina
Consulta el archivo LICENSE para más detalles.
==============================================================================================
*/

/* Module: Restador
     Módulo que decrementa en 1 un valor de N bits al detectar un flanco negativo 
     en el botón btn_sub (activo en bajo). Adicionalmente, permite un reset asíncrono 
     al detectar el flanco negativo del botón btn_rst (también activo en bajo), 
     cargando en la salida el valor de data_in.

   Parameter:
     - N: Ancho de bits para los puertos data_in y data_out (por defecto, N=6).

   Puertos:
     - btn_sub:  Input logic (activo bajo)
         Botón para realizar la resta. Cada flanco negativo en esta señal decrementa data_out.
     - btn_rst:  Input logic (activo bajo)
         Botón de reset asíncrono. Cada flanco negativo en esta señal carga data_in en data_out.
     - data_in:  Input logic [N-1:0]
         Valor inicial utilizado para el reset tomado de los switches.
     - data_out: Output logic [N-1:0]
         Valor actual, el cual se modifica según los eventos de resta o reset.

   Restriction:
     - N define el rango máximo para la operación de resta. 
       (Si data_out es 0 y se sigue restando, puede haber underflow y se muestra el complemento a la base,
       por lo que vuelve a mostrar el numero máximo del tamaño de los N bits).

   Example:
     Ver resuldatos del testbench RestadorParametrizadoN_tb.sv

   Problems:
     - Los botones de reset y resta deben ser activos en bajo.

   References:
     [1] reddit user: jappiedoedelzak, “Want to add a reset button”. 2022. [En línea]. 
            Disponible en: https://www.reddit.com/r/Verilog/comments/vtnjy4/want_to_add_a_reset_button/ [Accedido: 10-03-2025]
     [2] Terasic, DE10-Standard Development User Manual. 2017. [En línea]. 
            Disponible en: https://ftp.intel.com/Public/Pub/fpgaup/pub/Intel_Material/Boards/DE10-Standard/DE10_Standard_User_Manual.pdf  [Accedido: 07-03-2025]

*/
module Restador #(
    parameter N = 6  // Ancho de bits
)(
    input  logic         btn_sub,  // Botón para restar (activo bajo)
    input  logic         btn_rst,  // Botón de reset (activo bajo)
    input  logic [N-1:0] data_in,  // Valor inicial (switches)
    output logic [N-1:0] data_out  // Valor actual
);

    // Bloque secuencial para la resta y el reset asíncronos
    always_ff @(negedge btn_sub, negedge btn_rst) begin
        if (!btn_rst) begin
            data_out <= data_in;   // Reset asíncrono: cargar data_in
        end 
        else if (!btn_sub) begin
            data_out <= data_out - 1; // Resta en flanco negativo de btn_sub
        end
    end

endmodule

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


/* Module: Binario_a_BCD
   Convierte una entrada binaria de 6 bits a un BCD de 8 bits
	de la forma 4 bits para el numero de las decenas (0 o 1)
	y 4 bits pare el numero de las unidades (0 a 9)

   Ports:
     - bin_in: Logic input [6 bits] - Entrada binaria del numero según los switches, enviada
     - bcd_out: Logic Output [8 bits]- Salida del numero convertido a BCD (DECENAS_UNIDADES)
      
   Restriction: 
     La entrada máxima en bin_in es de 6 bits
	  
   Example:
		Ver testbench de este modulo en el archivo Decoder_tb.sv del problema #1

   Problems:
     Sin problemas mayores
	  
   References:
    [1] Wikipedia, la enciclopedia libre, “Decimal codificado en binario”. [En línea].
        Disponible en: https://es.wikipedia.org/wiki/Decimal_codificado_en_binario [Accedido: 07-03-2025]
*/
module Binario_a_BCD(
    input  logic [5:0] bin_in,   // Entrada binaria de 6 bits
    output logic [7:0] bcd_out   // Salida BCD: [7:4]=decenas, [3:0]=unidades
);
    always_comb begin
        bcd_out[7:4] = bin_in / 10; // Decenas
        bcd_out[3:0] = bin_in % 10; // Unidades
    end
endmodule


/* Module: BCD_Print_Segment
   Recibe un número en BCD y lo convierte a un número de 14 bits
   que representa los segmentos de un display doble de 7 segmentos
   Uno para el número de las decenas y otro para el número de las unidades

   Params:
     - BCD: Logic input [8 bits] - Entrada en formato BCD (DECENAS_UNIDADES)
     - double7segment: Logic Output [14 bits]- Salida de los segmentos para el display doble
      
   Restriction: 
        La entrada máxima en BCD es de 8 bits
        El formato de salida es de 14 bits, donde los primeros 7 bits son para el display de las decenas
        y los últimos 7 bits son para el display de las unidades
        Para el double7segment se usa salida en BIG-ENDIAN

   Problems:
     El 7segment tiene un formato de salida en BIG-ENDIAN, por lo que se debe tener cuidado con la asignación de los bits
     ya que se está al contrario de lo que se entiende en el manual de usuario de la placa de desarrollo.
	  
   References: 
    [1] Terasic, DE10-Standard Development User Manual. 2017. [En línea]. 
        Disponible en: https://ftp.intel.com/Public/Pub/fpgaup/pub/Intel_Material/Boards/DE10-Standard/DE10_Standard_User_Manual.pdf [Accedido: 07-03-2025]
    [2] S. Harris y D. Harris, Diseño digital y arquitectura de computadoras: Edición ARM. Morgan Kaufman, 2015.

*/
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


/* Module: RestadorParametrizableN
   Descripción:
     Módulo principal que integra:
       1) Un Restador parametrizable (N=6) que decrementa el valor de data_in 
          en cada flanco negativo de btn_sub, con reset asíncrono (btn_rst).
       2) Un módulo Binario_a_BCD para convertir el resultado (6 bits binario) 
          a un valor BCD de 8 bits (2 dígitos).
       3) Un módulo Decodificador7Segmentos que recibe el BCD y genera la 
          activación correspondiente en seg_out para displays de 7 segmentos.

   Puertos:
     - btn_rst:   Input logic
         Reset asíncrono (activo en bajo). Cuando se detecta un flanco negativo, 
         se recarga el valor inicial en el restador.
     - btn_sub:   Input logic
         Botón (activo en bajo) para decrementar data_out en cada flanco negativo.
     - data_in:   Input logic [5:0]
         Valor inicial para el restador (proveído típicamente por switches).
     - seg_out:   Output logic [0:13]
         Salida que controla los segmentos de dos dígitos de 7 segmentos 
         (14 líneas, 7 segmentos por dígito). 
         Los bits [0:6] pueden corresponder al primer dígito, 
         y [7:13] al segundo, dependiendo de la implementación del decodificador.
*/
module RestadorParametrizableN (
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


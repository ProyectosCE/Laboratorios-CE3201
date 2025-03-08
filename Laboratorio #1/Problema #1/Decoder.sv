/* 
================================== LICENCIA ================================================== 
MIT License
Copyright (c) 2025 José Bernardo Barquero Bonilla,
                   Alexander Montero Vargas,
                   Alvaro Vargas Molina
Consulta el archivo LICENSE para más detalles.
==============================================================================================
*/

/* Module: Binario_a_BCD
   Convierte una entrada binaria de 4 bits a un BCD de 8 bits
	de la forma 4 bits para el numero de las decenas (0 o 1)
	y 4 bits pare el numero de las unidades (0 a 9)

   Params:
     - bin_in: Logic input [4 bits] - Entrada binaria del numero según los switches, enviada
     - bcd_out: Logic Output [8 bits]- Salida del numero convertido a BCD (DECENAS_UNIDADES)
      
   Restriction: 
     La entrada máxima en bin_in es de 4 bits
	  
   Example:
		(COLOCAR LAS ENTRADAS Y Y SALIDAS DEL TESTBENCH DE ESTE MODULO)

   Problems:
     Sin problemas mayores
	  
   References:
    [1] Wikipedia, la enciclopedia libre, “Decimal codificado en binario”. [En línea].
        Disponible en: https://es.wikipedia.org/wiki/Decimal_codificado_en_binario [Accedido: 07-03-2025]
*/
module Binario_a_BCD(
    input  logic [3:0] bin_in,
    output logic [7:0] bcd_out
);
    always_comb begin
        // Convierte la entrada binaria a BCD usando división y módulo
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
*/
module BCD_Print_Segment (
    input  logic [7:0] BCD,
    output logic [0:13] double7segment
);
    always_comb begin
        case (BCD)
            // 00 a 09 en BIG-ENDIAN (Unidades_Decenas)
            8'b0000_0000: double7segment = 14'b0000001_0000001; // 00
            8'b0000_0001: double7segment = 14'b1001111_0000001; // 01
            8'b0000_0010: double7segment = 14'b0010010_0000001; // 02
            8'b0000_0011: double7segment = 14'b0000110_0000001; // 03
            8'b0000_0100: double7segment = 14'b1001100_0000001; // 04 
            8'b0000_0101: double7segment = 14'b0100100_0000001; // 05
            8'b0000_0110: double7segment = 14'b0100000_0000001; // 06
            8'b0000_0111: double7segment = 14'b0001111_0000001; // 07
            8'b0000_1000: double7segment = 14'b0000000_0000001; // 08
            8'b0000_1001: double7segment = 14'b0000100_0000001; // 09

            // 10 a 15 EN BIG-ENDIAN (Unidades_Decenas)
            8'b0001_0000: double7segment = 14'b0000001_1001111; // 10
            8'b0001_0001: double7segment = 14'b1001111_1001111; // 11
            8'b0001_0010: double7segment = 14'b0010010_1001111; // 12
            8'b0001_0011: double7segment = 14'b0000110_1001111; // 13
            8'b0001_0100: double7segment = 14'b1001100_1001111; // 14
            8'b0001_0101: double7segment = 14'b0100100_1001111; // 15

            default:      double7segment = 14'b00000010000001; // Por defecto, muestra 00
        endcase
    end
endmodule


/* Module: BCD_Decoder
   
*/
module BCD_Decoder(
    input  logic [3:0] binary_input,
    output logic [0:13] segment_output
);
    // Señal intermedia para conectar Binario_a_BCD con Decoder
    logic [7:0] bcd_value;
    
    // Instancia del módulo Binario_a_BCD
    Binario_a_BCD bcd_converter(
        .bin_in (binary_input),
        .bcd_out(bcd_value)
    );
    
    // Instancia del módulo BCD_Print_Segment
    BCD_Print_Segment segment_decoder(
        .BCD           (bcd_value),
        .double7segment(segment_output)
    );
endmodule

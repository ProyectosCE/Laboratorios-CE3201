/* 
================================== LICENCIA ================================================== 
MIT License
Copyright (c) 2025 José Bernardo Barquero Bonilla,
                   Alexander Montero Vargas,
                   Alvaro Vargas Molina
Consulta el archivo LICENSE para más detalles.
==============================================================================================
*/
/* Module: Binario_a_BCD_tb
   Descripción:
     Testbench que verifica el funcionamiento del módulo Binario_a_BCD, el cual
     convierte un valor binario de 4 bits en un formato BCD (8 bits: decenas y unidades).

   Procedimiento de prueba:
     1) Se define la señal de entrada 'binary_input' (4 bits) y la salida 'bcd_output' (8 bits).
     2) Se instancia el módulo Binario_a_BCD con esas señales.
     3) En el bloque 'initial', se asignan secuencialmente varios valores binarios 
        (0, 1, 3, 4, 5, 7, 9, 10, 13, 15) a 'binary_input'.
     4) Se usa un retardo #10 entre cada asignación para permitir la simulación y
        observar el valor de 'bcd_output' resultante.

   Notas:
     - bcd_output[7:4] se interpreta como decenas, mientras que bcd_output[3:0] 
       se interpreta como unidades.
     - Se cubren valores binarios desde 0 hasta 15 (decimal), para comprobar 
       que el módulo convierta correctamente cada caso.
     - Puede agregarse un $display o aserciones (assert) para verificar que la salida 
       BCD corresponda a lo esperado.

*/

module Binario_a_BCD_tb();

    // Inputs
    logic [3:0] binary_input;
    // Output
    logic [7:0] bcd_output;
    
    // Instanciación del módulo a probar
    Binario_a_BCD modulo(
        .bin_in(binary_input),
        .bcd_out(bcd_output)
    );
    
    // Secuencia de prueba
    initial begin
        // Valor 0
        binary_input = 4'b0000; #10;
        
        // Valor 1
        binary_input = 4'b0001; #10;
        
        // Valor 3
        binary_input = 4'b0011; #10;
        
        // Valor 4
        binary_input = 4'b0100; #10;
        
        // Valor 5
        binary_input = 4'b0101; #10;
        
        // Valor 7
        binary_input = 4'b0111; #10;
        
        // Valor 9
        binary_input = 4'b1001; #10;
        
        // Valor 10 (A en binario)
        binary_input = 4'b1010; #10;
        
        // Valor 13 (D en binario)
        binary_input = 4'b1101; #10;
        
        // Valor 15 (F en binario)
        binary_input = 4'b1111; #10;
    end

endmodule

/* Module: Restador_tb
   Descripción:
     Testbench que valida el comportamiento del módulo Restador en sus variantes 
     parametrizadas a 2, 4 y 6 bits. Para cada instancia se comprueba:
       - El reset asíncrono (btn_rstX), que carga el valor inicial (data_inX) en data_outX.
       - La resta en flanco negativo de btn_subX, que decrementa data_outX.
       
   Procedimiento de prueba:
     1) Se inicializan las señales (data_inX, btn_subX, btn_rstX).
     2) Se aplica un pulso de reset (btn_rstX = 0) para cargar data_inX en data_outX.
     3) Se generan pulsos en btn_subX (bajándolo a 0) para verificar la operación de resta.
     4) Finalmente, se reacondiciona btn_rstX a 0 para regresar a data_inX y comprobar 
        que el reset funciona nuevamente.

   Notas:
     - Cada bloque inicial atiende la instancia específica (2, 4 o 6 bits).
     - Se usan retardos (#) para escalonar los eventos y no solaparlos entre instancias.
     - No se incluye una señal de reloj, ya que el diseño es asíncrono 
       (btn_rst y btn_sub activos en bajo).
     - Se pueden observar comportamientos de underflow si data_outX llega a 0 
       y se sigue restando, debido a la representación binaria.

*/
module Restador_tb();

    // -------------------------
    // Instancia para 2 bits
    // -------------------------
    // Señales para la instancia de 2 bits
    logic [1:0] data_in2, data_out2;
    logic       btn_sub2, btn_rst2;

    // Instanciación del Restador parametrizado a 2 bits
    Restador #(.N(2)) restador2 (
        .btn_rst(btn_rst2),
        .btn_sub(btn_sub2),
        .data_in(data_in2),
        .data_out(data_out2)
    );

    // Bloque de prueba para la instancia de 2 bits
    initial begin
        // Inicialización
        data_in2  = 2'd3;  // Valor inicial: 3 (máximo para 2 bits)
        btn_sub2  = 1;  // inactivo
        btn_rst2  = 1;  // inactivo
        #2;
        // Aplicar reset: simula presionar (0) y soltar (1)
        btn_rst2 = 0; #10; btn_rst2 = 1; #10;
        $display("2-bit: Valor inicial = %d", data_out2);
        
        // Simula pulsaciones del botón de resta
        btn_sub2 = 0; #10; btn_sub2 = 1; #10;
        $display("2-bit: Después de 1 resta = %d", data_out2);
        btn_sub2 = 0; #10; btn_sub2 = 1; #10;
        $display("2-bit: Después de 2 restas = %d", data_out2);
        
        // Reiniciar para volver al valor inicial
        btn_rst2 = 0; #10; btn_rst2 = 1; #10;
        $display("2-bit: Después de reset = %d", data_out2);
    end

    // -------------------------
    // Instancia para 4 bits
    // -------------------------
    // Señales para la instancia de 4 bits
    logic [3:0] data_in4, data_out4;
    logic       btn_sub4, btn_rst4;

    // Instanciación del Restador parametrizado a 4 bits
    Restador #(.N(4)) restador4 (
        .btn_rst(btn_rst4),
        .btn_sub(btn_sub4),
        .data_in(data_in4),
        .data_out(data_out4)
    );

    // Bloque de prueba para la instancia de 4 bits
    initial begin
        // Esperar para no superponer eventos con la instancia de 2 bits
        #150;
        data_in4  = 4'd13; // Valor inicial: 13
        btn_sub4  = 1;  // inactivo
        btn_rst4  = 1;  // inactivo
        #2;
        btn_rst4 = 0; #10; btn_rst4 = 1; #10;
        $display("4-bit: Valor inicial = %d", data_out4);
        
        // Simula pulsaciones del botón de resta
        btn_sub4 = 0; #10; btn_sub4 = 1; #10;
        $display("4-bit: Después de 1 resta = %d", data_out4);
        btn_sub4 = 0; #10; btn_sub4 = 1; #10;
        $display("4-bit: Después de 2 restas = %d", data_out4);
        
        // Reiniciar para volver al valor inicial
        btn_rst4 = 0; #10; btn_rst4 = 1; #10;
        $display("4-bit: Después de reset = %d", data_out4);
    end

    // -------------------------
    // Instancia para 6 bits
    // -------------------------
    // Señales para la instancia de 6 bits
    logic [5:0] data_in6, data_out6;
    logic       btn_sub6, btn_rst6;

    // Instanciación del Restador parametrizado a 6 bits
    Restador #(.N(6)) restador6 (
        .btn_rst(btn_rst6),
        .btn_sub(btn_sub6),
        .data_in(data_in6),
        .data_out(data_out6)
    );

    // Bloque de prueba para la instancia de 6 bits
    initial begin
        // Esperar para no superponer eventos con las instancias anteriores
        #300;
        data_in6  = 6'd47; // Valor inicial: 47
        btn_sub6  = 1;  // inactivo
        btn_rst6  = 1;  // inactivo
        #2;
        btn_rst6 = 0; #10; btn_rst6 = 1; #10;
        $display("6-bit: Valor inicial = %d", data_out6);
        
        // Simula pulsaciones del botón de resta
        btn_sub6 = 0; #10; btn_sub6 = 1; #10;
        $display("6-bit: Después de 1 resta = %d", data_out6);
        btn_sub6 = 0; #10; btn_sub6 = 1; #10;
        $display("6-bit: Después de 2 restas = %d", data_out6);
        
        // Reiniciar para volver al valor inicial
        btn_rst6 = 0; #10; btn_rst6 = 1; #10;
        $display("6-bit: Después de reset = %d", data_out6);
        #20;
    end

endmodule

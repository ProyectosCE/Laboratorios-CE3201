module Restador_tb();

    // Generación de reloj común para todas las instancias (período de 10 ns)
    logic clk;
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // -------------------------
    // Instancia para 2 bits
    // -------------------------
    // Señales para la instancia de 2 bits
    logic [1:0] data_in2, data_out2;
    logic       btn_sub2, rst2;

    // Instanciación del Restador parametrizado a 2 bits
    Restador #(.N(2)) restador2 (
        .clk(clk),
        .rst(rst2),
        .btn_sub(btn_sub2),
        .data_in(data_in2),
        .data_out(data_out2)
    );

    // Bloque de prueba para la instancia de 2 bits
    initial begin
        // Inicialización
        data_in2  = 2'd3;  // Valor inicial: 3 (máximo para 2 bits)
        btn_sub2  = 0;
        rst2      = 0;
        #2;
        // Aplicar reset para cargar data_in2 en data_out2
        rst2 = 1; #10; rst2 = 0; #10;
        $display("2-bit: Valor inicial = %d", data_out2);
        
        // Pulsar el botón de resta dos veces
        btn_sub2 = 1; #10; btn_sub2 = 0; #10;
        $display("2-bit: Después de 1 resta = %d", data_out2);
        btn_sub2 = 1; #10; btn_sub2 = 0; #10;
        $display("2-bit: Después de 2 restas = %d", data_out2);
        
        // Reiniciar para volver al valor inicial
        rst2 = 1; #10; rst2 = 0; #10;
        $display("2-bit: Después de reset = %d", data_out2);
    end

    // -------------------------
    // Instancia para 4 bits
    // -------------------------
    // Señales para la instancia de 4 bits
    logic [3:0] data_in4, data_out4;
    logic       btn_sub4, rst4;

    // Instanciación del Restador parametrizado a 4 bits
    Restador #(.N(4)) restador4 (
        .clk(clk),
        .rst(rst4),
        .btn_sub(btn_sub4),
        .data_in(data_in4),
        .data_out(data_out4)
    );

    // Bloque de prueba para la instancia de 4 bits
    initial begin
        // Esperar para no superponer eventos con la instancia de 2 bits
        #150;
        data_in4  = 4'd13; // Valor inicial: 13
        btn_sub4  = 0;
        rst4      = 0;
        #2;
        rst4 = 1; #10; rst4 = 0; #10;
        $display("4-bit: Valor inicial = %d", data_out4);
        
        // Pulsar el botón de resta dos veces
        btn_sub4 = 1; #10; btn_sub4 = 0; #10;
        $display("4-bit: Después de 1 resta = %d", data_out4);
        btn_sub4 = 1; #10; btn_sub4 = 0; #10;
        $display("4-bit: Después de 2 restas = %d", data_out4);
        
        // Reiniciar para volver al valor inicial
        rst4 = 1; #10; rst4 = 0; #10;
        $display("4-bit: Después de reset = %d", data_out4);
    end

    // -------------------------
    // Instancia para 6 bits
    // -------------------------
    // Señales para la instancia de 6 bits
    logic [5:0] data_in6, data_out6;
    logic       btn_sub6, rst6;

    // Instanciación del Restador parametrizado a 6 bits
    Restador #(.N(6)) restador6 (
        .clk(clk),
        .rst(rst6),
        .btn_sub(btn_sub6),
        .data_in(data_in6),
        .data_out(data_out6)
    );

    // Bloque de prueba para la instancia de 6 bits
    initial begin
        // Esperar para no superponer eventos con las instancias anteriores
        #300;
        data_in6  = 6'd47; // Valor inicial: 47
        btn_sub6  = 0;
        rst6      = 0;
        #2;
        rst6 = 1; #10; rst6 = 0; #10;
        $display("6-bit: Valor inicial = %d", data_out6);
        
        // Pulsar el botón de resta dos veces
        btn_sub6 = 1; #10; btn_sub6 = 0; #10;
        $display("6-bit: Después de 1 resta = %d", data_out6);
        btn_sub6 = 1; #10; btn_sub6 = 0; #10;
        $display("6-bit: Después de 2 restas = %d", data_out6);
        
        // Reiniciar para volver al valor inicial
        rst6 = 1; #10; rst6 = 0; #10;
        $display("6-bit: Después de reset = %d", data_out6);
        #20;
        $finish;
    end

endmodule

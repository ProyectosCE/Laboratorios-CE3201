/* 
================================== LICENCIA ================================================== 
MIT License
Copyright (c) 2025 José Bernardo Barquero Bonilla,
                   Alexander Montero Vargas,
                   Alvaro Vargas Molina
Consulta el archivo LICENSE para más detalles.
==============================================================================================
*/
/* Module: multiplier_cla_tb
   Descripción:
     Testbench que verifica el funcionamiento del módulo multiplier_cla, el cual
     realiza la multiplicación de dos números de 32 bits usando un Carry Lookahead Adder (CLA).

   Procedimiento de prueba:
     1) Se definen las señales de entrada 'multicand' y 'multiplier' (ambas de 32 bits) y la salida 'product' (64 bits).
     2) Se instancia el módulo multiplier_cla con esas señales.
     3) En el bloque 'initial', se asignan secuencialmente diferentes pares de valores a 'multicand' y 'multiplier'.
     4) Se usa un retardo #10 entre cada asignación para permitir la simulación y observar el valor de 'product' resultante.
     5) Se registran los valores de entrada y salida mediante $display para validación visual.

   Notas:
     - Se prueba con diversos valores para verificar la correcta operación del multiplicador.
     - Se utiliza $dumpfile y $dumpvars para permitir la visualización de la simulación en herramientas de trazado.
     - Puede agregarse verificación automática con aserciones para comparar los resultados esperados y obtenidos.
*/
module multiplier_cla_tb;

    // Inputs
    logic [31:0] multicand;
    logic [31:0] multiplier;

    // Output
    logic [63:0] product;

    // Instancia del módulo a probar
    multiplier_cla #(32, 32) uut (
        .multicand(multicand),
        .multiplier(multiplier),
        .product(product)
    );
	 

    // Secuencia de prueba
    initial begin
        $dumpfile("multiplier_cla_tb.vcd");
        $dumpvars(0, multiplier_cla_tb);

        $display("Iniciando pruebas...");

        // Prueba 1: 2 * 1 = 2
        multicand = 32'd2;
        multiplier = 32'd1;
        #10;
        $display("Prueba 1: %d * %d = %d", multicand, multiplier, product);

        // Prueba 2: 10 * 3 = 30
        multicand = 32'd10;
        multiplier = 32'd3;
        #10;
        $display("Prueba 2: %d * %d = %d", multicand, multiplier, product);

        // Prueba 3: 165 * 15 = 2475
        multicand = 32'd165;
        multiplier = 32'd15;
        #10;
        $display("Prueba 3: %d * %d = %d", multicand, multiplier, product);

        // Prueba 4: 4660 * 42 = 195720
        multicand = 32'd4660;
        multiplier = 32'd42;
        #10;
        $display("Prueba 4: %d * %d = %d", multicand, multiplier, product);

        // Prueba 5: 703710 * 18 = 12666780
        multicand = 32'd703710;
        multiplier = 32'd18;
        #10;
        $display("Prueba 5: %d * %d = %d", multicand, multiplier, product);
    end

endmodule

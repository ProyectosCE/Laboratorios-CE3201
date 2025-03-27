`timescale 1ns / 1ps

module multiplier_cla_tb;
    
    // Prueba con diferentes anchos de bit
    parameter int WIDTHS [4:0] = '{2, 4, 8, 16, 32};
    
    // Valores de prueba fijos para cada tamaño
    logic [1:0]  multicand_2  = 2'b10,  multiplier_2  = 2'b01; // 2 * 1 = 2
    logic [3:0]  multicand_4  = 4'b1010, multiplier_4  = 4'b0011; // 10 * 3 = 30
    logic [7:0]  multicand_8  = 8'hA5,   multiplier_8  = 8'h0F;   // 165 * 15 = 2475
    logic [15:0] multicand_16 = 16'h1234, multiplier_16 = 16'h002A; // 4660 * 42 = 195720
    logic [31:0] multicand_32 = 32'hABCDE, multiplier_32 = 32'h12; // 703710 * 18 = 12666780
    
    logic [63:0] product;
    
    // Instancia del módulo para cada tamaño de bit
    
    multiplier_cla #(2, 2) uut_2 (
        .multicand(multicand_2),
        .multiplier(multiplier_2),
        .product(product[3:0])
    );
    
    multiplier_cla #(4, 4) uut_4 (
        .multicand(multicand_4),
        .multiplier(multiplier_4),
        .product(product[7:0])
    );
    
    multiplier_cla #(8, 8) uut_8 (
        .multicand(multicand_8),
        .multiplier(multiplier_8),
        .product(product[15:0])
    );
    
    multiplier_cla #(16, 16) uut_16 (
        .multicand(multicand_16),
        .multiplier(multiplier_16),
        .product(product[31:0])
    );
    
    multiplier_cla #(32, 32) uut_32 (
        .multicand(multicand_32),
        .multiplier(multiplier_32),
        .product(product[63:0])
    );
    
    initial begin
        $display("Iniciando pruebas...");
        #10;
        
        $display("2-bit: %d * %d = %d", multicand_2, multiplier_2, product[3:0]);
        $display("4-bit: %d * %d = %d", multicand_4, multiplier_4, product[7:0]);
        $display("8-bit: %d * %d = %d", multicand_8, multiplier_8, product[15:0]);
        $display("16-bit: %d * %d = %d", multicand_16, multiplier_16, product[31:0]);
        $display("32-bit: %d * %d = %d", multicand_32, multiplier_32, product[63:0]);
        
        #10;
    end
    
endmodule
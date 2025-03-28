/* 
================================== LICENCIA ================================================== 
MIT License
Copyright (c) 2025 José Bernardo Barquero Bonilla,
                   Alexander Montero Vargas,
                   Alvaro Vargas Molina
Consulta el archivo LICENSE para más detalles.
==============================================================================================
*/

/* Module: ALU_N_bits_tb
   Descripción:
     Testbench que verifica el funcionamiento del módulo ALU_N_bits, una unidad aritmética y lógica
     de 8 bits que realiza operaciones básicas como suma, resta, AND, OR, XOR, desplazamientos,
     módulo, multiplicación y división. Además, calcula las banderas de condición (V, C, N, Z).

   Procedimiento de prueba:
     1) Se definen las señales de entrada 'a' y 'b' (8 bits cada una) y la señal de selección 'select' (4 bits).
     2) Se define la salida 'result' (8 bits) y las banderas de condición 'flags' (4 bits: V, C, N, Z).
     3) Se instancia el módulo ALU_N_bits con estas señales.
     4) En el bloque 'initial', se prueban las siguientes operaciones:
        - Suma, resta, AND, OR, XOR
        - Desplazamiento lógico a la derecha e izquierda
        - Módulo, multiplicación y división
     5) Se imprimen los resultados en consola con $display para validar el comportamiento.
     6) Se incluyen pruebas para verificar el cálculo correcto de las banderas de condición.

   Notas:
     - Se utilizan diferentes combinaciones de entrada para cubrir varios casos de prueba.
     - Se puede agregar la verificación de resultados esperados con aserciones (assert).
*/

`timescale 1ns/1ps

/* Mux operation order
	s = 0000 => d0 ADD
	s = 0001 => d1 SUB
	s = 0010 => d2 AND
	s = 0011 => d3 OR
	s = 0100 => d4 XOR
	s = 0101 => d5 LSR
	s = 0110 => d6 LSL
	s = 0111 => d7 mod
	s = 1000 => d8 Mult
	s = 1001 => d9 Div
*/ 


module ALU_N_bits_tb ();
	// wiring
	logic[7:0] a,b,result;
	logic[3:0] select, flags;
	
	// device under test
	ALU_N_bits#(8) dut(.a(a),
							 .b(b),
							 .control(select),
							 .result(result),
							 .v(flags[3]),
							 .c(flags[2]),
							 .n(flags[1]),
							 .z(flags[0]));
	
	// test
	initial begin
		// Operation tests
		a=8'b00001001; b=8'b00101001; select=4'b0000;
		#10;
		$display("Addition Test: %d + %d = %d", a, b, result);
		
		a=8'b00110001; b=8'b00010001; select=4'b0001;
		#10;
		$display("Substraction Test: %d - %d = %d", a, b, result);
		
		a=8'b00110101; b=8'b01010001; select=4'b0010;
		#10;
		$display("AND Test: %b & %b = %b", a, b, result);
		
		a=8'b00110101; b=8'b01010001; select=4'b0011;
		#10;
		$display("OR Test: %b | %b = %b", a, b, result);
		
		a=8'b00110101; b=8'b01010001; select=4'b0100;
		#10;
		$display("XOR Test: %b ^ %b = %b", a, b, result);
		
		a=8'b00110101; b=8'b00000001; select=4'b0101;
		#10;
		$display("Logical Shift Right Test: %b >> %d = %b", a, b, result);
		
		a=8'b00110101; b=8'b00000010; select=4'b0110;
		#10;
		$display("Logical Shift Left Test: %b << %d = %b", a, b, result);
		
		a=8'b00011001; b=8'b00000111; select=4'b0111;
		#10;
		$display("Modulus Test: %d %% %d = %d", a, b, result);
		
		a=8'b00000011; b=8'b00100000; select=4'b1000;
		#10;
		$display("Multiplication Test: %d * %d = %d", a, b, result);
		
		a=8'b01110001; b=8'b00000111; select=4'b1001;
		#10;
		$display("Divition Test: %d / %d = %d", a, b, result);
		
		// Flags test
		a=8'b11111111; b=8'b00000000; select=4'b0010;
		#10;
		$display("FLAGS Test (VCNZ:%b): %b & %b = %b", flags, a, b, result);
		/*
		a=8'b00000011; b=8'b00010001; select=4'b0001;
		#10;
		$display("FLAGS Test (VCNZ:%b): %d - %d = %d", flags, a, b, $signed(result));
		*/
		a=8'b11000011; b=8'b10010001; select=4'b0000;
		#10;
		$display("FLAGS Test (VCNZ:%b): %b + %b = %b", flags, a, b, result);
		
		a=8'b01011101; b=8'b01111110; select=4'b0000;
		#10;
		$display("FLAGS Test (VCNZ:%b): %d + %d = %d", flags, a, b, $signed(result));
	end

endmodule
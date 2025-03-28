/* 
================================== LICENCIA ================================================== 
MIT License
Copyright (c) 2025 José Bernardo Barquero Bonilla,
                   Alexander Montero Vargas,
                   Alvaro Vargas Molina
Consulta el archivo LICENSE para más detalles.
==============================================================================================
*/
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


// This is works on conditionals to get a mux10
// unsure what happens when select line is outside of range
// should be fixed to handle out of range select, later though



/* Module: mux10
Implementa un multiplexor de 10 entradas de N bits controlado por una señal de
selección de 4 bits.
La salida selecciona una de las 10 entradas según el valor de la señal de selección.
Params:
- d0 - d9: Logic input [N bits] - Entradas de datos al multiplexor.
- s: Logic input [4 bits] - Señal de selección para determinar la salida.
- y: Logic output [N bits] - Salida del multiplexor correspondiente a la entrada
seleccionada.
Restriction:
- La señal de selección 's' debe estar en el rango de 0 a 9 para un comportamiento
correcto.
- No se ha implementado manejo de errores si 's' toma valores fuera del rango válido.
Example:
mux10 #(.N(8)) mux_instance (
.d0(8'hAA), .d1(8'hBB), .d2(8'hCC), .d3(8'hDD),
.d4(8'hEE), .d5(8'hFF), .d6(8'h11), .d7(8'h22),
.d8(8'h33), .d9(8'h44), .s(4'b0010), .y(output_signal)
);
Problems:
References:
[1] D. Harris y S. Harris, "Digital Design and Computer Architecture, ARM Edition",
2nd ed., Morgan Kaufmann, 2015.
*/

module mux10
	#(parameter N=4)
	 (input logic [N-1:0] d0, d1, d2, d3, d4, d5, d6, d7, d8, d9,
	  input logic [3:0] s,
	  output logic [N-1:0] y);

	// Implementación del multiplexor utilizando operadores condicionales
	assign y = s[3] ? (s[0] ? d9 : d8) : (s[2] ? (s[1] ? (s[0] ? d7 : d6) : (s[0] ? d5 : d4)) : (s[1] ? (s[0] ? d3 : d2) : (s[0] ? d1 : d0)));
endmodule

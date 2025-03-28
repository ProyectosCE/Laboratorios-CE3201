/* 
================================== LICENCIA ================================================== 
MIT License
Copyright (c) 2025 José Bernardo Barquero Bonilla,
                   Alexander Montero Vargas,
                   Alvaro Vargas Molina
Consulta el archivo LICENSE para más detalles.
==============================================================================================
*/
/* Module: mux4
Multiplexor de 4 entradas de N bits controlado por un selector de 2 bits.
Permite seleccionar entre cuatro posibles valores de entrada y dirigir la señal de salida
según el valor del selector.
Params:
- d0: Logic input [N bits] - Primera entrada del multiplexor.
- d1: Logic input [N bits] - Segunda entrada del multiplexor.
- d2: Logic input [N bits] - Tercera entrada del multiplexor.
- d3: Logic input [N bits] - Cuarta entrada del multiplexor.
- s: Logic input [2 bits] - Selector de la entrada activa.
- y: Logic output [N bits] - Salida del multiplexor basada en la selección.
Restriction:
- El parámetro N define el ancho de las entradas y la salida.
- El selector 's' debe ser de 2 bits para garantizar la selección entre las cuatro entradas.
Example:
mux4 #(.N(8)) mux_inst (
.d0(8'b00001111),
.d1(8'b11110000),
.d2(8'b10101010),
.d3(8'b01010101),
.s(2'b10),
.y(output_signal)
);
Problems:
References:
[1] D. Harris y S. Harris, "Digital Design and Computer Architecture", 4th ed., ARM
edition, Morgan Kaufmann, 2021.
*/
module mux4
	#(parameter N=4)
	 (input logic [N-1:0] d0, d1, d2, d3,
	  input logic [1:0] s,
	  output logic [N-1:0] y);
assign y = s[1] ? (s[0] ? d3 : d2)
: (s[0] ? d1 : d0);
endmodule
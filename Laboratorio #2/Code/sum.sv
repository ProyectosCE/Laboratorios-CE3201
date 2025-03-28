/* 
================================== LICENCIA ================================================== 
MIT License
Copyright (c) 2025 José Bernardo Barquero Bonilla,
                   Alexander Montero Vargas,
                   Alvaro Vargas Molina
Consulta el archivo LICENSE para más detalles.
==============================================================================================
*/

/* Module: full_adder
Implementa un sumador completo de 1 bit.
Recibe dos bits de entrada y un bit de acarreo, y genera un bit de suma y un bit de acarreo
de salida.
Params:
- a: Logic input [1 bit] - Primer bit de entrada.
- b: Logic input [1 bit] - Segundo bit de entrada.
- cin: Logic input [1 bit] - Bit de acarreo de entrada.
- s: Logic output [1 bit] - Bit de suma resultante.
- cout: Logic output [1 bit] - Bit de acarreo de salida.
Restriction:
- Solo maneja operaciones de suma de 1 bit.
Example:
a = 1, b = 1, cin = 0 -> s = 0, cout = 1
a = 1, b = 0, cin = 1 -> s = 0, cout = 1
Problems:
References:
[1] D. Harris y S. Harris, "Digital Design and Computer Architecture: ARM Edition", 4th
ed., Morgan Kaufmann, 2015.
*/
module full_adder (input logic a, b, cin,
						 output logic s, cout);
	assign s = a ^ b ^ cin;
	assign cout = (a & b) | (cin & (a ^ b));
endmodule


/* Module: ripple_carry_adder_N_bits
Implementa un sumador de N bits basado en la propagación de acarreo.
Recibe dos operandos de N bits y un bit de acarreo de entrada, y genera un resultado de N
bits con un bit de acarreo de salida.
Params:
- N: Parámetro entero - Define la cantidad de bits de los operandos (por defecto, 4).
- a: Logic input [N bits] - Primer operando de entrada.
- b: Logic input [N bits] - Segundo operando de entrada.
- cin: Logic input [1 bit] - Bit de acarreo de entrada.
- s: Logic output [N bits] - Resultado de la suma.
- cout: Logic output [1 bit] - Bit de acarreo de salida.
Restriction:
- La operación de suma puede verse afectada por retardos debido a la propagación de
acarreo.
- N debe ser un número entero positivo.
Example:
N = 4, a = 4'b0110, b = 4'b1001, cin = 0 -> s = 4'b1111, cout = 0
N = 4, a = 4'b1111, b = 4'b0001, cin = 0 -> s = 4'b0000, cout = 1
Problems:
References:
[1] D. Harris y S. Harris, "Digital Design and Computer Architecture: ARM Edition", 4th
ed., Morgan Kaufmann, 2015.
*/
module ripple_carry_adder_N_bits 
	#(parameter N=4)
	 (input logic[N-1:0] a, b,
	  input logic cin,
     output logic[N-1:0] s, cout);
	  
    wire [N:0] carry; // for sending carries between FAs
	 assign carry[0] = cin;
	 
	 genvar i;
    generate
      for (i = 0;i < N;i = i + 1) begin: adder_stage
          full_adder fa (.a(a[i]),
								 .b(b[i]),
								 .cin(carry[i]),
								 .s(s[i]),
								 .cout(carry[i+1]));
      end  
        assign cout = carry[N];
    endgenerate
endmodule
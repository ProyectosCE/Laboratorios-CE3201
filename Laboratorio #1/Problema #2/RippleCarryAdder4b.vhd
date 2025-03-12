--================================== LICENCIA ================================================== 
--MIT License
--Copyright (c) 2025 José Bernardo Barquero Bonilla,
--                   Alexander Montero Vargas,
--                   Alvaro Vargas Molina
--Consulta el archivo LICENSE para más detalles.
--==============================================================================================


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entity: RippleCarryAdder4b
--   Implementa un sumador de 4 bits con acarreo en cascada (Ripple Carry Adder) que recibe dos
--   números binarios de 4 bits, un bit de acarreo de entrada (Cin) y genera una salida de 4 bits
--   con el resultado de la suma (S) junto con un bit de acarreo de salida (Cout).
--   Además, convierte la salida de la suma a un formato adecuado para un display de 7 segmentos.
--
--   Ports:
--     - A   : Logic input  [4 bits]  - Primer número de entrada.
--     - B   : Logic input  [4 bits]  - Segundo número de entrada.
--     - Cin : Logic input  [1 bit]   - Bit de acarreo de entrada.
--     - S   : Logic output [4 bits]  - Resultado de la suma de A y B.
--     - Cout: Logic output [1 bit]   - Acarreo de salida.
--     - SSD : Logic output [7 bits]  - Código para el display de 7 segmentos.
--
--   Restriction: 
--     - Los valores de A y B deben ser de 4 bits.
--     - El resultado no puede exceder los 4 bits (excepto por el acarreo de salida).
--     - El valor de entrada Cin es un solo bit.
--     - Se utiliza un sumador en cascada (Ripple Carry), lo que puede generar retardos en la propagación.
--
--   Problems:
--
--   References:

entity RippleCarryAdder4b is
Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
		 B : in STD_LOGIC_VECTOR (3 downto 0);
		 Cin : in STD_LOGIC;
		 S: out STD_LOGIC_VECTOR (3 downto 0);
		 Cout : out STD_LOGIC;
		 SSD  : out STD_LOGIC_VECTOR (6 downto 0));
end RippleCarryAdder4b;

architecture Structural of RippleCarryAdder4b is

-- Component: RippleCarryAdder1b
--   Implementa un sumador de 1 bit con acarreo, que es utilizado como bloque básico
--   dentro del sumador de 4 bits en cascada.
--
--   Ports:
--     - A   : Logic input  [1 bit] - Primer operando.
--     - B   : Logic input  [1 bit] - Segundo operando.
--     - Cin : Logic input  [1 bit] - Acarreo de entrada.
--     - S   : Logic output [1 bit] - Resultado de la suma.
--     - Cout: Logic output [1 bit] - Acarreo de salida.

component RippleCarryAdder1b
Port ( A : in STD_LOGIC;
		 B : in STD_LOGIC;
		 Cin : in STD_LOGIC;
		 S : out STD_LOGIC;
		 Cout : out STD_LOGIC);
end component;

-- Component: SevenSegmentDecoder
--   Convierte una entrada en formato binario de 4 bits a su correspondiente
--   representación en un display de 7 segmentos.
--
--   Ports:
--     - BCD : Logic input  [4 bits] - Entrada en formato binario codificado en decimal (BCD).
--     - SSD : Logic output [7 bits] - Salida con la codificación para el display de 7 segmentos.

component SevenSegmentDecoder
Port ( BCD : in  STD_LOGIC_VECTOR (3 downto 0);
		 SSD : out STD_LOGIC_VECTOR (6 downto 0)
);
end component;

-- Declaración de señales intermedias para el acarreo entre sumadores de 1 bit
signal c1,c2,c3: STD_LOGIC;
signal sum: STD_LOGIC_VECTOR (3 downto 0);

begin

-- Implementación del sumador en cascada
--   Se conectan cuatro instancias de sumadores de 1 bit (RippleCarryAdder1b)
--   de manera que el acarreo de salida de un bit sea la entrada del siguiente.

RCA1: RippleCarryAdder1b port map( A(0), B(0), Cin, sum(0), c1);
RCA2: RippleCarryAdder1b port map( A(1), B(1), c1, sum(1), c2);
RCA3: RippleCarryAdder1b port map( A(2), B(2), c2, sum(2), c3);
RCA4: RippleCarryAdder1b port map( A(3), B(3), c3, sum(3), Cout);

-- Se asigna el resultado final de la suma
S <= sum;

-- Instanciación del decodificador de 7 segmentos
--   Convierte el resultado de la suma en una representación visual para el display.

DECODER: SevenSegmentDecoder port map(BCD => sum, SSD => SSD);

end Structural;

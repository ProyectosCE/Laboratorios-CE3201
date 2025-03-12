--================================== LICENCIA ================================================== 
--MIT License
--Copyright (c) 2025 José Bernardo Barquero Bonilla,
--                   Alexander Montero Vargas,
--                   Alvaro Vargas Molina
--Consulta el archivo LICENSE para más detalles.
--==============================================================================================

------------------------------------------------------------------------
-- Entity: RippleCarryAdder1b
--   Implementa un sumador de 1 bit con acarreo que recibe dos bits de
--   entrada (A y B), junto con un bit de acarreo de entrada (Cin), y
--   produce un bit de suma (S) y un bit de acarreo de salida (Cout).
--
--   Puertos:
--     - A   : in  STD_LOGIC  -> Primer bit de entrada.
--     - B   : in  STD_LOGIC  -> Segundo bit de entrada.
--     - Cin : in  STD_LOGIC  -> Acarreo de entrada.
--     - S   : out STD_LOGIC  -> Resultado de la suma de A, B y Cin.
--     - Cout: out STD_LOGIC  -> Acarreo de salida.
--
--   Restricciones:
--     - A, B y Cin son señales de 1 bit.
--     - El resultado S es de 1 bit (suma) y Cout es el acarreo de salida.
--     - La lógica de suma se implementa con compuertas XOR y AND/OR.
--
--   Notas:
--     - Este componente suele usarse en cascada para formar sumadores de
--       más bits (ripple carry adder).
------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity RippleCarryAdder1b is
  Port (
    A    : in  STD_LOGIC;  -- Primer bit de entrada
    B    : in  STD_LOGIC;  -- Segundo bit de entrada
    Cin  : in  STD_LOGIC;  -- Acarreo de entrada
    S    : out STD_LOGIC;  -- Resultado de la suma
    Cout : out STD_LOGIC   -- Acarreo de salida
  );
end RippleCarryAdder1b;

architecture gate_level of RippleCarryAdder1b is
begin

  -- La suma de 1 bit se implementa con compuertas XOR.
  S <= A XOR B XOR Cin;

  -- El acarreo se genera a partir de las combinaciones de A, B y Cin.
  Cout <= (A AND B) OR (Cin AND A) OR (Cin AND B);

end gate_level;

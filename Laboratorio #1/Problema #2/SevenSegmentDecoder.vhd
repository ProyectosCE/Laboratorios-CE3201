--================================== LICENCIA ================================================== 
--MIT License
--Copyright (c) 2025 José Bernardo Barquero Bonilla,
--                   Alexander Montero Vargas,
--                   Alvaro Vargas Molina
--Consulta el archivo LICENSE para más detalles.
--==============================================================================================

------------------------------------------------------------------------
-- Entity: SevenSegmentDecoder
--   Descripción:
--     Decodificador de 7 segmentos que recibe una entrada BCD (4 bits) y 
--     produce una salida (SSD) de 7 bits para representar dígitos o caracteres 
--     en un display de 7 segmentos (común anodo o cátodo según la lógica requerida).
--     Cada bit de SSD corresponde a uno de los 7 segmentos (a, b, c, d, e, f, g).
--
--   Puertos:
--     - BCD : in  STD_LOGIC_VECTOR(3 downto 0)
--         Código BCD/hexadecimal (0-F). 
--     - SSD : out STD_LOGIC_VECTOR(6 downto 0)
--         Activación de segmentos para mostrar el dígito/valor correspondiente. 
--
--   Restricciones:
--     - BCD debe estar entre "0000" y "1111" (0 a 15 en binario). 
--     - Si el valor no corresponde a los casos descritos, se enciende 
--       "1111111" (todos los segmentos apagados o encendidos según tu hardware).
--
--   Notas:
--     - Ajustar la activación de los segmentos según sea display de ánodo común 
--       o cátodo común (en este ejemplo, '1' representa el segmento apagado 
--       y '0' el segmento encendido para ánodo común).
--     - Se soportan caracteres decimales (0-9) y hexadecimales (A-F).
------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SevenSegmentDecoder is
    Port (
        BCD : in  STD_LOGIC_VECTOR(3 downto 0);
        SSD : out STD_LOGIC_VECTOR(6 downto 0)  -- 7 segmentos
    );
end SevenSegmentDecoder;

architecture Behavioral of SevenSegmentDecoder is
begin

    process(BCD)
    begin
        case BCD is
            when "0000" => SSD <= "1000000"; -- 0
            when "0001" => SSD <= "1111001"; -- 1
            when "0010" => SSD <= "0100100"; -- 2
            when "0011" => SSD <= "0110000"; -- 3
            when "0100" => SSD <= "0011001"; -- 4
            when "0101" => SSD <= "0010010"; -- 5
            when "0110" => SSD <= "0000010"; -- 6
            when "0111" => SSD <= "1111000"; -- 7
            when "1000" => SSD <= "0000000"; -- 8
            when "1001" => SSD <= "0011000"; -- 9
            when "1010" => SSD <= "0001000"; -- A
            when "1011" => SSD <= "0000011"; -- B
            when "1100" => SSD <= "1000110"; -- C
            when "1101" => SSD <= "0100001"; -- D
            when "1110" => SSD <= "0000110"; -- E
            when "1111" => SSD <= "0001110"; -- F
            when others => SSD <= "1111111";  -- Display en blanco/apagado
        end case;
    end process;

end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SevenSegmentDecoder is
    Port ( BCD : in STD_LOGIC_VECTOR (3 downto 0);
           SSD : out STD_LOGIC_VECTOR (6 downto 0)); -- 7 segments
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
				when others => SSD <= "1111111"; -- Blank display
        end case;
    end process;
end Behavioral;
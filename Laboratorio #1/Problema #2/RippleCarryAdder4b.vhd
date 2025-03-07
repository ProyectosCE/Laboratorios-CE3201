library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RippleCarryAdder4b is
Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
		 B : in STD_LOGIC_VECTOR (3 downto 0);
		 Cin : in STD_LOGIC;
		 S: out STD_LOGIC_VECTOR (3 downto 0);
		 Cout : out STD_LOGIC;
		 SSD  : out STD_LOGIC_VECTOR (6 downto 0));
end RippleCarryAdder4b;

architecture Behavioral of RippleCarryAdder4b is

-- RCA1bit component Decalaration
component RippleCarryAdder1b
Port ( A : in STD_LOGIC;
		 B : in STD_LOGIC;
		 Cin : in STD_LOGIC;
		 S : out STD_LOGIC;
		 Cout : out STD_LOGIC);
end component;

-- SevenSegmentDecoder component declaration
component SevenSegmentDecoder
Port ( BCD : in  STD_LOGIC_VECTOR (3 downto 0);
		 SSD : out STD_LOGIC_VECTOR (6 downto 0)
);
end component;

-- Intermediate Carry signals declaration
signal c1,c2,c3: STD_LOGIC;
signal sum: STD_LOGIC_VECTOR (3 downto 0);

begin

-- Port Mapping RCA1bit 4 times
RCA1: RippleCarryAdder1b port map( A(0), B(0), Cin, sum(0), c1);
RCA2: RippleCarryAdder1b port map( A(1), B(1), c1, sum(1), c2);
RCA3: RippleCarryAdder1b port map( A(2), B(2), c2, sum(2), c3);
RCA4: RippleCarryAdder1b port map( A(3), B(3), c3, sum(3), Cout);

S <= sum;

-- Instantiate Seven Segment Decoder
DECODER: SevenSegmentDecoder port map(BCD => sum, SSD => SSD);

end Behavioral;

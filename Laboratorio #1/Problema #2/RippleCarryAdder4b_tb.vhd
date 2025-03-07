LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY RippleCarryAdder4b_tb IS
END RippleCarryAdder4b_tb;

ARCHITECTURE behavior OF RippleCarryAdder4b_tb IS

-- Component Declaration for the Unit Under Test (UUT)
COMPONENT RippleCarryAdder4b
PORT( A : IN std_logic_vector(3 downto 0);
		B : IN std_logic_vector(3 downto 0);
		Cin : IN std_logic;
		S : OUT std_logic_vector(3 downto 0);
		Cout : OUT std_logic
);
END COMPONENT;

--Inputs
signal A : std_logic_vector(3 downto 0) := (others => '0');
signal B : std_logic_vector(3 downto 0) := (others => '0');
signal Cin : std_logic := '0';

--Outputs
signal S : std_logic_vector(3 downto 0);
signal Cout : std_logic;

BEGIN

-- Instantiate the Unit Under Test (UUT)
uut: RippleCarryAdder4b PORT MAP (
A => A,
B => B,
Cin => Cin,
S => S,
Cout => Cout
);

-- Stimulus process
stim_proc: process
begin
-- hold reset state for 100 ns.
wait for 100 ns;
A <= "0110";
B <= "1100";

wait for 100 ns;
A <= "1111";
B <= "1100";

wait for 100 ns;
A <= "0110";
B <= "0111";

wait for 100 ns;
A <= "0110";
B <= "1110";

wait for 100 ns;
A <= "1111";
B <= "1111";

wait;

end process;

END;
--================================== LICENCIA ================================================== 
--MIT License
--Copyright (c) 2025 José Bernardo Barquero Bonilla,
--                   Alexander Montero Vargas,
--                   Alvaro Vargas Molina
--Consulta el archivo LICENSE para más detalles.
--==============================================================================================

------------------------------------------------------------------------
-- Testbench: RippleCarryAdder4b_tb
-- Descripción:
--   Este testbench comprueba la funcionalidad del sumador de 4 bits 
--   (RippleCarryAdder4b). Se estimulan las entradas A y B con diferentes 
--   combinaciones de bits, y se observa tanto la salida de suma (S) como 
--   el bit de acarreo de salida (Cout).
--
--   Puertos simulados:
--     - A   : IN std_logic_vector(3 downto 0)
--     - B   : IN std_logic_vector(3 downto 0)
--     - Cin : IN std_logic
--     - S   : OUT std_logic_vector(3 downto 0)
--     - Cout: OUT std_logic
--
--   Procedimiento de prueba (stim_proc):
--     1) Se inicializan las señales A, B y Cin en cero.
--     2) Se asignan diferentes valores a A y B cada 100 ns.
--     3) Se observa la respuesta de S y Cout para verificar la operación 
--        correcta del sumador.
--     4) El proceso continúa hasta agotar los casos de prueba, después de 
--        lo cual finaliza la simulación.
--
--   Notas:
--     - El bit Cin se mantiene en '0' en este ejemplo, pero puede cambiarse 
--       si se desea probar diferentes escenarios de acarreo de entrada.
--     - Puede añadirse un $monitor o aserciones para verificar automáticamente
--       que los resultados sean los esperados.
------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY RippleCarryAdder4b_tb IS
END RippleCarryAdder4b_tb;

ARCHITECTURE behavior OF RippleCarryAdder4b_tb IS

    --------------------------------------------------------------------
    -- Declaración del componente bajo prueba (UUT)
    --------------------------------------------------------------------
    COMPONENT RippleCarryAdder4b
    PORT(
        A   : IN  std_logic_vector(3 downto 0);
        B   : IN  std_logic_vector(3 downto 0);
        Cin : IN  std_logic;
        S   : OUT std_logic_vector(3 downto 0);
        Cout: OUT std_logic
    );
    END COMPONENT;

    -- Señales para las entradas (A, B, Cin)
    signal A   : std_logic_vector(3 downto 0) := (others => '0');
    signal B   : std_logic_vector(3 downto 0) := (others => '0');
    signal Cin : std_logic := '0';

    -- Señales para las salidas (S, Cout)
    signal S    : std_logic_vector(3 downto 0);
    signal Cout : std_logic;

BEGIN

    --------------------------------------------------------------------
    -- Instanciación del UUT (Unit Under Test)
    --------------------------------------------------------------------
    uut: RippleCarryAdder4b
        PORT MAP (
            A    => A,
            B    => B,
            Cin  => Cin,
            S    => S,
            Cout => Cout
        );

    --------------------------------------------------------------------
    -- Proceso de estímulos
    --------------------------------------------------------------------
    stim_proc: process
    begin
        -- Esperar 100 ns antes de comenzar las pruebas
        wait for 100 ns;
        
        -- Caso 1: A=0110, B=1100
        A <= "0110";
        B <= "1100";
        wait for 100 ns;

        -- Caso 2: A=1111, B=1100
        A <= "1111";
        B <= "1100";
        wait for 100 ns;

        -- Caso 3: A=0110, B=0111
        A <= "0110";
        B <= "0111";
        wait for 100 ns;

        -- Caso 4: A=0110, B=1110
        A <= "0110";
        B <= "1110";
        wait for 100 ns;

        -- Caso 5: A=1111, B=1111
        A <= "1111";
        B <= "1111";
        wait for 100 ns;

        -- Esperar indefinidamente para finalizar la simulación
        wait;
    end process;

END behavior;

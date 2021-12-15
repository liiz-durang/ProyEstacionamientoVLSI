library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity buzzer is 
	Port(
		 reloj : in STD_LOGIC;
		 entradaBuzzer: in STD_LOGIC;
		 buzzer : out STD_LOGIC);
end buzzer;

architecture Behavioral of buzzer is
begin
	
	process(entradaBuzzer, reloj)
	variable i : integer := 0;
	begin
	
		if (entradaBuzzer = '1') and rising_edge(reloj) then
			if i <= 50000 then
				i := i + 1;
				buzzer <= '0';

			elsif i > 50000 and i < 100000 then
				i := i + 1;
				buzzer <= '1';

			elsif i = 100000 then
				i := 0;  
			end if;
		end if;
	end process;
end Behavioral;
	
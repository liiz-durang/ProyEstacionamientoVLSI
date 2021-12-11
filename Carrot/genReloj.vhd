
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity genReloj is
	Port (clk : in std_logic;
			frecuencia: in integer;
			cicloTrabajo: in integer;
			P : out std_logic);
end genReloj;

architecture Behavioral of genReloj is
	constant fclk : integer := 50_000_000;
begin
	process (clk) 					-- Reloj de 1ms
		variable cuenta: integer := 0;
	begin
		if rising_edge (clk) then
			if cuenta >= (fclk/frecuencia) then
				cuenta := 0;
			else
				cuenta := cuenta + 1;
				if cuenta <= (fclk/(frecuencia*100))*cicloTrabajo then
					P <= '0';-- prendido
				else
					P <= '1'; --apagado
				end if;
			end if;
		end if;
	end process;

end Behavioral;

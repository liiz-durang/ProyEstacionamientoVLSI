library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity pwm_256 is
	Port ( reloj : in STD_LOGIC;
			 D : in STD_LOGIC_VECTOR (7 downto 0);--15
			 S : out STD_LOGIC);
end pwm_256;

architecture behavioral of pwm_256 is
begin
	process(reloj)
		variable cuenta : integer range 0 to 255 := 0;
	begin
		if reloj = '1' and reloj'event then
			cuenta := (cuenta+1) mod 256;
			if cuenta < D then
				S <= '1';
			else
				S <= '0';
			end if;
		end if;
	end process;
end behavioral;
	
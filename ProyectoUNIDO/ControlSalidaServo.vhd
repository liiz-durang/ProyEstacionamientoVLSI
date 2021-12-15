library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ControlSalidaServo is 
	Port(
			clk : in STD_LOGIC;
			 servo2 : in STD_LOGIC;
			 servo2T : in STD_LOGIC;
			 emergencia : in STD_LOGIC;
			 salidaServomotor : out STD_LOGIC);
end ControlSalidaServo;

architecture Behavioral of ControlSalidaServo is
	
	begin
	
	process (clk, servo2, servo2T, emergencia)
	
	begin
		if emergencia = '1' then
			salidaServomotor <= '0'; -- cerrado 
		else
			if servo2 = '1' or servo2T = '1' then
				salidaServomotor <= '1'; -- abierto
			else
				salidaServomotor <= '0'; -- cerrado
			end if;
		end if; 
	end process;
end Behavioral;
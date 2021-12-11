library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity servomotor is
	Port ( clk : in STD_LOGIC;
			 posicion: in STD_LOGIC_VECTOR (6 downto 0);
			 control : out STD_LOGIC);
end servomotor;

architecture behavioral of servomotor is
	component divisor is 
		Port ( clk : in STD_LOGIC;
				 div_clk : out STD_LOGIC);
	end component;
	component pwm is
		Port ( reloj : in STD_LOGIC;
				 D : in STD_LOGIC_VECTOR (15 downto 0);
				 S : out STD_LOGIC);
	end component;
	signal reloj : STD_LOGIC;
	signal ancho : STD_LOGIC_VECTOR (15 downto 0) := X"006E";-- igual al valor
	
	begin
	U1 : divisor port map (clk, reloj);
	U2 : pwm port map (reloj, ancho, control);
	
	ancho <= "000000000"&posicion+X"0064";

end behavioral;
		
		
		
		
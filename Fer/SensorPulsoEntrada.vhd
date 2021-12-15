library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity sensorpulsoentrada is 
	Port(clk: in STD_LOGIC;
		boton: in STD_LOGIC;
		senial: out std_LOGIC; 
		trigger: out std_logic;
		eco: in std_logic);
end sensorpulsoentrada;

architecture behavioral of sensorpulsoentrada is 
	component ultrasonico is
		port(clk: in STD_LOGIC;
			inicio: in STD_LOGIC;
			cm: out STD_LOGIC_VECTOR (8 downto 0);
			cent: out STD_LOGIC_VECTOR (3 downto 0);
			dec: out STD_LOGIC_VECTOR (3 downto 0);
			unid: out STD_LOGIC_VECTOR (3 downto 0);
			sensor_disp: out STD_LOGIC;
			sensor_eco: in STD_LOGIC);
	end component;



	signal cm: STD_LOGIC_VECTOR (8 downto 0);
	signal cent, dec, unid : STD_LOGIC_VECTOR (3 downto 0);
	
begin
	sonico : ultrasonico port map(clk, '0', cm, cent, dec, unid, trigger, eco);

	
	prueba: process (cm, cent, dec, unid)
	begin
		if cm > X"A" then
			senial <='0';

		else
			senial <='1';

		end if;

	end process;


end behavioral;
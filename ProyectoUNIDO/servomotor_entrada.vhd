library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Servomotor_Entrada is 
	Port(
		reloj : in STD_LOGIC;
			 servo1 : in STD_LOGIC;
			 Ctrl : out STD_LOGIC);
end Servomotor_Entrada;

architecture Behavioral of Servomotor_Entrada is
	component servomotor is
		Port ( clk : in STD_LOGIC;
				 posicion: in STD_LOGIC_VECTOR (6 downto 0);
				 control : out STD_LOGIC); 
	end component;
	
	component divisor is 
		Port ( clk : in STD_LOGIC;
				 div_clk : out STD_LOGIC);
	end component;
	
	component timer is
		Port (clk : in std_logic;
				start : in std_logic;
				Tms : in std_logic_vector (19 downto 0);
				P : out std_logic);
	end component;
	
	signal reloj_div : STD_LOGIC;
	signal ancho : STD_LOGIC_VECTOR (6 downto 0) := "0000001";--X"6E";-- igual al valor || 1101110
	signal temporizador, inicio: STD_LOGIC;
	begin
	U1 : divisor port map (reloj, reloj_div);
	
	U2 : timer port map (
						 clk => reloj, 
						 start => inicio,
						 Tms => "00000001001110001000",
						 P => temporizador);
						 
	servo: servomotor port map(
				clk => reloj,
				posicion => ancho,
				control => Ctrl);
	
	process (reloj_div, servo1)
		variable valor : STD_LOGIC_VECTOR (6 downto 0) := "0000001";--X"6E";-- Casi inicio 0F 15 | x6E 110
		variable cuenta : integer range 0 to 8138 := 0; -- 83 ms
		variable bandera, i : integer range 0 to 999999 := 0;
		
	begin
		if temporizador = '0' then
			if reloj_div='1' and reloj_div'event then
				if cuenta>0 then
					cuenta:= cuenta-1;
				else
					if i = 1 then
						valor := "0000001"; --0;--X"64"; -- x0D 13 cycles | 1 ms #x64 100 | 0000100
						i := 0;
					elsif bandera = 1 then
						inicio <= '0';
						bandera := 0;
					elsif servo1='1' then
						valor := "1011100"; --100; --X"C8"; -- x18 24 cycles | 2 ms #xC8  200 ||1100100		
						inicio <= '1';
						bandera := 1;
					end if;
					
					cuenta := 8138;
					ancho <= valor;
				end if;
			end if;
		else
			i := 1;			
		end if;
	end process;
	
end Behavioral;
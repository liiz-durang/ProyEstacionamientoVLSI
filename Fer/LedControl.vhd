library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity LedControl is
	Port( clk: in STD_LOGIC;
			rojo : out STD_LOGIC;
			verde : out STD_LOGIC;
			color: in STD_LOGIC_VECTOR(2 downto 0);
			azul : out STD_LOGIC
	);
end LedControl;

architecture behavioral of LedControl is
	component divisor is
		Generic (N : integer := 24);
		Port (clk : in std_logic;
				div_clk : out std_logic);
	end component;
	component pwm is
		Port ( Reloj : in STD_LOGIC;
				 D : in STD_LOGIC_VECTOR (7 downto 0);
				 S : out STD_LOGIC);
	end component;
	signal relojPWM : STD_LOGIC;
--	signal relojCiclo : STD_LOGIC;
	signal arojo : STD_LOGIC_VECTOR (7 downto 0) := X"FF";
	signal averde : STD_LOGIC_VECTOR (7 downto 0) := X"FF";
	signal aazul : STD_LOGIC_VECTOR (7 downto 0) := X"FF";
	signal conectornum : STD_LOGIC_VECTOR(2 downto 0);

begin
	D1: divisor generic map (10) port map (clk,relojPWM);
--	D2: divisor generic map (23) port map (clk,relojCiclo);
	P1: PWM port map (relojPWM,arojo,rojo);
	P2: PWM port map (relojPWM,averde,verde);
	P3: PWM port map (relojPWM,aazul,azul);
		

	
asignacionColores:	process(conectornum)
	begin
		case conectornum is
			when "001" => --VERDE
				arojo <= X"FF";
				averde <= X"00";
				aazul <= X"FF";
			when "010" => --ROJO
				arojo <= X"00";
				averde <= X"FF";
				aazul <= X"FF";
			
			when "100"=> --VIOLETA
				arojo <= X"7F";
				averde <= X"FF";
				aazul <= X"00";
				
			when "011"=> --NARANJA
				arojo <= X"00";
				averde <= X"87";
				aazul <= X"FF";
			
			when others => --APAGADO
				arojo <= X"FF";
				averde <= X"FF";
				aazul <= X"FF";
				
--			when 0 => --ROJO
--				arojo <= X"00";
--				averde <= X"FF";
--				aazul <= X"FF";
--			when 1 => --NARANJA
--				arojo <= X"00";
--				averde <= X"87";
--				aazul <= X"FF";
--			when 2 => --AMARILLO
--				arojo <= X"00";
--				averde <= X"00";
--				aazul <= X"FF";
--			when 3 => --VERDE
--				arojo <= X"FF";
--				averde <= X"00";
--				aazul <= X"FF";
--			when 4 => --CYAN
--				arojo <= X"FF";
--				averde <= X"07";
--				aazul <= X"07";
--			when 5 => --AZUL
--				arojo <= X"FF";
--				averde <= X"FF";
--				aazul <= X"00";
--			when others => --VIOLETA
--				arojo <= X"7F";
--				averde <= X"FF";
--				aazul <= X"00";
			end case;				
	end process;
	
	with color select conectornum <=
	"001" when not "001",
	"010" when not  "010",
	"100" when not  "100",
	"011" when not "011",
	"000" when others;
end behavioral;
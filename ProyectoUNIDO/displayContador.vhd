library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity displayContador is
	port( reloj: in std_logic;
			numero: in std_logic_vector(3 downto 0);
			AN: out std_logic_vector(3 downto 0);
			LS: out std_logic_vector(6 downto 0));
end entity displayContador;

architecture behavioral of displayContador is
	component MuxDec4disp is
	port( clk : in std_logic;
			d0,d1,d2,d3 : in std_logic_vector (3 downto 0);
			a : out std_logic_vector(3 downto 0);
			l : out std_logic_vector(6 downto 0));
	end component;
	
	signal digito0, digito1, digito2, digito3 : std_logic_vector (3 downto 0);
	signal auxiliar :std_logic_vector (3 downto 0);
	signal negacion : std_logic_vector(3 downto 0);

begin
	muxdec: MuxDec4disp port map (clk => reloj,
	d0 => digito0,
	d1 => digito1,
	d2 => digito2,
	d3 => digito3,
	a => AN,
	l => LS);
	
	
	asignarD:	process(numero)
		begin 
			negacion<= numero;
			if (negacion < X"A") then
				digito0 <= negacion;
				digito1 <= "0000";
				digito2 <= "0000";
				digito3 <= "0000";
			elsif (negacion < X"14") then
				auxiliar<=negacion-"1010";
				digito0 <= auxiliar;
				digito1 <= "0001";
				digito2 <= "0000";
				digito3 <= "0000";
			elsif (negacion < X"1E") then
				auxiliar<=negacion-"10100";
				digito0 <= auxiliar;
				digito1 <= "0010";
				digito2 <= "0000";
				digito3 <= "0000";
			end if;
			
		
	
	
	end process;
	

	
	
 end behavioral;
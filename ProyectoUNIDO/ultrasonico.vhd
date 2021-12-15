library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity ultrasonico is 
	Port(clk: in STD_LOGIC;
			inicio: in STD_LOGIC;
			cm: out STD_LOGIC_VECTOR (8 downto 0);
			cent: out STD_LOGIC_VECTOR (3 downto 0);
			dec: out STD_LOGIC_VECTOR (3 downto 0);
			unid: out STD_LOGIC_VECTOR (3 downto 0);
			sensor_disp: out STD_LOGIC;
			sensor_eco: in STD_LOGIC);
end ultrasonico;
	
	
architecture Behavioral of ultrasonico is
		signal cuenta: STD_LOGIC_VECTOR(16 downto 0):= (others => '0');
		signal centimetros: STD_LOGIC_VECTOR(8 downto 0):= (others => '0'); -- se cambia a 9
		signal centimetros_unid: STD_LOGIC_VECTOR(3 downto 0):= (others => '0');
		signal centimetros_dec: STD_LOGIC_VECTOR(3 downto 0):= (others => '0');
		signal centimetros_cent: STD_LOGIC_VECTOR(3 downto 0):= (others => '0');		
		signal digito: STD_LOGIC_VECTOR(3 downto 0):= (others => '0');
		signal eco_pasado: std_logic:= '0';
		signal eco_sinc: std_logic:= '0';
		signal eco_nsinc: std_logic:= '0';
		signal espera: std_logic:= '0';
		signal siete_seg_cuenta: STD_LOGIC_VECTOR(15 downto 0):= (others => '0');
	
begin 	
	Trigger: process(clk)
	begin
		if inicio = '0' then
			if rising_edge(clk) then
				if espera = '0' then
					if cuenta = 500 then
						sensor_disp <= '0';
						espera <= '1';
						cuenta <= (others => '0');
					else
						sensor_disp <= '1';
						cuenta <= cuenta+1;
					end if;
				elsif eco_pasado = '0' and eco_sinc = '1' then
					cuenta <= (others => '0');
					centimetros <= (others => '0');
					centimetros_unid <= (others => '0');
					centimetros_dec <= (others => '0');
					centimetros_cent <= (others => '0');
				elsif eco_pasado = '1' and eco_sinc = '0' then					
					unid <= centimetros_unid;
					dec <= centimetros_dec;
					cent <= centimetros_cent;
					cm <= centimetros;
				
				elsif cuenta = 2900-1 then
					if centimetros_unid = 9 then 
						if centimetros_dec = 9 then
							centimetros_dec <= (others => '0');
						centimetros_cent <= centimetros_cent + 1;
						end if;
						centimetros_unid <= (others => '0');
						centimetros_dec <= centimetros_dec + 1;
					else
						centimetros_unid <= centimetros_unid + 1;
					end if;
					centimetros <= centimetros + 1;
					cuenta <= (others => '0');
					if centimetros = 3448 then -- 200 ms
						espera <= '0';
					end if;
				else
					cuenta <= cuenta + 1;
				end if;
				eco_pasado <= eco_sinc;
				eco_sinc <= eco_nsinc;
				eco_nsinc <= sensor_eco;
			end if;
		end if;
	end process;
	
end Behavioral;
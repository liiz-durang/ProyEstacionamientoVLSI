Library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

--/*
-- * El bloque Control Disponible debe constantemente estar chechando las señales
-- * activas de los temporizadores(0 libre, 1 ocupado) y mostrar en casillaDisp una casilla sugerida
-- * donde se pueda estacionar. Si se detecta un flanco de subida en la señal entraAuto
-- * entonces se debe mandar el InicioTemp # respectivo a la casillaDisp sugerida
-- * 
--*/

entity ContadorLugaresDisponibles is

	Port ( clk50MHz : in STD_LOGIC;
			 entraAuto: in STD_LOGIC;
			 autoSale: in STD_LOGIC;
			 disponible: out STD_LOGIC;
			 num: out STD_LOGIC_VECTOR(3 downto 0)
			 );
end ContadorLugaresDisponibles;

architecture behavioral of ContadorLugaresDisponibles is 
	
	signal previo_sale : std_logic:= '1'; 
	signal previo_entra : std_logic :='1';
	
	signal numDisp: integer range 0 to 4:=4;
	
begin 

	
	eventoAuto: process (clk50MHz, entraAuto,autoSale)
	begin
		if rising_edge(clk50MHz) then
			if entraAuto /= previo_entra and entraAuto='1' then -- flanco de entrada
				if numDisp > 0 then 
					numDisp <=numDisp-1;
				end if; --manten en cero
			elsif autoSale /= previo_sale and autoSale='1' then -- flanco de salida
				if numDisp < 4 then
					numDisp <=numDisp+1;
				end if; -- manten en 4
			else
				numDisp <= numDisp;
			end if;
			
			previo_sale <=autoSale;
			previo_entra<=entraAuto;
		end if;
	end process eventoAuto;

	revisaDisp: process (clk50MHz)
	begin 
		if rising_edge(clk50MHz) then
			if numDisp > 0 then
				disponible <= '1';
			else
				disponible <= '0';
			end if;		
		end if;
	end process revisaDisp;
	
	setNum: process(clk50MHz, numDisp)
	begin
		if rising_edge(clk50MHz) then
			if numDisp = 0 then
					num<="0000";
			elsif numDisp = 1 then
					num<="0001";
			elsif numDisp = 2 then
					num<="0010";
			elsif numDisp = 3 then
					num<="0011";
			elsif numDisp = 4 then
					num<="0100";
			else
					num<="0000";
			end if;		
		end if;
	
	end process setNum;
	
end behavioral;

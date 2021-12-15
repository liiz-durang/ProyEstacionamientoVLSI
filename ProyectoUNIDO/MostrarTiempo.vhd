--------------------------------------------------------------------------------
--
--   FileName:         MostrarTiempo.vhd
--   Design Software:  Quartus II 64-bit Version 13.1 Build 162 SJ Full Version
--   Descripción:		  Muestra el tiempo en formato MM:SS que un auto ha estado estacionado
--	  Version:			  1.0
--------------------------------------------------------------------------------

Library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MostrarTiempo is
	Port( 
		clk50MHz: in STD_LOGIC;
		inicio: in std_LOGIC;
		cuenta_seg: in   STD_LOGIC_VECTOR (11 downto 0); --Vector en binario
		red: out std_logic_vector (3 downto 0);  --al monitor
		green: out std_logic_vector (3 downto 0); --al monitor
		blue: out std_logic_vector (3 downto 0); --al monitor 
		h_sync: out std_logic;
		v_sync: out std_logic
		);
end MostrarTiempo;

architecture behavorial of MostrarTiempo is
	
	
	component relojDigital is 
		Port	( 	
			clk50MHz				: in std_logic;
			inicio				: in std_logic;
			cuenta_seg			: in   STD_LOGIC_VECTOR (11 downto 0); --Vector en binario
			unidadesSegundos	: out std_logic_vector(3 downto 0); 
			decenasSegundos 	: out std_logic_vector(3 downto 0); 
			unidadesMinutos 	: out std_logic_vector(3 downto 0); 
			decenasMinutos 	: out std_logic_vector(3 downto 0) 
			);
	end component; 
	
	signal cuenta				: std_logic_vector (11 downto 0);
	signal unidadesSegundos	: std_logic_vector(3 downto 0); 
	signal decenasSegundos 	: std_logic_vector(3 downto 0); 
	signal unidadesMinutos 	: std_logic_vector(3 downto 0); 
	signal decenasMinutos 	: std_logic_vector(3 downto 0);
	---------------------------------------------------------------------------------
	
	component vga is 
		Port (
		clk50Mhz		: 	in std_logic;
		column		: out INTEGER RANGE 0 TO (800 - 1) := 0;
		row			: out INTEGER RANGE 0 TO (525 - 1) := 0;
		display_ena	: out STD_LOGIC; 
		h_sync		: out std_logic;
		v_sync		: out std_logic);
	end component vga;
	
	signal column		: INTEGER RANGE 0 TO 800 - 1 := 0;
	signal row			: INTEGER RANGE 0 TO 525 - 1 := 0;	
	signal display_ena: STD_LOGIC:= '0'; 
	
	--Constantes del sistema emulador de Display de 7 segmentos en Monitor
	constant cero	:	std_logic_vector(6 downto 0):= "0111111";
	constant uno	:  std_logic_vector(6 downto 0):= "0000110";
	constant dos	:  std_logic_vector(6 downto 0):= "1011011";
	constant tres	:  std_logic_vector(6 downto 0):= "1001111";	
	constant cuatro:  std_logic_vector(6 downto 0):= "1100110";
	constant cinco	:  std_logic_vector(6 downto 0):= "1101101";
	constant seis	:  std_logic_vector(6 downto 0):= "1111101";
	constant siete	:  std_logic_vector(6 downto 0):= "0000111";
	constant ocho	:  std_logic_vector(6 downto 0):= "1111111";
	constant nueve	:  std_logic_vector(6 downto 0):= "1110011";	
	
	signal conectorUniSeg: std_logic_vector(6 downto 0); --coneccion del decodificador unidadesSegundos con ima_gen
	signal conectorDecSeg: std_logic_vector(6 downto 0); --coneccion del decodificador decenasSegundos con ima_gen
	signal conectorUniMin: std_logic_vector(6 downto 0); --coneccion del decodificador unidadesMinutos con ima_gen
	signal conectorDecMin: std_logic_vector(6 downto 0); --coneccion del decodificador decenasMinutos con ima_gen
	signal prueba: std_logic:= '0';
begin 

	U1: relojDigital port map (clk50Mhz, inicio, cuenta, unidadesSegundos, decenasSegundos, unidadesMinutos, decenasMinutos);
	U3: vga port map (clk50MHz, column, row, display_ena, h_sync, v_sync);
	
		
	--Decodificador BCD 7 segmentos para tarjeta unidadesSegundos
	with unidadesSegundos select conectorUniSeg <= 
		"0111111" when "0000",
		"0000110" when "0001",
		"1011011" when "0010",
		"1001111" when "0011",
		"1100110" when "0100",
		"1101101" when "0101",
		"1111101" when "0110",
		"0000111" when "0111",
		"1111111" when "1000",
		"1110011" when "1001",
		"0000001" when others;
		
	--Decodificador BCD 7 segmentos para tarjeta decenasSegundos
	with decenasSegundos select conectorDecSeg <= 
		"0111111" when "0000",
		"0000110" when "0001",
		"1011011" when "0010",
		"1001111" when "0011",
		"1100110" when "0100",
		"1101101" when "0101",
		"1111101" when "0110",
		"0000111" when "0111",
		"1111111" when "1000",
		"1110011" when "1001",
		"0000001" when others;
		
		--Decodificador BCD 7 segmentos para tarjeta unidadesMinutos
	with unidadesMinutos select conectorUniMin <= 
		"0111111" when "0000",
		"0000110" when "0001",
		"1011011" when "0010",
		"1001111" when "0011",
		"1100110" when "0100",
		"1101101" when "0101",
		"1111101" when "0110",
		"0000111" when "0111",
		"1111111" when "1000",
		"1110011" when "1001",
		"0000001" when others;
		
	--Decodificador BCD 7 segmentos para tarjeta decenasMinutos
	with decenasMinutos select conectorDecMin <= 
		"0111111" when "0000",
		"0000110" when "0001",
		"1011011" when "0010",
		"1001111" when "0011",
		"1100110" when "0100",
		"1101101" when "0101",
		"1111101" when "0110",
		"0000111" when "0111",
		"1111111" when "1000",
		"1110011" when "1001",
		"0000001" when others;
	
	
	generador_imagen: process(display_ena, row, column, conectorDecMin, conectorUniMin, conectorDecSeg, conectorUniSeg)
	begin 
		if (display_ena = '1') then 
			case conectorDecMin is 
				when cero => 
					if	((row > 200 and row < 210) and
						 (column > 110 and column < 140)) THEN   --a azul
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');
					elsif	((row > 210 and row < 240) and
						 (column > 140 and column < 150)) THEN   --b verde
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					elsif ((row > 250 and row < 280) and
							(column > 140 and column < 150)) THEN    --c rojo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '0');		
					elsif ((row > 280 and row < 290) and
							(column > 110 and column < 140)) THEN    --d blanco
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');	
					elsif ((row > 250 and row < 280) and
							(column > 100 and column < 110)) THEN    --e cian
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');	
					elsif ((row > 210 and row < 240) and
							(column > 100 and column < 110)) THEN    --f amarillo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					else
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '0');
					end if;
				
				when uno => 
					if	((row > 210 and row < 240) and
						 (column > 140 and column < 150)) THEN   --b verde
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					elsif ((row > 250 and row < 280) and
							(column > 140 and column < 150)) THEN    --c rojo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '0');
					else
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '0');
					end if;
					
				when dos => 
					if	((row > 200 and row < 210) and
						 (column > 110 and column < 140)) THEN   --a azul
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');
					elsif ((row > 210 and row < 240) and
							(column > 140 and column < 150)) THEN    --b verde
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					elsif ((row > 280 and row < 290) and
							(column > 110 and column < 140)) THEN    --d blanco
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');	
					elsif ((row > 250 and row < 280) and
							(column > 100 and column < 110)) THEN    --e cian
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');	
					elsif ((row > 240 and row < 250) and
							(column > 110 and column < 140)) THEN    --g violeta
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');	
					else
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '0');
					end if;
				
				when others => 
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '0');
			end case;
			
			case conectorUniMin is 
				when cero => 
					if	((row > 200 and row < 210) and
						 (column > 180 and column < 210)) THEN   --a azul
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');
					elsif	((row > 210 and row < 240) and
						 (column > 210 and column < 220)) THEN   --b verde
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					elsif ((row > 250 and row < 280) and
							(column > 210 and column < 220)) THEN    --c rojo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '0');		
					elsif ((row > 280 and row < 290) and
							(column > 180 and column < 210)) THEN    --d blanco
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');	
					elsif ((row > 250 and row < 280) and
							(column > 170 and column < 180)) THEN    --e cian
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');	
					elsif ((row > 210 and row < 240) and
							(column > 170 and column < 180)) THEN    --f amarillo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					elsif ((row > 230 and row < 240) and
							(column > 240 and column < 250)) THEN    -- punto A cian
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');
					elsif ((row > 250 and row < 260) and
							(column > 240 and column < 250)) THEN    -- punto B eosa
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');
					end if;
				
				when uno => 
					if	((row > 210 and row < 240) and
						 (column > 210 and column < 220)) THEN   --b verde
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					elsif ((row > 250 and row < 280) and
							(column > 210 and column < 220)) THEN    --c rojo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '0');
					elsif ((row > 230 and row < 240) and
							(column > 240 and column < 250)) THEN    -- punto A cian
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');
					elsif ((row > 250 and row < 260) and
							(column > 240 and column < 250)) THEN    -- punto B eosa
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');
					end if;
					
				when dos => 
					if	((row > 200 and row < 210) and
						 (column > 180 and column < 210)) THEN   --a azul
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');
					elsif ((row > 210 and row < 240) and
							(column > 210 and column < 220)) THEN    --b verde
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					elsif ((row > 280 and row < 290) and
							(column > 180 and column < 210)) THEN    --d blanco
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');	
					elsif ((row > 250 and row < 280) and
							(column > 170 and column < 180)) THEN    --e cian
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');	
					elsif ((row > 240 and row < 250) and
							(column > 180 and column < 210)) THEN    --g violeta
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');	
					elsif ((row > 230 and row < 240) and
							(column > 240 and column < 250)) THEN    -- punto A cian
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');
					elsif ((row > 250 and row < 260) and
							(column > 240 and column < 250)) THEN    -- punto B eosa
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');
					end if;
				
				when tres => 
					if	((row > 200 and row < 210) and
						 (column > 180 and column < 210)) THEN   --a azul
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');
					elsif ((row > 210 and row < 240) and
							(column > 210 and column < 220)) THEN    --b verde
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					elsif ((row > 250 and row < 280) and
							(column > 210 and column < 220)) THEN    --c rojo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '0');	
					elsif ((row > 280 and row < 290) and
							(column > 180 and column < 210)) THEN    --d blanco
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');	
					elsif ((row > 240 and row < 250) and
							(column > 180 and column < 210)) THEN    --g violeta
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');	
					elsif ((row > 230 and row < 240) and
							(column > 240 and column < 250)) THEN    -- punto A cian
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');
					elsif ((row > 250 and row < 260) and
							(column > 240 and column < 250)) THEN    -- punto B eosa
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');
					end if;
				
				when cuatro => 
					if((row > 210 and row < 240) and
							(column > 210 and column < 220)) THEN    --b verde
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					elsif ((row > 250 and row < 280) and
							(column > 210 and column < 220)) THEN    --c rojo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '0');	
					elsif ((row > 240 and row < 250) and
							(column > 180 and column < 210)) THEN    --g violeta
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');	
					elsif ((row > 210 and row < 240) and
							(column > 170 and column < 180)) THEN    --f amarillo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					elsif ((row > 230 and row < 240) and
							(column > 240 and column < 250)) THEN    -- punto A cian
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');
					elsif ((row > 250 and row < 260) and
							(column > 240 and column < 250)) THEN    -- punto B eosa
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');
					end if;
				
				when cinco => 
					if	((row > 200 and row < 210) and
						 (column > 180 and column < 210)) THEN   --a azul
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');
					elsif ((row > 250 and row < 280) and
							(column > 210 and column < 220)) THEN    --c rojo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '0');		
					elsif ((row > 280 and row < 290) and
							(column > 180 and column < 210)) THEN    --d blanco
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');	
					elsif ((row > 210 and row < 240) and
							(column > 170 and column < 180)) THEN    --f amarillo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					elsif ((row > 240 and row < 250) and
							(column > 180 and column < 210)) THEN    --g violeta
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');	
					elsif ((row > 230 and row < 240) and
							(column > 240 and column < 250)) THEN    -- punto A cian
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');
					elsif ((row > 250 and row < 260) and
							(column > 240 and column < 250)) THEN    -- punto B eosa
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');
					end if;
					
				when seis => 
					if	((row > 200 and row < 210) and
						 (column > 180 and column < 210)) THEN   --a azul
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');
					elsif ((row > 250 and row < 280) and
							(column > 210 and column < 220)) THEN    --c rojo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '0');		
					elsif ((row > 280 and row < 290) and
							(column > 180 and column < 210)) THEN    --d blanco
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');	
					elsif ((row > 250 and row < 280) and
							(column > 170 and column < 180)) THEN    --e cian
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');	
					elsif ((row > 210 and row < 240) and
							(column > 170 and column < 180)) THEN    --f amarillo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					elsif ((row > 240 and row < 250) and
							(column > 180 and column < 210)) THEN    --g violeta
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');	
					elsif ((row > 230 and row < 240) and
							(column > 240 and column < 250)) THEN    -- punto A cian
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');
					elsif ((row > 250 and row < 260) and
							(column > 240 and column < 250)) THEN    -- punto B eosa
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');
					end if;
					
				when siete => 
					if	((row > 200 and row < 210) and
						 (column > 180 and column < 210)) THEN   --a azul
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');
					elsif	((row > 210 and row < 240) and
						 (column > 210 and column < 220)) THEN   --b verde
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					elsif ((row > 250 and row < 280) and
							(column > 210 and column < 220)) THEN    --c rojo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '0');
					elsif ((row > 230 and row < 240) and
							(column > 240 and column < 250)) THEN    -- punto A cian
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');
					elsif ((row > 250 and row < 260) and
							(column > 240 and column < 250)) THEN    -- punto B eosa
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');
					end if;
					
				when ocho => 
					if	((row > 200 and row < 210) and
						 (column > 180 and column < 210)) THEN   --a azul
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');
					elsif	((row > 210 and row < 240) and
						 (column > 210 and column < 220)) THEN   --b verde
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					elsif ((row > 250 and row < 280) and
							(column > 210 and column < 220)) THEN    --c rojo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '0');		
					elsif ((row > 280 and row < 290) and
							(column > 180 and column < 210)) THEN    --d blanco
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');	
					elsif ((row > 250 and row < 280) and
							(column > 170 and column < 180)) THEN    --e cian
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');	
					elsif ((row > 210 and row < 240) and
							(column > 170 and column < 180)) THEN    --f amarillo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					elsif ((row > 240 and row < 250) and
							(column > 180 and column < 210)) THEN    --g violeta
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');	
					elsif ((row > 230 and row < 240) and
							(column > 240 and column < 250)) THEN    -- punto A cian
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');
					elsif ((row > 250 and row < 260) and
							(column > 240 and column < 250)) THEN    -- punto B eosa
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');
					end if;
				
				when nueve => 
					if	((row > 200 and row < 210) and
						 (column > 180 and column < 210)) THEN   --a azul
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');
					elsif	((row > 210 and row < 240) and
						 (column > 210 and column < 220)) THEN   --b verde
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					elsif ((row > 250 and row < 280) and
							(column > 210 and column < 220)) THEN    --c rojo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '0');			
					elsif ((row > 210 and row < 240) and
							(column > 170 and column < 180)) THEN    --f amarillo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					elsif ((row > 240 and row < 250) and
							(column > 180 and column < 210)) THEN    --g violeta
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');	
					elsif ((row > 230 and row < 240) and
							(column > 240 and column < 250)) THEN    -- punto A cian
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');
					elsif ((row > 250 and row < 260) and
							(column > 240 and column < 250)) THEN    -- punto B eosa
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');
					end if;
				when others => 
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '0');
			end case;
			
			case conectorDecSeg is 
				when cero => 
					if	((row > 200 and row < 210) and
						 (column > 280 and column < 310)) THEN   --a azul
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');
					elsif	((row > 210 and row < 240) and
						 (column > 310 and column < 320)) THEN   --b verde
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					elsif ((row > 250 and row < 280) and
							(column > 310 and column < 320)) THEN    --c rojo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '0');		
					elsif ((row > 280 and row < 290) and
							(column > 280 and column < 310)) THEN    --d blanco
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');	
					elsif ((row > 250 and row < 280) and
							(column > 270 and column < 280)) THEN    --e cian
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');	
					elsif ((row > 210 and row < 240) and
							(column > 270 and column < 280)) THEN    --f amarillo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					end if;
				
				when uno => 
					if	((row > 210 and row < 240) and
						 (column > 310 and column < 320)) THEN   --b verde
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					elsif ((row > 250 and row < 280) and
							(column > 310 and column < 320)) THEN    --c rojo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '0');
					end if;
					
				when dos => 
					if	((row > 200 and row < 210) and
						 (column > 280 and column < 310)) THEN   --a azul
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');
					elsif ((row > 210 and row < 240) and
							(column > 310 and column < 320)) THEN    --b verde
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					elsif ((row > 280 and row < 290) and
							(column > 280 and column < 310)) THEN    --d blanco
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');	
					elsif ((row > 250 and row < 280) and
							(column > 270 and column < 280)) THEN    --e cian
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');	
					elsif ((row > 240 and row < 250) and
							(column > 280 and column < 310)) THEN    --g violeta
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');	
					end if;
				
				when tres => 
					if	((row > 200 and row < 210) and
						 (column > 280 and column < 310)) THEN   --a azul
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');
					elsif ((row > 210 and row < 240) and
							(column > 310 and column < 320)) THEN    --b verde
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					elsif ((row > 250 and row < 280) and
							(column > 310 and column < 320)) THEN    --c rojo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '0');	
					elsif ((row > 280 and row < 290) and
							(column > 280 and column < 310)) THEN    --d blanco
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');	
					elsif ((row > 240 and row < 250) and
							(column > 280 and column < 310)) THEN    --g violeta
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');	
					end if;
				
				when cuatro => 
					if((row > 210 and row < 240) and
							(column > 310 and column < 320)) THEN    --b verde
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					elsif ((row > 250 and row < 280) and
							(column > 310 and column < 320)) THEN    --c rojo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '0');	
					elsif ((row > 240 and row < 250) and
							(column > 280 and column < 310)) THEN    --g violeta
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');	
					elsif ((row > 210 and row < 240) and
							(column > 270 and column < 280)) THEN    --f amarillo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					end if;
				
				when cinco => 
					if	((row > 200 and row < 210) and
						 (column > 280 and column < 310)) THEN   --a azul
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');
					elsif ((row > 250 and row < 280) and
							(column > 310 and column < 320)) THEN    --c rojo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '0');		
					elsif ((row > 280 and row < 290) and
							(column > 280 and column < 310)) THEN    --d blanco
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');	
					elsif ((row > 210 and row < 240) and
							(column > 270 and column < 280)) THEN    --f amarillo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					elsif ((row > 240 and row < 250) and
							(column > 280 and column < 310)) THEN    --g violeta
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');	
					end if;
				when others => 
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '0');
			end case;
			
			case conectorUniSeg is 
				when cero => 
					if	((row > 200 and row < 210) and
						 (column > 350 and column < 380)) THEN   --a azul
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');
					elsif	((row > 210 and row < 240) and
						 (column > 380 and column < 390)) THEN   --b verde
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					elsif ((row > 250 and row < 280) and
							(column > 380 and column < 390)) THEN    --c rojo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '0');		
					elsif ((row > 280 and row < 290) and
							(column > 350 and column < 380)) THEN    --d blanco
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');	
					elsif ((row > 250 and row < 280) and
							(column > 340 and column < 350)) THEN    --e cian
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');	
					elsif ((row > 210 and row < 240) and
							(column > 340 and column < 350)) THEN    --f amarillo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					end if;
				
				when uno => 
					if	((row > 210 and row < 240) and
						 (column > 380 and column < 390)) THEN   --b verde
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					elsif ((row > 250 and row < 280) and
							(column > 380 and column < 390)) THEN    --c rojo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '0');
					end if;
					
				when dos => 
					if	((row > 200 and row < 210) and
						 (column > 350 and column < 380)) THEN   --a azul
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');
					elsif ((row > 210 and row < 240) and
							(column > 380 and column < 390)) THEN    --b verde
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					elsif ((row > 280 and row < 290) and
							(column > 350 and column < 380)) THEN    --d blanco
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');	
					elsif ((row > 250 and row < 280) and
							(column > 340 and column < 350)) THEN    --e cian
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');	
					elsif ((row > 240 and row < 250) and
							(column > 350 and column < 380)) THEN    --g violeta
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');	
					end if;
				
				when tres => 
					if	((row > 200 and row < 210) and
						 (column > 350 and column < 380)) THEN   --a azul
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');
					elsif ((row > 210 and row < 240) and
							(column > 380 and column < 390)) THEN    --b verde
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					elsif ((row > 250 and row < 280) and
							(column > 380 and column < 390)) THEN    --c rojo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '0');	
					elsif ((row > 280 and row < 290) and
							(column > 350 and column < 380)) THEN    --d blanco
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');	
					elsif ((row > 240 and row < 250) and
							(column > 350 and column < 380)) THEN    --g violeta
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');	
					end if;
				
				when cuatro => 
					if((row > 210 and row < 240) and
							(column > 380 and column < 390)) THEN    --b verde
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					elsif ((row > 250 and row < 280) and
							(column > 380 and column < 390)) THEN    --c rojo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '0');	
					elsif ((row > 240 and row < 250) and
							(column > 350 and column < 380)) THEN    --g violeta
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');	
					elsif ((row > 210 and row < 240) and
							(column > 340 and column < 350)) THEN    --f amarillo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					end if;
				
				when cinco => 
					if	((row > 200 and row < 210) and
						 (column > 350 and column < 380)) THEN   --a azul
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');
					elsif ((row > 250 and row < 280) and
							(column > 380 and column < 390)) THEN    --c rojo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '0');		
					elsif ((row > 280 and row < 290) and
							(column > 350 and column < 380)) THEN    --d blanco
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');	
					elsif ((row > 210 and row < 240) and
							(column > 340 and column < 350)) THEN    --f amarillo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					elsif ((row > 240 and row < 250) and
							(column > 350 and column < 380)) THEN    --g violeta
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');	
					end if;
					
				when seis => 
					if	((row > 200 and row < 210) and
						 (column > 350 and column < 380)) THEN   --a azul
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');
					elsif ((row > 250 and row < 280) and
							(column > 380 and column < 390)) THEN    --c rojo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '0');		
					elsif ((row > 280 and row < 290) and
							(column > 350 and column < 380)) THEN    --d blanco
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');	
					elsif ((row > 250 and row < 280) and
							(column > 340 and column < 350)) THEN    --e cian
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');	
					elsif ((row > 210 and row < 240) and
							(column > 340 and column < 350)) THEN    --f amarillo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					elsif ((row > 240 and row < 250) and
							(column > 350 and column < 380)) THEN    --g violeta
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');	
					end if;
					
				when siete => 
					if	((row > 200 and row < 210) and
						 (column > 350 and column < 380)) THEN   --a azul
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');
					elsif	((row > 210 and row < 240) and
						 (column > 380 and column < 390)) THEN   --b verde
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					elsif ((row > 250 and row < 280) and
							(column > 380 and column < 390)) THEN    --c rojo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '0');
					end if;
					
				when ocho => 
					if	((row > 200 and row < 210) and
						 (column > 350 and column < 380)) THEN   --a azul
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');
					elsif	((row > 210 and row < 240) and
						 (column > 380 and column < 390)) THEN   --b verde
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					elsif ((row > 250 and row < 280) and
							(column > 380 and column < 390)) THEN    --c rojo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '0');		
					elsif ((row > 280 and row < 290) and
							(column > 350 and column < 380)) THEN    --d blanco
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');	
					elsif ((row > 250 and row < 280) and
							(column > 340 and column < 350)) THEN    --e cian
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '1');	
					elsif ((row > 210 and row < 240) and
							(column > 340 and column < 350)) THEN    --f amarillo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					elsif ((row > 240 and row < 250) and
							(column > 350 and column < 380)) THEN    --g violeta
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');	
					end if;
				
				when nueve => 
					if	((row > 200 and row < 210) and
						 (column > 350 and column < 380)) THEN   --a azul
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');
					elsif	((row > 210 and row < 240) and
						 (column > 380 and column < 390)) THEN   --b verde
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					elsif ((row > 250 and row < 280) and
							(column > 380 and column < 390)) THEN    --c rojo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '0');			
					elsif ((row > 210 and row < 240) and
							(column > 340 and column < 350)) THEN    --f amarillo
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '1');
						blue  <=  (OTHERS => '0');
					elsif ((row > 240 and row < 250) and
							(column > 350 and column < 380)) THEN    --g violeta
						red   <=  (OTHERS => '1');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '1');	
					end if;
				when others => 
						red   <=  (OTHERS => '0');
						green <=  (OTHERS => '0');
						blue  <=  (OTHERS => '0');
			end case;
		end if;
	end process generador_imagen;
	
end behavorial;
	
	
	
	
	
	
	
	
	
	
	
	
	
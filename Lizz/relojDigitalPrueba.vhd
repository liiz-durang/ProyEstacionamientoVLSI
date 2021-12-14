--------------------------------------------------------------------------------
--
--   FileName:         relojDigital.vhd
--   Design Software:  Quartus II 64-bit Version 13.1 Build 162 SJ Full Version
--   Descripción:		  Diseño de un reloj digital con formato 00:00 
--	  Version:			  1.0
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all; 

--Entidad del sistema Reloj Digital 
entity relojDigitalPrueba is 
	Port	( 	
		clk50MHz : in std_logic;
		inicio: in std_logic;
		pruebaStart: out std_logic;
		pruebaCuenta_bin: out STD_LOGIC_VECTOR (7 downto 0);
		cuenta_seg: in   STD_LOGIC_VECTOR (7 downto 0); --Vector en binario
		HEX0 	: out std_logic_vector(6 downto 0); --UnidadesMinutos Qum
		HEX1 : out std_logic_vector(6 downto 0); --DecenasMinutos Qdm
		HEX2 : out std_logic_vector(6 downto 0); --UnidadesHoras Quh
		HEX3 : out std_logic_vector(6 downto 0) --DecenasHoras Qdh
			);
end relojDigitalPrueba; 

-- Parte declaratoria en la arquitectura del sistema Reloj Digital
architecture behavorial of relojDigitalPrueba is
	
	signal start : std_logic := '0';
	signal stop: std_logic:= '0';
	signal auxClk : std_logic;
	signal cuenta_bin: STD_LOGIC_VECTOR (7 downto 0):= "00000000"; --Vector en binario
	
	signal n : std_logic;
	signal Qs : std_logic_vector(3 downto 0):= "0000";
	signal Qum : std_logic_vector(3 downto 0):= "0000";
	signal Qdm : std_logic_vector(3 downto 0):= "0000";
	signal e : std_logic;
	signal Quh : std_logic_vector(3 downto 0):= "0000";
	signal Qdh : std_logic_vector(3 downto 0):= "0000";
	signal z : std_logic;
	signal u : std_logic;
	signal d : std_logic;
	signal reset : std_logic:= '0'; 
	

begin 
	--Recibe señal de activación para empezar a calcular tiempo en modo 00:00
	iniciaCalculo : process (clk50MHz, inicio)
	begin 
		if rising_edge(clk50MHz) then 
			if inicio = '1' then --detecta flanco de subida
				start <= '1';
				reset <= '0';
			else 
				start <= '0';
				reset <= '1';
			end if;
		end if;
	end process; 
	pruebaStart <= start;
	
	divisor : process (clk50MHz)
		variable CUENTA: STD_LOGIC_VECTOR(27 downto 0) := X"0000000";
	begin 
		if rising_edge (clk50MHz) then
			if CUENTA = X"48009E0" then 
				CUENTA := X"0000000"; 		
			else 
				CUENTA := CUENTA + 1; 
			end if;
		end if; 

		auxClk <= CUENTA(17);

	end process; 
	
	-- Va a seguir contando mientras cuenta_bin sea menor que la cuenta_seg de entrada.
	validar: process (auxClk, stop, start, reset)
	begin 
		if rising_edge (auxClk) then 
			if start = '1' then 
				if cuenta_bin = cuenta_seg then
					stop <= '1';
				else 
					cuenta_bin <= cuenta_bin + 1;
					stop <= '0';
				end if;
			end if;
		end if;
		
		if reset = '1' then 
			cuenta_bin <= "00000000";	
		end if; 
	end process;
	
	pruebaCuenta_bin <= cuenta_bin;
	
	--Incrementará el tiempo hasta que llegue a cuenta en binario en la entrada;
	
	UNIDADES: process (auxClk, stop, start, reset)	
		variable CUENTA: STD_LOGIC_VECTOR(3 downto 0) := "0000";
	begin 
		if rising_edge (auxClk) then
			if start = '1' then 
				if stop = '0' then 
					if CUENTA = "1001" then 
						CUENTA := "0000"; 
						N <= '1';
					else 
						CUENTA := CUENTA + 1; 
						N <= '0'; 
					end if; 
				end if; 
			end if;
		end if; 
		if reset = '1' then 
			cuenta := "0000";
		end if; 
		Qum <= CUENTA; 
	end process;
	
	DECENAS: process (N, reset)	
		variable CUENTA: STD_LOGIC_VECTOR(3 downto 0) := "0000";
	begin 
		if rising_edge (N) then 
				if CUENTA = "0101" then 
					CUENTA := "0000"; 
					E <= '1';
				else 
					CUENTA := CUENTA + 1; 
					E <= '0'; 
				end if; 
		end if; 
		if reset = '1' then 
			cuenta := "0000";
		end if; 
		Qdm <= CUENTA; 
	end process;
	
	HoraU: process (E,reset)	
		variable cuenta: STD_LOGIC_VECTOR(3 downto 0) := "0000";
	begin 
		if rising_edge (E) then 
			if cuenta = "1001" then 
				cuenta := "0000"; 
				Z <= '1';
			else 
				cuenta := cuenta + 1; 
				Z <= '0'; 
			end if; 
		end if; 
		if reset = '1' then 
			cuenta := "0000";
		end if; 
		Quh <= cuenta; 
	end process;
	
		HoraD: process (Z,reset)	
		variable cuenta: STD_LOGIC_VECTOR(3 downto 0) := "0000";
	begin 
		if rising_edge (Z) then 
			if cuenta = "0010" then 
				cuenta := "0000"; 
			else 
				cuenta := cuenta + 1; 
			end if; 
		end if; 
		if reset = '1' then 
			cuenta := "0000";
		end if; 
		Qdh <= cuenta; 
	end process;
		

		

	
	with Qum select 
	HEX0 <= "1000000" when "0000", --0
			  "1111001" when "0001", --1
			  "0100100" when "0010", --2
			  "0110000" when "0011", --3
			  "0011001" when "0100", --4
			  "0010010" when "0101", --5
			  "0000010" when "0110", --6
			  "1111000" when "0111", --7
			  "0000000" when "1000", --8
			  "0010000" when "1001", --9
			  "1000000" when others; 
	
	with Qdm select 
	HEX1 <= "1000000" when "0000", --0
			  "1111001" when "0001", --1
			  "0100100" when "0010", --2
			  "0110000" when "0011", --3
			  "0011001" when "0100", --4
			  "0010010" when "0101", --5
			  "0000010" when "0110", --6
			  "1111000" when "0111", --7
			  "0000000" when "1000", --8
			  "0010000" when "1001", --9
			  "1000000" when others; 

	with Quh select 
	HEX2 <= "1000000" when "0000", --0
			  "1111001" when "0001", --1
			  "0100100" when "0010", --2
			  "0110000" when "0011", --3
			  "0011001" when "0100", --4
			  "0010010" when "0101", --5
			  "0000010" when "0110", --6
			  "1111000" when "0111", --7
			  "0000000" when "1000", --8
			  "0010000" when "1001", --9
			  "1000000" when others; 

with Qdh select 
	HEX3 <= "1000000" when "0000", --0
			  "1111001" when "0001", --1
			  "0100100" when "0010", --2
			  "0110000" when "0011", --3
			  "0011001" when "0100", --4
			  "0010010" when "0101", --5
			  "0000010" when "0110", --6
			  "1111000" when "0111", --7
			  "0000000" when "1000", --8
			  "0010000" when "1001", --9
			  "1000000" when others; 

end behavorial; 


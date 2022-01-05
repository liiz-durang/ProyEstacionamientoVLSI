--------------------------------------------------------------------------------
--
--   FileName:         elegirTiempo.vhd
--   Design Software:  Quartus II 64-bit Version 13.1 Build 162 SJ Full Version
--   Descripción:		  De 4 temporizadores de entrada, a través de una entrada externa (botones)
--							  se elige el tiempo a mostrar.
--	  Version:			  1.0
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all; 

--Entidad del sistema Reloj Digital 
entity elegirTiempo is 
	Port	( 	
		clk50MHz	: in 	std_logic;
		cuenta1		: in 	STD_LOGIC_VECTOR (11 downto 0); --Tempo1
		cuenta2		: in 	STD_LOGIC_VECTOR (11 downto 0); --Tempo2
		cuenta3		: in 	STD_LOGIC_VECTOR (11 downto 0); --Tempo3
		cuenta4		: in 	STD_LOGIC_VECTOR (11 downto 0); --Tempo4
		parar1		: out std_logic;
		parar2		: out std_logic;
		parar3		: out std_logic;
		parar4		: out std_logic;
		inicioRelojDig	: out std_logic;
		servoSalida : out std_LOGIC;
		elegirCuenta: in std_logic_vector(3 downto 0);
		cuentaAmostrar		: out 	STD_LOGIC_VECTOR (11 downto 0) 
		);
end elegirTiempo; 

-- Parte declaratoria en la arquitectura del sistema Reloj Digital
architecture behavorial of elegirTiempo is
	
	signal cuenta_bin		: STD_LOGIC_VECTOR (11 downto 0):= "000000000000"; 
	signal parar			: std_logic_vector (3 downto 0):= "0000";
	signal auxIniReloj	: std_logic:= '0';
	signal auxIniReloj_past : std_logic:= '0';
	signal auxiniReloj_present : std_logic:= '0';
	signal auxIniReloj_past_2 : std_logic:= '0';
	signal auxiniReloj_present_2 : std_logic:= '0';
begin 

	hacerEleccion: process(clk50MHz, elegirCuenta)
	begin
		if rising_edge (clk50MHz) then 
			case elegirCuenta is 
				when "0001" => 
					cuenta_bin <= cuenta1;
					parar <= "0001";
					auxIniReloj <= '1';
					
				when "0010" =>
					cuenta_bin <= cuenta2;
					parar <= "0010";
					auxIniReloj <= '1';
				
				when "0100" =>
					cuenta_bin <= cuenta3;
					parar <= "0100";
					auxIniReloj <= '1';
					
				when "1000" =>
					cuenta_bin <= cuenta4;
					parar <= "1000";
					auxIniReloj <= '1';
					
				when others =>
					parar <= "0000";
					auxIniReloj <= '0';
			end case;
		end if;
	end process;
	
	genInicio : process(clk50MHz,auxIniReloj)
		variable banderaGuarda : std_LOGIC := '0';
		variable contadorGuarda : integer:=0;
		variable contadorCiclos : integer :=0;
	begin 
		if rising_edge(clk50MHz) then
			if (auxIniReloj_past /= auxiniReloj_present and auxIniReloj='1') -- flanco de subida
			then 
				banderaGuarda := '1'; -- inicia cuenta
				contadorGuarda :=0;
				contadorCiclos :=0;
			end if;
			
			if banderaGuarda ='1' then 
				if contadorciclos = 50_000_000 then
				 contadorGuarda := contadorGuarda +1;
				 contadorCiclos := 0;
				else 
					contadorCiclos := contadorCiclos+1;
				end if;
				
				if contadorGuarda = 10 then -- 10 seg
					banderaGuarda :='0';
					contadorGuarda:=0;
					contadorCiclos:=0;
				end if;
			end if;
			
			inicioRelojDig <= banderaGuarda;
			
			auxIniReloj_past <= auxiniReloj_present;
			auxiniReloj_present<= auxIniReloj;
			
		end if;
	
	end process;
	
	genSalida : process(clk50MHz,auxIniReloj)
		variable banderaGuarda : std_LOGIC := '0';
		variable contadorGuarda : integer:=0;
		variable contadorCiclos : integer :=0;
	begin 
		if rising_edge(clk50MHz) then
			if (auxIniReloj_past_2 /= auxiniReloj_present_2 and auxIniReloj='1') -- flanco de subida
			then 
				banderaGuarda := '1'; -- inicia cuenta
				contadorGuarda :=0;
				contadorCiclos :=0;
			end if;
			
			if banderaGuarda ='1' then 
				if contadorciclos = 50_000_000 then
				 contadorGuarda := contadorGuarda +1;
				 contadorCiclos := 0;
				else 
					contadorCiclos := contadorCiclos+1;
				end if;
				
				if contadorGuarda = 5 then -- 5 seg
					banderaGuarda :='0';
					contadorGuarda:=0;
					contadorCiclos:=0;
				end if;
			end if;
			
			servoSalida <= banderaGuarda;
			
			auxIniReloj_past_2 <= auxiniReloj_present_2;
			auxiniReloj_present_2<= auxIniReloj;
			
		end if;
	
	end process;
	
	
	
	parar1 <= parar(0);
	parar2 <= parar(1);
	parar3 <= parar(2);
	parar4 <= parar(3);
	cuentaAmostrar <= cuenta_bin;
	
	
end behavorial; 


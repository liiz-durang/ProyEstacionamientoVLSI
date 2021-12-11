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
entity ProyectoControlDisponible is

	Port ( reloj : in STD_LOGIC;
			 boton_inicio: in STD_LOGIC;
			 boton_stop1: in STD_LOGIC;
			 boton_stop2: in STD_LOGIC;
			 leds: out STD_LOGIC_VECTOR (2 downto 0)
			 );
end ProyectoControlDisponible;

architecture behavioral of ProyectoControlDisponible is 
	
	component ControlDisponible is
		Port ( clk50MHz : in STD_LOGIC;
			 entraAuto: in STD_LOGIC;
			 TempActivo1: in STD_LOGIC;
			 TempActivo2: in STD_LOGIC;
			 TempActivo3: in STD_LOGIC;
			 TempActivo4: in STD_LOGIC;
			 InicioTemp1: out STD_LOGIC;
			 InicioTemp2: out STD_LOGIC;
			 InicioTemp3: out STD_LOGIC;
			 InicioTemp4: out STD_LOGIC;
			 casillaDisponible: out STD_LOGIC_VECTOR(2 downto 0)
			 );
	end component;
	
	component Temporizador is 
		Port ( clk50MHz : in STD_LOGIC;
				 inicio: in STD_LOGIC;
				 parar: in STD_LOGIC;
				 activo: out STD_LOGIC;
				 cuenta_seg: out STD_LOGIC_VECTOR (7 downto 0)
				 );
	end component;
	signal activo1: std_logic;
	signal activo2: std_logic;
	signal activo3: std_logic;
	signal activo4: std_logic;
	
	signal inicioT1: std_logic;
	signal inicioT2: std_logic;
	signal inicioT3: std_logic;
	signal inicioT4: std_logic;
	
	signal seg1: std_logic_vector(7 downto 0);
	signal seg2: std_logic_vector(7 downto 0);
	signal seg3: std_logic_vector(7 downto 0);
	signal seg4: std_logic_vector(7 downto 0);
	
begin 
	Temp1: Temporizador port map (reloj,inicioT1,boton_stop1, activo1,seg1);
	Temp2: Temporizador port map (reloj,inicioT2,boton_stop1, activo2,seg2);
	Temp3: Temporizador port map (reloj,inicioT3,boton_stop2, activo3,seg3);
	Temp4: Temporizador port map (reloj,inicioT4,boton_stop2, activo4,seg4);
	CtrlDisp: ControlDisponible port map (
						 clk50MHz => reloj,
  						 entraAuto=> boton_inicio,
						 TempActivo1=> activo1,
						 TempActivo2=> activo2,
						 TempActivo3=> activo3,
						 TempActivo4=> activo4,
						 InicioTemp1=> inicioT1,
						 InicioTemp2=> inicioT2,
						 InicioTemp3=> inicioT3,
						 InicioTemp4=> inicioT4,
						 casillaDisponible=> leds
				);
	
	 
	
	
end behavioral;





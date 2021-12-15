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
			 elegirCuenta: in std_logic_vector(3 downto 0); --botones para parar los tempo
			 red: out std_logic_vector (3 downto 0);  --al monitor
			 green: out std_logic_vector (3 downto 0); --al monitor
			 blue: out std_logic_vector (3 downto 0); --al monitor 
			 h_sync: out std_logic; --al monitor
			 v_sync: out std_logic; --al monitor 
			 --displayCasilla: out STD_LOGIC_VECTOR (6 downto 0); -- casilla disponible
			 Ctrl_entrada : out STD_LOGIC; --Posicion Servomotor
			 Ctrl_salida : out STD_LOGIC; --Posicion Servomotor
			 emergencia : in	std_logic;
			 sismo : in std_logic;
			 reset	 : in	std_logic;
			 boton_confirm : in std_logic; -- confirmar la entrada al estacionamiento
			 zumbador: out std_logic;
			 displayDisp: out std_LOGIC_vector (6 downto 0);
			 rojo: out std_logic;
			 verde: out std_logic;
			 azul: out std_logic;
			 trigger : out std_logic;
			 echo : in std_logic;
			 AN: out std_LOGIC_vector (3 downto 0);
			 segmentos: out std_LOGIC_VECTOR (6 downto 0);
			 -- prueba 
			 led_1: out std_LOGIC;
			 led_2: out std_LOGIC;
			 led_3: out std_LOGIC;
			 led_4: out std_LOGIC;
			 led_5: out std_LOGIC;
			 led_6: out std_LOGIC;
			 led_7: out std_LOGIC;
			 led_f1: out std_LOGIC;
			 led_f2: out std_LOGIC;
			 led_f3: out std_LOGIC;
			 led_f4: out std_LOGIC;
			 led_confirm : out std_LOGIC
			 );
end ProyectoControlDisponible;

architecture behavioral of ProyectoControlDisponible is 
	
	component ControlDisponible is
		Port ( clk50MHz : in STD_LOGIC;
			 inicio: in STD_LOGIC;
			 TempActivo1: in STD_LOGIC;
			 TempActivo2: in STD_LOGIC;
			 TempActivo3: in STD_LOGIC;
			 TempActivo4: in STD_LOGIC;
			 InicioTemp1: out STD_LOGIC;
			 InicioTemp2: out STD_LOGIC;
			 InicioTemp3: out STD_LOGIC;
			 InicioTemp4: out STD_LOGIC;
			 casillaDisponible: out STD_LOGIC_VECTOR(3 downto 0)
			 );
	end component;
	
	component Temporizador is 
		Port ( clk50MHz : in STD_LOGIC;
				 inicio: in STD_LOGIC;
				 parar: in STD_LOGIC;
				 activo: out STD_LOGIC;
				 cuenta_seg: out STD_LOGIC_VECTOR (11 downto 0)
				 );
	end component;
	
	component elegirTiempo is 
	Port	( 	
		clk50MHz		: in 	std_logic;
		cuenta1		: in 	STD_LOGIC_VECTOR (11 downto 0); --Tempo1
		cuenta2		: in 	STD_LOGIC_VECTOR (11 downto 0); --Tempo2
		cuenta3		: in 	STD_LOGIC_VECTOR (11 downto 0); --Tempo3
		cuenta4		: in 	STD_LOGIC_VECTOR (11 downto 0); --Tempo4
		parar1		: out std_logic;
		parar2		: out std_logic;
		parar3		: out std_logic;
		parar4		: out std_logic;
		servo2T		: out std_logic;
		inicioRelojDig	: out std_logic;
		elegirCuenta: in std_logic_vector(3 downto 0);
		cuentaAmostrar		: out 	STD_LOGIC_VECTOR (11 downto 0) 
		);
	end component; 
	
	component ContadorLugaresDisponibles is 
		Port ( clk50MHz : in STD_LOGIC;
			 entraAuto: in STD_LOGIC;
			 autoSale: in STD_LOGIC;
			 disponible: out STD_LOGIC;
			 num: out STD_LOGIC_VECTOR(3 downto 0)
			 );
	end component;

	
	component ServomotorSalida is 
		Port(
				reloj : in STD_LOGIC;
				emergencia : in STD_LOGIC;  --Con fines de prueba, boton de emergencia
				servo2T : in STD_LOGIC;	--Con fines de prueba, boton de servo2T
				servo2: in STD_LOGIC;	--Con fines de prueba, boton de servo2
				salidaServo : out STD_LOGIC; -- Se declara más abajo
				Ctrl : out STD_LOGIC); --Posicion Servomotor
	end component;
	
	component servomotor_entrada is
		Port(
			reloj : in STD_LOGIC;
			 servo1 : in STD_LOGIC;
			 Ctrl : out STD_LOGIC);
	end component;
	
	component ControlEstacionamiento is
		port(
			clk		 : in	std_logic;
			emergencia : in	std_logic;
			sismo : in std_logic;
			pulso_entrada : in std_logic;
			disponible : in std_logic;
			boton_confirm : in std_logic;
			reset	 : in	std_logic;
			
			buzzer: out std_logic;
			auto_entra: out std_logic;
			servo2: out std_logic;
			servo1: out std_logic;
			color: out std_logic_vector(2 downto 0)
		);
	end component;
	
	component MostrarTiempo is
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
	end component;
	
	component LedControl is
		Port( clk: in STD_LOGIC;
					color: in STD_LOGIC_VECTOR(2 downto 0);
					rojo : out STD_LOGIC;
					verde : out STD_LOGIC;
					azul : out STD_LOGIC
			);
	end component;
	
	component sensorpulsoentrada is
		Port(clk: in STD_LOGIC;
			senial: out std_LOGIC; 
			trigger: out std_logic;
			eco: in std_logic);
	end component;
	
	component buzzer is 
		Port(
		 reloj : in STD_LOGIC;
		 entradaBuzzer: in STD_LOGIC;
		 buzzer : out STD_LOGIC);
	end component;

	component displayContador is 
		port( reloj: in std_logic;
			numero: in std_logic_vector(3 downto 0);
			AN: out std_logic_vector(3 downto 0);
			LS: out std_logic_vector(6 downto 0));
	end component;
	
	signal servo2T: std_LOGIC;
	signal servo2: std_LOGIC;
	signal salidaServo: std_LOGIC;
	
	signal disponible: std_LOGIC;
	signal pulso_entrada: std_LOGIC;
	signal auto_entra: std_LOGIC;
	signal inicioRelojDig: std_logic;
	signal servo1: std_LOGIC;
	signal cuentaAmostrar: STD_LOGIC_VECTOR (11 downto 0); 
	
	signal activo1: std_logic;
	signal activo2: std_logic;
	signal activo3: std_logic;
	signal activo4: std_logic;
	
	signal inicioT1: std_logic;
	signal inicioT2: std_logic;
	signal inicioT3: std_logic;
	signal inicioT4: std_logic;
	
	signal seg1: std_logic_vector(11 downto 0);
	signal seg2: std_logic_vector(11 downto 0);
	signal seg3: std_logic_vector(11 downto 0);
	signal seg4: std_logic_vector(11 downto 0);
	
	signal boton_stop1: STD_LOGIC; 
	signal boton_stop2: STD_LOGIC; 
	signal boton_stop3: STD_LOGIC;
	signal boton_stop4: STD_LOGIC;
	
	signal numLugaresDisponible: std_logic_vector(3 downto 0);
	signal numCasillaSugerida: std_logic_vector(3 downto 0);
	signal color : std_LOGIC_vector (2 downto 0);
	
	signal buzzer_signal : std_LOGIC;
	
	-- prueba 
	component divisor_gen is
		Generic (N : integer := 24);
		Port (clk : in std_logic;
				div_clk : out std_logic);
	end component;
	signal reloj_div : std_LOGIC;
	

	
begin 
	Temp1: Temporizador port map (reloj,inicioT1,boton_stop1, activo1,seg1);
	Temp2: Temporizador port map (reloj,inicioT2,boton_stop2, activo2,seg2);
	Temp3: Temporizador port map (reloj,inicioT3,boton_stop3, activo3,seg3);
	Temp4: Temporizador port map (reloj,inicioT4,boton_stop4, activo4,seg4);
	
	CtrlDisp: ControlDisponible port map (
						 clk50MHz => reloj,
  						 inicio=> servo1,
						 TempActivo1=> activo1,
						 TempActivo2=> activo2,
						 TempActivo3=> activo3,
						 TempActivo4=> activo4,
						 InicioTemp1=> inicioT1,
						 InicioTemp2=> inicioT2,
						 InicioTemp3=> inicioT3,
						 InicioTemp4=> inicioT4,
						 casillaDisponible=> numCasillaSugerida
				);
				
	
	elegir: elegirTiempo port map(reloj, seg1, seg2, seg3, seg4, boton_stop1, boton_stop2, boton_stop3, boton_stop4, servo2T, inicioRelojDig, elegirCuenta, cuentaAmostrar);  	
	
	mostrar: mostrarTiempo port map(reloj, inicioRelojDig, cuentaAmostrar, red, green, blue, h_sync, v_sync); 
	
	servoSalida: servomotorSalida port map (reloj, emergencia, servo2T, servo2, salidaServo, Ctrl_salida);
	
	servoEntrada: servomotor_entrada port map(reloj, servo1, Ctrl_entrada );
	-- Maquina de estados
	control: ControlEstacionamiento port map (reloj,emergencia, sismo, pulso_entrada, disponible, boton_confirm, reset, 
	buzzer_signal, auto_entra, servo2, servo1, color);
	
	buzz: buzzer port map ( reloj, buzzer_signal, zumbador );
	
	contadorLug : ContadorLugaresDisponibles port map( reloj, auto_entra, salidaServo, disponible, numLugaresDisponible );
	
	dispCasilla: displayContador port map (reloj, numCasillaSugerida, AN, segmentos); 
	
	ledRGB: LedControl port map(reloj,color, rojo, verde, azul );
	
	sensoEntrada : sensorpulsoentrada port map( reloj , pulso_entrada, trigger, echo );
				
				
	
	
	
	with numLugaresDisponible select
		displayDisp <= "1000000" when "0000", --0
		 "1111001" when "0001", --1
		 "0100100" when "0010", --2
		 "0110000" when "0011", --3
		 "0011001" when "0100", --4
		 "0010010" when "0101", --5
		 "0000010" when "0110", --6
		 "1111000" when "0111", --7
		 "0000000" when "1000", --8
		 "0010000" when "1001", --9
		 "1000000" when others; --F
		 
	
	-- prueba 
	led_f1		<= not emergencia;
	led_f2      <= not sismo;
	led_f3      <= not pulso_entrada;
	led_f4		<= not disponible;
	led_confirm <= boton_confirm;
	
	led_1 <= buzzer_signal;
	led_2 <= auto_entra;
	led_3 <= servo2;
	led_4 <= servo1;
	led_5 <= color(2);
	led_6 <= color(1);
	led_7 <= color(0);
	D1: divisor_gen generic map (25) port map (reloj,reloj_div);
	
end behavioral;





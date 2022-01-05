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
entity ProyectoEstacionamiento is

	Port ( reloj : in STD_LOGIC;
			 emergencia : in	std_logic;
			 sismo : in std_logic;
			 disponible: in std_LOGIC;
			 boton_confirm: in std_LOGIC;
		    reset : in std_LOGIC;
			 echo : in std_LOGIC;
			 
			 trigger: out std_LOGIC;
			 led_rojo: out std_LOGIC;
			 led_verde: out std_LOGIC;
			 led_azul: out std_LOGIC;
			 ctrl_entrada: out std_LOGIC;
			 ctrl_salida: out std_LOGIC;
			 buzzer: out std_LOGIC;
			 AN: out std_logic_vector(3 downto 0);
			 segmentos: out std_logic_vector(6 downto 0);
			 vga_rojo: out std_logic;
			 vga_verde: out std_logic;
			 vga_azul: out std_logic;
			 
			 h_sync: out std_LOGIC;
			 v_sync: out std_LOGIC;
			 
			 
			 boton_stop1: in STD_LOGIC; 
			 boton_stop2: in STD_LOGIC; 
			 boton_stop3: in STD_LOGIC;
			 boton_stop4: in STD_LOGIC;
			 
			 led_f1: out std_LOGIC;
			 led_f2: out std_LOGIC;
			 led_f3: out std_LOGIC;
			 led_f4: out std_LOGIC;
			 led_f5: out std_LOGIC;
			 
			 led_1: out std_LOGIC;
			 led_2: out std_LOGIC;
			 led_3: out std_LOGIC;
			 led_4: out std_LOGIC;
			 led_5: out std_LOGIC;
			 led_6: out std_LOGIC;
			 led_7: out std_LOGIC
			 
			 );
end ProyectoEstacionamiento;

architecture behavioral of ProyectoEstacionamiento is 
	
	signal servo2T: std_LOGIC;
	signal servo2: std_LOGIC;
	signal salidaServo: std_LOGIC;
	
	--signal disponible: std_LOGIC;
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
	
	signal stop1: STD_LOGIC; 
	signal stop2: STD_LOGIC; 
	signal stop3: STD_LOGIC;
	signal stop4: STD_LOGIC;
	
	signal numLugaresDisponible: std_logic_vector(3 downto 0);
	signal numCasillaSugerida: std_logic_vector(3 downto 0);
	signal color_aux : std_LOGIC_vector (2 downto 0);
	signal posicion : STD_LOGIC_VECTOR (6 downto 0);	
	signal posicion_servo2 : STD_LOGIC_VECTOR (6 downto 0);

	signal buzzer_signal : std_LOGIC;

	signal sig_disponible: STD_LOGIC;

	signal vga_red: std_logic_vector(3 downto 0);
	signal vga_green: std_logic_vector(3 downto 0);
	signal vga_blue: std_logic_vector(3 downto 0);
	
	signal inicio_time : std_LOGIC;
	
	signal cuenta_mostrar: STD_LOGIC_VECTOR (11 downto 0);
	
	signal stop_vector: std_LOGIC_vector(3 downto 0);
	
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
	
	component sensorpulsoentrada is
		Port(clk: in STD_LOGIC;
			senial: out std_LOGIC; 
			trigger: out std_logic;
			eco: in std_logic);
	end component;
	
	component LedControl is
		Port( clk: in STD_LOGIC;
					color: in STD_LOGIC_VECTOR(2 downto 0);
					rojo : out STD_LOGIC;
					verde : out STD_LOGIC;
					azul : out STD_LOGIC
			);
	end component;
	
	component servomotor is
		Port ( clk : in STD_LOGIC;
				 posicion: in STD_LOGIC_VECTOR (6 downto 0);
				 control : out STD_LOGIC); 
	end component;
	
	component buzzer_mod is 
		Port(
		 reloj : in STD_LOGIC;
		 entradaBuzzer: in STD_LOGIC;
		 buzzer : out STD_LOGIC);
	end component;
	
	component ControlDisponible is
		Port ( clk50MHz : in STD_LOGIC;
			 entraAuto: in STD_LOGIC;
			 TempActivo1: in STD_LOGIC;
			 TempActivo2: in STD_LOGIC;
			 TempActivo3: in STD_LOGIC;
			 TempActivo4: in STD_LOGIC;
			 disponible: out STD_LOGIC;
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
	
	component displayContador is 
		port( reloj: in std_logic;
			numero: in std_logic_vector(3 downto 0);
			AN: out std_logic_vector(3 downto 0);
			LS: out std_logic_vector(6 downto 0));
	end component;
	
	component MostrarTiempo is
		Port( clk50MHz: in STD_LOGIC;
				inicio: in std_LOGIC;
				cuenta_seg: in  STD_LOGIC_VECTOR (11 downto 0); --Vector en binario
				red: out std_logic_vector (3 downto 0);  --al monitor
				green: out std_logic_vector (3 downto 0); --al monitor
				blue: out std_logic_vector (3 downto 0); --al monitor 
				h_sync: out std_logic;
				v_sync: out std_logic );
	end component;
	
	component elegirTiempo is
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
			cuentaAmostrar		: out STD_LOGIC_VECTOR (11 downto 0) 
			);
	end component;
	
	
begin 



	control: ControlEstacionamiento port map (
						clk=> reloj,
						emergencia=> emergencia, 
						sismo=> sismo, 
						pulso_entrada=> pulso_entrada, 
						disponible=> sig_disponible, 
						boton_confirm=> boton_confirm, 
						reset=> reset, 
						
						buzzer=> buzzer_signal, 
						auto_entra=>auto_entra, 
						servo2=> servo2, 
						servo1=> servo1, 
						color => color_aux);
						
	sensoEntrada : sensorpulsoentrada port map( reloj , pulso_entrada, trigger, echo );
	
	ledRGB: LedControl port map(reloj,color_aux, led_rojo, led_verde, led_azul );

	servoEntrada: servomotor port map(
				clk => reloj,
				posicion => posicion,
				control => ctrl_entrada
				);
				
	buzz: buzzer_mod port map ( reloj, buzzer_signal, buzzer );

	Temp1: Temporizador port map (reloj,inicioT1,stop1, activo1,seg1);
	Temp2: Temporizador port map (reloj,inicioT2,stop2, activo2,seg2);
	Temp3: Temporizador port map (reloj,inicioT3,stop3, activo3,seg3);
	Temp4: Temporizador port map (reloj,inicioT4,stop4, activo4,seg4);
	
	CtrlDisp: ControlDisponible port map (
						 clk50MHz => reloj,
  						 entraAuto=> boton_confirm,
						 TempActivo1=> activo1,
						 TempActivo2=> activo2,
						 TempActivo3=> activo3,
						 TempActivo4=> activo4,
						 disponible=> sig_disponible,
						 InicioTemp1=> inicioT1,
						 InicioTemp2=> inicioT2,
						 InicioTemp3=> inicioT3,
						 InicioTemp4=> inicioT4,
						 casillaDisponible=> numCasillaSugerida
				);
	
	dispCasilla: displayContador port map (reloj, numCasillaSugerida, AN, segmentos); 
	
	stop_vector(3) <= not boton_stop4;
	stop_vector(2) <= not boton_stop3;
	stop_vector(1) <= not boton_stop2;
	stop_vector(0) <= not boton_stop1;
	

	controlTiempo: elegirTiempo port map(
		 clk50MHz=> reloj,
		 cuenta1=> seg1,
		 cuenta2=> seg2,
		 cuenta3=> seg3,
		 cuenta4=> seg4,
		 parar1=> stop1,
		 parar2=> stop2,
		 parar3=> stop3,
		 parar4=> stop4,
		 inicioRelojDig=> inicio_time,
		 servoSalida => servo2T,
		 elegirCuenta=> stop_vector,
		 cuentaAmostrar=> cuenta_mostrar
	);
	
	showTime: MostrarTiempo port map (
		clk50MHz => reloj,
		inicio=> inicio_time,
		cuenta_seg=> cuenta_mostrar,
		red => vga_red,
		green => vga_green,
		blue=> vga_blue,
		h_sync=> h_sync,
		v_sync=> v_sync
	);
	
	vga_rojo <= vga_red(0);
	vga_verde <= vga_green(0);
	vga_azul <= vga_blue(0);
	
	process(servo1) -- servo entrada
	begin 
		if servo1='1' then
			posicion <= "1011100";
		else
			posicion <= "0000000";
		end if; 
		
	end process;
	
	-- servo salida
	process(servo2,servo2T,emergencia)
	begin
		if emergencia = '1' then
			posicion_servo2 <= "0000000";
		elsif servo2='1' or servo2T ='1' then
			posicion_servo2 <= "1011100";
		else
			posicion_servo2 <= "0000000";
		end if;
	
	end process;
	
	servoSalida: servomotor port map(
			clk => reloj,
			posicion => posicion_servo2,
			control => ctrl_salida
			);
	
	-- prueba 
	led_f1		<= not activo1;
	led_f2      <= not activo2;
	led_f3      <= not activo3;
	led_f4		<= not activo4;

	led_f5		<= inicio_time;
	
	led_1 <= cuenta_mostrar(6);
	led_2 <= cuenta_mostrar(5);
	led_3 <= cuenta_mostrar(4);
	led_4 <= cuenta_mostrar(3);
	led_5 <= cuenta_mostrar(2);
	led_6 <= cuenta_mostrar(1);
	led_7 <= cuenta_mostrar(0);

	
end behavioral;





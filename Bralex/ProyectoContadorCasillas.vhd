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
entity ProyectoContadorCasillas is

	Port ( reloj : in STD_LOGIC;
			 boton_entra: in STD_LOGIC;
			 boton_sale: in STD_LOGIC; 
			 led_disp: out STD_LOGIC;
			 leds: out STD_LOGIC_VECTOR(3 downto 0)
			 );
end ProyectoContadorCasillas;

architecture behavioral of ProyectoContadorCasillas is 
	
	component ContadorLugaresDisponibles is
		Port ( clk50MHz : in STD_LOGIC;
			 entraAuto: in STD_LOGIC;
			 autoSale: in STD_LOGIC;
			 disponible: out STD_LOGIC;
			 num: out STD_LOGIC_VECTOR(3 downto 0)
			 );
	end component;
	
	
begin 
	CtrlDisp: ContadorLugaresDisponibles port map (
						 clk50MHz => reloj,
  						 entraAuto=> boton_entra,
						 autoSale=> boton_sale,
						 disponible=> led_disp,
						 num=> leds				 
				);
				
	 
	
	
end behavioral;





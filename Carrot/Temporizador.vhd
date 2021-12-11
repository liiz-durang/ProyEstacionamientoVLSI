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
entity Temporizador is

	Port ( clk50MHz : in STD_LOGIC;
			 inicio: in STD_LOGIC;
			 parar: in STD_LOGIC;
			 activo: out STD_LOGIC;
			 cuenta_seg: out STD_LOGIC_VECTOR (7 downto 0)
			 );
end Temporizador;

architecture behavioral of Temporizador is 
		
	signal reloj1s : STD_LOGIC;
	signal previo: std_logic := '1';
	signal previo_stop: std_logic := '0';

begin 

	
	process (clk50MHz, inicio) 	 -- Temporizador en ms
		variable cuenta: std_logic_vector (7 downto 0) := "00000000";
		variable contador_rapido: integer:=0;
		variable contando : bit := '0';
		
	begin	
		if rising_edge (clk50MHz) then
			if contando='0' then     -- En espera
				if inicio /= previo and inicio='1' then -- flanco de subida
					cuenta := "00000000";
					contador_rapido:=0;
					
					contando := '1';
					activo <= '1'; 
				else
					activo <= '0'; 
				end if;
			else   -- contando
				if contador_rapido > 50_000_000 then
					cuenta := cuenta + 1;
					contador_rapido:=0;
				end if;
				contador_rapido:=contador_rapido+1;
				
				if parar /=previo_stop and parar='1' then -- boton parar
					activo <= '0'; 
					contando := '0';
				else
					activo <= '1'; 
				end if;
			end if;
			
			cuenta_seg<=cuenta;
			
			previo <= inicio;
			previo_stop <=parar;
		end if;
	end process;
	


end behavioral;

-- Quartus II VHDL Template
-- Four-State Moore State Machine

-- A Moore machine's outputs are dependent only on the current state.
-- The output is written only when the state changes.  (State
-- transitions are synchronous.)

library ieee;
use ieee.std_logic_1164.all;

entity ControlEstacionamiento is

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

end entity;

architecture rtl of ControlEstacionamiento is

	-- Build an enumerated type for the state machine
	type state_type is (s0, s1, s2, s3, s4, s5);

	-- Register to hold the current state
	signal state   : state_type;

begin

	-- Logic to advance to the next state
	process (clk, reset)
	begin
		if reset = '0' then
			state <= s0;
		elsif (rising_edge(clk)) then
			case state is
				when s0=>
					if emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then
							
						state <= s0;
						
					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then 

						state <= s0;
					
					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s0;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s0;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then
					 
					 	state <= s1;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then
					 
					 	state <= s1;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s2;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s2;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then
					 
					 	state <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then
					 
					 	state <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s5;
				    
					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then 
							
						state <= s4;
						
					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then

						state <= s4;
					
					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then
					 
					 	state <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then
					 
					 	state <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s4;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then
					 
					 	state <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then
					 
					 	state <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then

						state <= s5;
						
					end if;
				when s1=>
					if emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then 
							
						state <= s0;
						
					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then

						state <= s0;
					
					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s0;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s0;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then
					 
					 	state <= s1;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then
					 
					 	state <= s1;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s2;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s2;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then
					 
					 	state <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then
					 
					 	state <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s5;
				    
					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then 
												
						state <= s4;
						
					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then

						state <= s4;
					
					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then
					 
					 	state <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then
					 
					 	state <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s4;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then
					 
					 	state <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then
					 
					 	state <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then

						state <= s5;
					
					end if;
				when s2=>
					if emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then 
							
						state <= s0;
						
					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then

						state <= s0;
					
					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s0;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s0;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then
					 
					 	state <= s2;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then
					 
					 	state <= s3;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s2;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s3;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then
					 
					 	state <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then
					 
					 	state <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s5;
				    
					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then 
							
						state <= s4;
						
					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then

						state <= s4;
					
					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then
					 
					 	state <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then
					 
					 	state <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s4;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then
					 
					 	state <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then
					 
					 	state <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then
					
						state <= s5;
					
					end if;
				when s3 =>
					if emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then 
							
						state <= s0;
						
					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then

						state <= s0;
					
					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s0;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s0;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then
					 
					 	state <= s3;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then
					 
					 	state <= s3;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s3;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s3;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then
					 
					 	state <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then
					 
					 	state <= s3;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then
					 
					 	state <= s3;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s3;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s3;
				    
					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then 
							
						state <= s4;
						
					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then

						state <= s4;
					
					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then
					 
					 	state <= s3;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then
					 
					 	state <= s3;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s3;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s3;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then
					 
					 	state <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then
					 
					 	state <= s3;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then
					 
					 	state <= s3;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s3;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then
					
						state <= s3;
					end if;
				when s4 =>
					if emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then 
							
						state <= s0;
						
					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then

						state <= s0;
					
					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s0;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s0;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then
					 
					 	state <= s0;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then
					 
					 	state <= s0;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s0;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s0;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then
					 
					 	state <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then
					 
					 	state <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s5;
				    
					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then
							
						state <= s4;
						
					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then

						state <= s4;
					
					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then
					 
					 	state <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then
					 
					 	state <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s4;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then
					 
					 	state <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then
					 
					 	state <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then
					
						state <= s5;
					end if;
				when s5 =>
					if emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then 
							
						state <= s0;
						
					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then

						state <= s0;
					
					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s0;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s0;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then
					 
					 	state <= s0;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then
					 
					 	state <= s0;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s0;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s1;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then
					 
					 	state <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then
					 
					 	state <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s5;
				    
					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then
							
						state <= s0;
						
					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then

						state <= s0;
					
					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s0;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s0;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then
					 
					 	state <= s0;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then
					 
					 	state <= s0;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s0;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s0;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then
					 
					 	state <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then
					 
					 	state <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then
					 
					 	state <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then
					 
					 	state <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then 
					
						state <= s5;
						
					end if;

				when others => 
					state <= s0;
			end case;
		end if;
	end process;

	-- Output depends solely on the current state
	process (state)
	begin
		case state is
			when s0 =>
				buzzer <= '0';
				auto_entra <= '0';
				servo2 <= '0';
				servo1 <= '0';
				color <= "000";
			when s1 =>
				buzzer <= '0';
				auto_entra <= '0';
				servo2 <= '0';
				servo1 <= '0';
				color <= "010";
			when s2 =>
				buzzer <= '0';
				auto_entra <= '0';
				servo2 <= '0';
				servo1 <= '0';
				color <= "001";
			when s3 =>
				buzzer <= '0';
				auto_entra <= '1';
				servo2 <= '0';
				servo1 <= '1';
				color <= "001";
			when s4 =>
				buzzer <= '0';
				auto_entra <= '0';
				servo2 <= '0';
				servo1 <= '0';
				color <= "100";
			when s5 =>
				buzzer <= '1';
				auto_entra <= '0';
				servo2 <= '1';
				servo1 <= '1';
				color <= "011";
			when others => 
				buzzer <= '0';
				auto_entra <= '0';
				servo2 <= '0';
				servo1 <= '0';
				color <= "000";
		end case;
	end process;

end rtl;

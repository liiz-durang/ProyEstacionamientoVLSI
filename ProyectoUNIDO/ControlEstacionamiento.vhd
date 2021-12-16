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
	signal EdoPres, EdoSig   : state_type := s0;

begin
	process (clk,reset)
	begin
		if reset = '0' then
			EdoPres <= s0;
		elsif rising_edge(clk) then
			EdoPres <= EdoSig;
		end if;

	end process;


	-- Logic to advance to the next state
	process (clk,emergencia, sismo, pulso_entrada, disponible, boton_confirm)
	begin
		if (rising_edge(clk)) then
			case EdoPres is
				when s0 =>
					if emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then -- "00000"
							
						EdoSig <= s0;
						
					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then -- "00001"

						EdoSig <= s0;
					
					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then -- "00010"
					 
					 	EdoSig <= s0;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then -- "00011"
					 
					 	EdoSig <= s0;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then -- "00100"
					 
					 	EdoSig <= s1;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then -- "00101"
					 
					 	EdoSig <= s1;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then -- "00110"
					 
					 	EdoSig <= s2;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then -- "00111"
					 
					 	EdoSig <= s2;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then -- "01000"
					 
					 	EdoSig <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then -- "01001"
					 
					 	EdoSig <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then -- "01010"
					 
					 	EdoSig <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then -- "01011"
					 
					 	EdoSig <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then -- "01100"
					 
					 	EdoSig <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then -- "01101"
					 
					 	EdoSig <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then -- "01110"
					 
					 	EdoSig <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then -- "01111"
					 
					 	EdoSig <= s5;
				    
					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then  -- "10000"
							
						EdoSig <= s4;
						
					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then -- "10001"

						EdoSig <= s4;
					
					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then -- "10010"
					 
					 	EdoSig <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then -- "10011"
					 
					 	EdoSig <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then -- "10100"
					 
					 	EdoSig <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then -- "10101"
					 
					 	EdoSig <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then -- "10110"
					 
					 	EdoSig <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then -- "10111"
					 
					 	EdoSig <= s4;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then  -- "11000"
					 
					 	EdoSig <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then -- "11001"
					 
					 	EdoSig <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and 
					boton_confirm ='0' then -- "11010"
					 
					 	EdoSig <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then -- "11011"
					 
					 	EdoSig <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then -- "11100"
					 
					 	EdoSig <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then -- "11101"
					 
					 	EdoSig <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then -- "11110"
					 
					 	EdoSig <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then -- "11111"

						EdoSig <= s5;
			
					else 
					
						EdoSig <= s0;
				
					end if;
		-- ESTADO 1
				when s1 =>
					if emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then -- "00000"
							
						EdoSig <= s0;
						
					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then -- "00001"

						EdoSig <= s0;
					
					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then -- "00010"
					 
					 	EdoSig <= s0;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then -- "00011"
					 
					 	EdoSig <= s0;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then -- "00100"
					 
					 	EdoSig <= s1;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then -- "00101"
					 
					 	EdoSig <= s1;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then -- "00110"
					 
					 	EdoSig <= s2;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then -- "00111"
					 
					 	EdoSig <= s2;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then -- "01000"
					 
					 	EdoSig <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then -- "01001"
					 
					 	EdoSig <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then -- "01010"
					 
					 	EdoSig <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then -- "01011"
					 
					 	EdoSig <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then -- "01100"
					 
					 	EdoSig <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then -- "01101"
					 
					 	EdoSig <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then -- "01110"
					 
					 	EdoSig <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then -- "01111"
					 
					 	EdoSig <= s5;
				    
					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then -- "10000" 
												
						EdoSig <= s4;
						
					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then -- "10001"

						EdoSig <= s4;
					
					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then -- "10010"
					 
					 	EdoSig <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then -- "10011"
					 
					 	EdoSig <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then -- "10100"
					 
					 	EdoSig <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then -- "10101"
					 
					 	EdoSig <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then -- "10110"
					 
					 	EdoSig <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then -- "10111"
					 
					 	EdoSig <= s4;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then -- "11000"
					 
					 	EdoSig <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then -- "11001"
					 
					 	EdoSig <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then -- "11010"
					 
					 	EdoSig <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then -- "11011"
					 
					 	EdoSig <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then -- "11100"
					 
					 	EdoSig <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then -- "11101"
					 
					 	EdoSig <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then -- "11110"
					 
					 	EdoSig <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then -- "11111"

						EdoSig <= s5;
						
					else 
					
						EdoSig <= s0;
						
					end if;
		-- ESTADO 2
				when s2 =>
					if emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then -- "00000" 
							
						EdoSig <= s0;
						
					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then -- "00001"

						EdoSig <= s0;
					
					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then -- "00010"
					 
					 	EdoSig <= s0;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then -- "00011"
					 
					 	EdoSig <= s0;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then -- "00100"
					 
					 	EdoSig <= s2;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then -- "00101"
					 
					 	EdoSig <= s3;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then -- "00110"
					 
					 	EdoSig <= s2;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then -- "00111"
					 
					 	EdoSig <= s3;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then -- "01000"
					 
					 	EdoSig <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then -- "01001"
					 
					 	EdoSig <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then -- "01010"
					 
					 	EdoSig <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then -- "01011"
					 
					 	EdoSig <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then -- "01100"
					 
					 	EdoSig <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then -- "01101"
					 
					 	EdoSig <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then -- "01110"
					 
					 	EdoSig <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then -- "01111"
					 
					 	EdoSig <= s5;
				    
					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then -- "10000" 
							
						EdoSig <= s4;
						
					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then -- "10001"

						EdoSig <= s4;
					
					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then -- "10010"
					 
					 	EdoSig <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then -- "10011"
					 
					 	EdoSig <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then -- "10100"
					 
					 	EdoSig <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then -- "10101"
					 
					 	EdoSig <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then -- "10110"
					 
					 	EdoSig <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then -- "10111"
					 
					 	EdoSig <= s4;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then -- "11000"
					 
					 	EdoSig <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then -- "11001"
					 
					 	EdoSig <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then -- "11010"
					 
					 	EdoSig <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then -- "11011"
					 
					 	EdoSig <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then -- "11100"
					 
					 	EdoSig <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then -- "11101"
					 
					 	EdoSig <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then -- "11110"
					 
					 	EdoSig <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then -- "11111"
					
						EdoSig <= s5;
						
					else 
					
						EdoSig <= s0;
					
					
					end if;
		-- ESTADO 3
				when s3 =>
					if emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then -- "00000" 
							
						EdoSig <= s0;
						
					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then -- "00001"

						EdoSig <= s0;
					
					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then -- "00010"
					 
					 	EdoSig <= s0;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then -- "00011"
					 
					 	EdoSig <= s0;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then -- "00100"
					 
					 	EdoSig <= s3;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then -- "00101"
					 
					 	EdoSig <= s3;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then -- "00110"
					 
					 	EdoSig <= s3;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then -- "00111"
					 
					 	EdoSig <= s3;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then -- "01000"
					 
					 	EdoSig <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then -- "01001"
					 
					 	EdoSig <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then -- "01010"
					 
					 	EdoSig <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then -- "01011"
					 
					 	EdoSig <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then -- "01100"
					 
					 	EdoSig <= s3;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then -- "01101"
					 
					 	EdoSig <= s3;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then -- "01110"
					 
					 	EdoSig <= s3;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then -- "01111"
					 
					 	EdoSig <= s3;
				    
					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then -- "10000" 
							
						EdoSig <= s4;
						
					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then -- "10001"

						EdoSig <= s4;
					
					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then -- "10010"
					 
					 	EdoSig <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then -- "10011"
					 
					 	EdoSig <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then -- "10100"
					 
					 	EdoSig <= s3;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then -- "10101"
					 
					 	EdoSig <= s3;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then -- "10110"
					 
					 	EdoSig <= s3;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then -- "10111"
					 
					 	EdoSig <= s3;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then -- "11000"
					 
					 	EdoSig <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then -- "11001"
					 
					 	EdoSig <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then -- "11010"
					 
					 	EdoSig <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then -- "11011"
					 
					 	EdoSig <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then -- "11100"
					 
					 	EdoSig <= s3;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then -- "11101"
					 
					 	EdoSig <= s3;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then -- "11110"
					 
					 	EdoSig <= s3;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then -- "11111"
					
						EdoSig <= s3;
					
					else 
					
						EdoSig <= s0;
					
					end if;
		-- ESTADO 4
				when s4 =>
					if emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then -- "00000" 
							
						EdoSig <= s0;
						
					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then -- "00000"

						EdoSig <= s0;
					
					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then -- "00000"
					 
					 	EdoSig <= s0;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then -- "00000"
					 
					 	EdoSig <= s0;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then -- "00000"
					 
					 	EdoSig <= s0;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then -- "00000"
					 
					 	EdoSig <= s0;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then -- "00000"
					 
					 	EdoSig <= s0;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then -- "00000"
					 
					 	EdoSig <= s0;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then -- "00000"
					 
					 	EdoSig <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then -- "00000"
					 
					 	EdoSig <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then -- "00000"
					 
					 	EdoSig <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then -- "00000"
					 
					 	EdoSig <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then -- "00000"
					 
					 	EdoSig <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then -- "00000"
					 
					 	EdoSig <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then -- "00000"
					 
					 	EdoSig <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then -- "00000"
					 
					 	EdoSig <= s5;
				    
					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then -- "00000"
							
						EdoSig <= s4;
						
					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then -- "00000"

						EdoSig <= s4;
					
					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then -- "00000"
					 
					 	EdoSig <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then -- "00000"
					 
					 	EdoSig <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then -- "00000"
					 
					 	EdoSig <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then -- "00000"
					 
					 	EdoSig <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then -- "00000"
					 
					 	EdoSig <= s4;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then -- "00000"
					 
					 	EdoSig <= s4;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then -- "00000"
					 
					 	EdoSig <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then -- "00000"
					 
					 	EdoSig <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then -- "00000"
					 
					 	EdoSig <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then -- "00000"
					 
					 	EdoSig <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then -- "00000"
					 
					 	EdoSig <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then -- "00000"
					 
					 	EdoSig <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then -- "00000"
					 
					 	EdoSig <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then -- "00000"
					
						EdoSig <= s5;
					
					else 
					
						EdoSig <= s0;
					
					end if;
		-- ESTADO 5
				when s5 =>
					if emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then -- "00000" 
							
						EdoSig <= s0;
						
					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then -- "00000"

						EdoSig <= s0;
					
					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then -- "00000"
					 
					 	EdoSig <= s0;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then -- "00000"
					 
					 	EdoSig <= s0;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then -- "00000"
					 
					 	EdoSig <= s0;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then -- "00000"
					 
					 	EdoSig <= s0;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then -- "00000"
					 
					 	EdoSig <= s0;

					elsif emergencia = '0' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then -- "00000"
					 
					 	EdoSig <= s1;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then -- "00000"
					 
					 	EdoSig <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then -- "00000"
					 
					 	EdoSig <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then -- "00000"
					 
					 	EdoSig <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then -- "00000"
					 
					 	EdoSig <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then -- "00000"
					 
					 	EdoSig <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then -- "00000"
					 
					 	EdoSig <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then -- "00000"
					 
					 	EdoSig <= s5;

					elsif emergencia='0' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then -- "00000"
					 
					 	EdoSig <= s5;
				    
					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then -- "00000"
							
						EdoSig <= s0;
						
					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then -- "00000"

						EdoSig <= s0;
					
					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then -- "00000"
					 
					 	EdoSig <= s0;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then -- "00000"
					 
					 	EdoSig <= s0;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then -- "00000"
					 
					 	EdoSig <= s0;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then -- "00000"
					 
					 	EdoSig <= s0;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then -- "00000"
					 
					 	EdoSig <= s0;

					elsif emergencia = '1' and
					sismo = '0' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then -- "00000"
					 
					 	EdoSig <= s0;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='0' then -- "00000"
					 
					 	EdoSig <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='0' and
					boton_confirm ='1' then -- "00000"
					 
					 	EdoSig <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='0' then -- "00000"
					 
					 	EdoSig <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='0' and
					disponible ='1' and
					boton_confirm ='1' then -- "00000"
					 
					 	EdoSig <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='0' then -- "00000"
					 
					 	EdoSig <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='0' and
					boton_confirm ='1' then -- "00000"
					 
					 	EdoSig <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='0' then -- "00000"
					 
					 	EdoSig <= s5;

					elsif emergencia='1' and
					sismo = '1' and
					pulso_entrada ='1' and
					disponible ='1' and
					boton_confirm ='1' then -- "00000" 
					
						EdoSig <= s5;
					
					else 
					
						EdoSig <= s0;
						
					end if;

				when others => 
					EdoSig <= s0;
			end case;
		end if;
	end process;

	-- Output depends solely on the current state
	process (EdoPres)
	begin
		case EdoPres is
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

--------------------------------------------------------------------------------
--
--   FileName:         vga.vhd
--   Design Software:  Quartus II 64-bit Version 13.1 Build 162 SJ Full Version
--   Descripción:		  Modulo que controla una salida a un monitor VGA 640 x 480 
--	  Version:			  1.0
--------------------------------------------------------------------------------

library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga is 
	--Constantes para monitor VGA en 640x480
	GENERIC( 
		h_pulse 	: INTEGER := 96;
		h_bp 		: INTEGER := 48;
		h_pixels : INTEGER := 640;
		h_fp 		: INTEGER := 16;
		v_pulse 	: INTEGER := 2;
		v_bp 		: INTEGER := 33;
		v_pixels : INTEGER := 480;
		v_fp 		: INTEGER := 10
	);
	Port (
		clk50Mhz: in std_logic;
		column		: out INTEGER RANGE 0 TO (h_pulse + h_bp + h_pixels + h_fp) - 1 := 0;
		row			: out INTEGER RANGE 0 TO (v_pulse + v_bp + v_pixels + v_fp) - 1 := 0;
		display_ena: out STD_LOGIC; 
		h_sync: out std_logic;
		v_sync: out std_logic);
end entity vga;


architecture behavorial of vga is
		
	
	--Contadores
	
	constant h_period : INTEGER := h_pulse + h_bp + h_pixels + h_fp;
	constant v_period : INTEGER := v_pulse + v_bp + v_pixels + v_fp;
	signal h_count 	: INTEGER RANGE 0 TO h_period - 1 := 0; --cuenta horizontal
	signal v_count 	: INTEGER RANGE 0 TO v_period - 1 := 0; --cuenta vertical
	

	signal reloj_pixel: STD_LOGIC:='0'; 

	
	begin 
	
	--Divisor de frecuencia del sistema Adaptador de Video VGA
	relojpixel: process (clk50Mhz) is 
	begin 
		if rising_edge(clk50Mhz) then 
			reloj_pixel <= not reloj_pixel; --25 MHz
		end if;
	end process relojpixel;
	
	--Contadores del sistema Adaptador de Video VGA
	contadores: process (reloj_pixel) -- H_periodo=800, v_periodo=525
	begin
		if rising_edge (reloj_pixel) then
			if h_count <(h_period - 1) then
				h_count <= h_count + 1;
			else
				h_count<=0;
				if v_count<(v_period-1) then
					v_count<=v_count +1;
				else
					v_count<=0;
				end if;
			end if;
		end if;
	end process contadores; 

	senial_hsync : process (reloj_pixel) --h_pixel+h_fp+h_pulse= 784
	begin
		if rising_edge (reloj_pixel) then
			if h_count <(h_pixels + h_fp) or
				h_count >(h_pixels + h_fp + h_pulse) then
					h_sync <= '0';
			else
				h_sync<='1';
			end if;
		end if;
	end process senial_hsync;
	
	--checar si se la parte visible es 1 o 0
	senial_vsync : process (reloj_pixel) --vpixels+v_fp+v_pulse=525
	begin											--
		if rising_edge (reloj_pixel) then
			if v_count < (v_pixels + v_fp) or
				v_count >(v_pixels + v_fp + v_pulse) then
				v_sync <= '0';
			else
				v_sync <= '1';
			end if;
		end if;
	end process senial_vsync;
	
	--asignar una coordenada en parte visible
	coords_pixel: process (reloj_pixel)
	begin											
		if rising_edge (reloj_pixel) then
			if (h_count < h_pixels) then
				column <= h_count;
				end if;
			if (v_count < v_pixels) then
				row <= v_count;
			end if;
		end if;
	end process coords_pixel;
	

	--Proceso habilitador de visualización
	display_enable: process(reloj_pixel)	-- h_pixels=640; y_pixeles=480
	begin
		if rising_edge(reloj_pixel) then
			if (h_count < h_pixels AND v_count < v_pixels) THEN
				display_ena <= '1';
			else
				display_ena <= '0';
			end if;
		end if;
	end process display_enable;
	
end behavorial;

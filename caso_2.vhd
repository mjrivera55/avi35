library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity caso_2 is 
Port (
        clk          : in  STD_LOGIC;
        reset        : in  STD_LOGIC;
        tic          : in  STD_LOGIC;
        person       : in  STD_LOGIC;
		  en_exceso    : in std_LOGIC;
		  led_alarma   : out STD_LOGIC;
		  tiempo_extra: out integer range 0 to 99
		  );
end caso_2;

architecture demas of caso_2 is
	
	signal plust : integer range 0 to 99 :=0;
	
	begin
		process (clk,reset)
		begin
		
		if reset = '0' then
            plust   <= 0;
				
		elsif rising_edge(clk) then
		
            -- La persona sigue ocupando el espacio
            -- después de los 35 segundos		
		
         if person = '1' and en_exceso = '1' then
                if tic = '1' then
					     if plust < 99 then
                    plust <= plust + 1;
                end if;
				end if;
		   -- Si no está en exceso,
         -- preparar contador para la próxima vez
            else
                plust <= 0; 
            end if;
        end if;
    end process;
	 
 -- Alarma mientras la persona siga después de los 35 s
	 led_alarma <= '1' when (person = '1' and en_exceso = '1') else '0';
    tiempo_extra <= plust;

end demas;
            
					 
		
					 
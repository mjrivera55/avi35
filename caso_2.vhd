library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity caso_2 is 
Port (
        clk          : in  STD_LOGIC;
        reset        : in  STD_LOGIC;
        tic          : in  STD_LOGIC;
        person       : in  STD_LOGIC;
		  led_alarma   : out STD_LOGIC;
		  fact_t 		: out STD_LOGIC;
        en_exceso    : out STD_LOGIC );
end caso_2;

architecture demas of caso_2 is
	signal plust : integer range 0 to 35 :=0;
	
	begin
		process
		begin
		if reset = '1' then
            plust      <= 0;
		elsif rising_edge(clk) then
         if person = '1' and en_exceso = '1' then
                if tic = '1' then
                    plust <= plust + 1;
                end if;
            else
                plust <= 0; 
            end if;
        end if;
    end process;
	 
    

end demas;
            
					 
		
					 
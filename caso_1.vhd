library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity caso_1 is 
Port (
        clk          : in  STD_LOGIC;
        reset        : in  STD_LOGIC;
        person       : in  STD_LOGIC;
		  tic 			: in std_logic;
        felicitacion : out STD_LOGIC;
        en_exceso    : out std_LOGIC;
		  conteo: out integer range 0 to 35 
		 );
end entity;

architecture descrip of caso_1 is 
 
 signal momento : integer range 0 to 35 :=0;
 
 begin
 
   process(clk,reset)
	begin 
	
		if reset = '1' then
            momento      <= 0;
            felicitacion <= '0';
            en_exceso    <= '0';
				
        elsif rising_edge(clk) then
-- Persona ocupando el espacio  
            if person = '1' then
                felicitacion <= '0';
 -- Contador de segundos
		if tic='1' then
		
			if momento <35 then 
					momento <= momento +1;
			end if;
		end if;
		
-- Cuando llega a 35 segundos

	if momento >= 34 then
        en_exceso <= '1';
              else
						en_exceso <= '0';
                end if;

     -- Espacio libre
            else

     -- Si salió antes de los 35 segundos
                if momento > 0 and momento < 35 then

                    felicitacion <= '1';

                else

                    felicitacion <= '0';

                end if;

                -- Reiniciar para la siguiente persona
                momento   <= 0;
                en_exceso <= '0';

            end if;

        end if;

    end process;

  conteo <= momento;

end descrip;
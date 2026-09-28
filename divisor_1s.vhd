library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity divisor_1s is
    Port (
        clk     : in  std_logic;
		  reset     : in  STD_LOGIC;
        tic : out std_logic
    );
end divisor_1s;

-- divisor de 50Mhz

architecture tiempo of divisor_1s is 
    constant TOPE : integer := 49999999;  ---el tiempo a dividir 
    signal tiempo : integer range 0 to TOPE := 0;
 
 begin
	
	process(clk,reset)
	begin
	
	if reset='1' then 
		tiempo <= 0;
		tic <='0';
	
	elsif rising_edge(clk) then
	
	-- aqui es donde al contarse en el reloj los 50Mhz se cuenta un tic "un tipo enable para el tiempo"
	
		if tiempo= TOPE then
		
			tiempo<=0;
			tic <='1';
	 
		else 
		
			tiempo <= tiempo+1;
			tic <='0';
			
		end if;
		
	  end if; 

  end process;

end tiempo;
	 
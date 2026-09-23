library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity divisor_1s is
    Port (
        clk     : in  std_logic;
        tic : out bit
    );
end divisor_1s;

architecture tiempo of divisor_1s is 
 signal tiempo: integer range 0 to 49999999 :=0;
 
 begin
	
	process(clk)
	begin
	if rising_edge(clk) then
	
		if tiempo= 49999999 then
		tiempo<=0;
		tic <='1';
	 
		else 
		tiempo <= tiempo+1;
		tic <='0';
	 end if;
end if; 


        
end process;

end tiempo;
	 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity caso_1 is 
Port (	
	tic	: in std_logic; 
	person: in bit;
	limit: out bit;
	felicidades: out bit;
	
);

end caso_normal;

 architecture descrip of caso_1 is 
 
 signal momento : integer range 0 to 35 :=0;
 
 begin
   process(tic, person)
	begin 
 
 if rising_edge(tic) then 
 
  if person='1' then 
  
	if momento <35 then 
	momento <= momento +1;
	end if;
	
   
	

  
	


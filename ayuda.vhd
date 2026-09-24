library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



package ayuda is 
   
	component BCD_7SEG is
	port(A: in STD_LOGIC_VECTOR(3 downto 0);
		  B: out STD_LOGIC_VECTOR(6 downto 0));
end component;

  component divisor_1s is
	Port (
        clk     : in  std_logic;
		  reset     : in  STD_LOGIC;
        tic : out std_LOGIC
    );
	end component;
	
	component caso_1 is
	Port (
        clk          : in  STD_LOGIC;
        reset        : in  STD_LOGIC;
        tic          : in  STD_LOGIC;
        person       : in  STD_LOGIC;
        felicitacion : out STD_LOGIC;
        en_exceso    : out integer range 0 to 99
		  );
end component;


	component caso_2 is
	Port (
        clk          : in  STD_LOGIC;
        reset        : in  STD_LOGIC;
        tic          : in  STD_LOGIC;
        person       : in  STD_LOGIC;
		  led_alarma   : out STD_LOGIC;
		  en_exceso    : out integer range 0 to 99
		  );
end component;

end package;

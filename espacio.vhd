library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work; 
use work.ayuda.all;

entity espacio is 
Port (
        clk          : in  STD_LOGIC;
        reset        : in  STD_LOGIC;
        person       : in  STD_LOGIC;
		  led_alarma   : out STD_LOGIC;
		  fact_t 		: out integer range 0 to 35;
        felicitacion : out STD_LOGIC;
		  dis_dec : out std_logic_vector (6 downto 0);
		  dis_uni : out std_logic_vector (6 downto 0));
end espacio;

architecture top of espacio is

------prueba
    signal wire_en_exceso : integer range 0 to 99; -- Avisa a U2 cuando el Caso 1 llega a los 35s
    signal wire_tic: std_LOGIC;
begin

    -- Instancia 0: Divisor de frecuencia
    U0_Divisor: divisor_1s
        port map (
            clk => clk,
            reset     => reset,
            tic   => wire_tic       -- Guarda el pulso de 1s en el cable interno
        );

    -- Instancia 1: Caso 1 (Evaluación < 35s)
    U1_Caso1: caso_1
        port map (
            clk          => clk,
            reset        => reset,
            tic          => wire_tic,    -- Recibe la base de tiempo de U0
            person       => person,
            felicitacion => felicitacion,
            en_exceso    => wire_en_exceso -- Pone en '1' si sobrepasa los 35s
        );

    -- Instancia 2: Caso 2 (Alarma y Contador de cobro)
    U2_Caso2: caso_2
        port map (
            clk   => clk,
            reset         => reset,
            -- Recibe la base de tiempo de U0
            person        => person,
				tic => wire_tic,
            en_exceso     => wire_en_exceso, -- Se activa si U1 detecta los 35s
            led_alarma    => led_alarma
        );
 end top;
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
		  fact_t 		: out integer range 0 to 99;
        felicitacion : out STD_LOGIC;
		  dis_dec : out std_logic_vector (6 downto 0);
		  dis_uni : out std_logic_vector (6 downto 0));
end espacio;

architecture top of espacio is

------prueba
    signal wire_en_exceso : std_logic; -- Indica que ya se cumplieron los 35 segundos
    signal wire_tic: std_LOGIC; -- Señal de 1 segundo
	 signal wire_conteo : integer range 0 to 35; -- Conteo de los primeros 35 segundos
	 signal wire_tiempo_extra : integer range 0 to 99; -- Tiempo adicional
	 
	 signal decenas  : integer range 0 to 9;
    signal unidades : integer range 0 to 9;
	 
	 signal bcd_dec : STD_LOGIC_VECTOR(3 downto 0);
    signal bcd_uni : STD_LOGIC_VECTOR(3 downto 0);
begin

    ----------------------------------------------------------------
    -- DIVISOR DE FRECUENCIA
    ----------------------------------------------------------------
    U0_Divisor: divisor_1s
        port map (
            clk => clk,
            reset => reset,
            tic   => wire_tic       -- Guarda el pulso de 1s en el cable interno
        );

    ----------------------------------------------------------------
    -- CASO 1
    -- Cuenta los primeros 35 segundos
    ----------------------------------------------------------------

    U1_Caso1: caso_1
        port map (
            clk          => clk,
            reset        => reset,
            tic          => wire_tic,    -- Recibe la base de tiempo de U0
            person       => person,
            felicitacion => felicitacion,
            en_exceso    => wire_en_exceso, -- Pone en '1' si sobrepasa los 35s
				conteo       => wire_conteo
        );

    ----------------------------------------------------------------
    -- CASO 2
    -- Cuenta el tiempo adicional
    ----------------------------------------------------------------

    U2_Caso2: caso_2
        port map (
            clk   		  => clk,
            reset         => reset,
            person        => person,
				tic           => wire_tic,
            en_exceso     => wire_en_exceso, -- Se activa si U1 detecta los 35s
            led_alarma    => led_alarma,
				tiempo_extra  => wire_tiempo_extra
        );
		  
fact_t <= wire_tiempo_extra;

--- parte echa con ia para BCD- fpga

    ----------------------------------------------------
    -- SEPARAR DECENAS Y UNIDADES
    ----------------------------------------------------

    decenas  <= wire_tiempo_extra / 10;
    unidades <= wire_tiempo_extra mod 10;


    ----------------------------------------------------
    -- CONVERSIÓN A TU BCD INVERTIDO
    ----------------------------------------------------

    process(decenas, unidades)
    begin

        case decenas is
            when 0 => bcd_dec <= "1111";
            when 1 => bcd_dec <= "1110";
            when 2 => bcd_dec <= "1101";
            when 3 => bcd_dec <= "1100";
            when 4 => bcd_dec <= "1011";
            when 5 => bcd_dec <= "1010";
            when 6 => bcd_dec <= "1001";
            when 7 => bcd_dec <= "1000";
            when 8 => bcd_dec <= "0111";
            when 9 => bcd_dec <= "0110";
            when others => bcd_dec <= "1111";
        end case;


        case unidades is
            when 0 => bcd_uni <= "1111";
            when 1 => bcd_uni <= "1110";
            when 2 => bcd_uni <= "1101";
            when 3 => bcd_uni <= "1100";
            when 4 => bcd_uni <= "1011";
            when 5 => bcd_uni <= "1010";
            when 6 => bcd_uni <= "1001";
            when 7 => bcd_uni <= "1000";
            when 8 => bcd_uni <= "0111";
            when 9 => bcd_uni <= "0110";
            when others => bcd_uni <= "1111";
        end case;

    end process;


    ----------------------------------------------------
    -- DISPLAY DE DECENAS
    ----------------------------------------------------

    U3_BCD_DEC : BCD_7SEG
        port map (
            A => bcd_dec,
            B => dis_dec
        );


    ----------------------------------------------------
    -- DISPLAY DE UNIDADES
    ----------------------------------------------------

    U4_BCD_UNI : BCD_7SEG
        port map (
            A => bcd_uni,
            B => dis_uni
        );


 end top;
 
 
 
 
 
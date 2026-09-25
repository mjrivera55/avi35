library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work; 
use work.ayuda.all;
use IEEE.NUMERIC_STD.ALL;

entity espacio is 
Port (
        clk          : in  STD_LOGIC;
        reset        : in  STD_LOGIC;
        person       : in  STD_LOGIC;
		  led_alarma   : out STD_LOGIC;
        felicitacion : out STD_LOGIC;
		  
		  dis_ini_dec : out std_logic_vector (6 downto 0);
		  dis_ini_uni : out std_logic_vector (6 downto 0);
		  
		  dis_ext_dec  : out STD_LOGIC_VECTOR(6 downto 0);
        dis_ext_uni  : out STD_LOGIC_VECTOR(6 downto 0)
		  );
end espacio;

architecture top of espacio is

------prueba
    signal wire_en_exceso : std_logic; -- Indica que ya se cumplieron los 35 segundos
    signal wire_tic: std_LOGIC; -- Señal de 1 segundo
	 signal wire_conteo : integer range 0 to 35; -- Conteo de los primeros 35 segundos
	 signal wire_tiempo_extra : integer range 0 to 99; -- Tiempo adicional
	 
    signal decenas_ini  : integer range 0 to 3;
    signal unidades_ini : integer range 0 to 9;
    signal bcd_ini_dec  : STD_LOGIC_VECTOR(3 downto 0);
    signal bcd_ini_uni  : STD_LOGIC_VECTOR(3 downto 0);
 
    -- BCD del tiempo extra (0-99: decenas 0-9, unidades 0-9)
    signal decenas_ext  : integer range 0 to 9;
    signal unidades_ext : integer range 0 to 9;
    signal bcd_ext_dec  : STD_LOGIC_VECTOR(3 downto 0);
    signal bcd_ext_uni  : STD_LOGIC_VECTOR(3 downto 0);
	 
	
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

--- parte echa con ia para BCD- fpga
    ----------------------------------------------------------------
    -- SEPARAR DECENAS Y UNIDADES DEL CONTEO INICIAL (0-35, flujo de datos)
    ----------------------------------------------------------------
    decenas_ini  <= wire_conteo / 10;
    unidades_ini <= wire_conteo mod 10;
 
    bcd_ini_dec <= std_logic_vector(to_unsigned(decenas_ini, 4));
    bcd_ini_uni <= std_logic_vector(to_unsigned(unidades_ini, 4));
 
    ----------------------------------------------------------------
    -- SEPARAR DECENAS Y UNIDADES DEL TIEMPO EXTRA (0-99, flujo de datos)
    ----------------------------------------------------------------
    decenas_ext  <= wire_tiempo_extra / 10;
    unidades_ext <= wire_tiempo_extra mod 10;
 
    bcd_ext_dec <= std_logic_vector(to_unsigned(decenas_ext, 4));
    bcd_ext_uni <= std_logic_vector(to_unsigned(unidades_ext, 4));
 
    ----------------------------------------------------------------
    -- DISPLAYS: CONTEO INICIAL (0-35 s)
    ----------------------------------------------------------------
    U3_BCD_INI_DEC : BCD_7SEG
        port map (
            A => bcd_ini_dec,
            B => dis_ini_dec
        );
 
    U4_BCD_INI_UNI : BCD_7SEG
        port map (
            A => bcd_ini_uni,
            B => dis_ini_uni
        );
    ----------------------------------------------------------------
    -- DISPLAYS: TIEMPO EXTRA DE FACTURACION (0-99 s)
    ----------------------------------------------------------------
    U5_BCD_EXT_DEC : BCD_7SEG
        port map (
            A => bcd_ext_dec,
            B => dis_ext_dec
        );
 
    U6_BCD_EXT_UNI : BCD_7SEG
        port map (
            A => bcd_ext_uni,
            B => dis_ext_uni
        );
		  
 end top;
 
 
 
 
 
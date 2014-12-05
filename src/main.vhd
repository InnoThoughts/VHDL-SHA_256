----------------------------------------------------------------------------------
-- Nate Graff and Kenan Pretzer
-- Module Name: main - Structural
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
    Port (              CLK : in STD_LOGIC;
                        BTN : in STD_LOGIC;
                -- KEYBOARD
                    PS2_CLK : inout STD_LOGIC;
                   PS2_DATA : in STD_LOGIC;
           -- Seven Segment
                     ANODES : out STD_LOGIC_VECTOR (3 downto 0);
                   CATHODES : out STD_LOGIC_VECTOR (7 downto 0);
                   -- DEBUG
                  count_led : out STD_LOGIC_VECTOR (4 downto 0));
end main;

architecture Structural of main is

    component ps2_keyboard is
        Port (     PS2_CLK : in  STD_LOGIC;
                  PS2_DATA : in  STD_LOGIC;
               NEW_KEYCODE : out STD_LOGIC;
                   KEYCODE : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component input_module is
        Port ( NEW_KEYCODE : in  STD_LOGIC;
                   KEYCODE : in  STD_LOGIC_VECTOR (7 downto 0);
                        EN : in  STD_LOGIC;
                       CLK : in  STD_LOGIC;
                       RST : in  STD_LOGIC;
                STRING_OUT : out STD_LOGIC_VECTOR (255 downto 0);
                     COUNT_OUT : out STD_LOGIC_VECTOR (4 downto 0));    
    end component;
    
    component hex_decoder is
        Port ( HASH_IN : in  STD_LOGIC_VECTOR (255 downto 0);
               HASH_OUT : out STD_LOGIC_VECTOR (31 downto 0));
    end component;
    
    component hash_mem is
        Port ( VAL_IN : in  STD_LOGIC_VECTOR (255 downto 0);
               CLK : in  STD_LOGIC;
               EN : in  STD_LOGIC;
               VAL_OUT : out STD_LOGIC_VECTOR (255 downto 0));
    end component;
    
    component mode_fsm is
        Port (         CLK : in  STD_LOGIC;
                       RST : in  STD_LOGIC;
               NEW_KEYCODE : in  STD_LOGIC;
                   KEYCODE : in  STD_LOGIC_VECTOR (7 downto 0);
               MODE_ENABLE : out STD_LOGIC_VECTOR (1 downto 0));
    end component;
    
    component mode_demux is
     Port (  USER_INPUT : in  STD_LOGIC_VECTOR (255 downto 0);
            HASH_OUTPUT : in  STD_LOGIC_VECTOR (255 downto 0);
            MODE_ENABLE : in  STD_LOGIC_VECTOR (1   downto 0);
                LCD_OUT : out STD_LOGIC_VECTOR (255 downto 0));
    end component;

    component sseg_driver is
    Port ( DISPLAY : in  STD_LOGIC_VECTOR (31 downto 0);
           CLK : in  STD_LOGIC;
           ANODES : out  STD_LOGIC_VECTOR (3 downto 0);
           CATHODES : out  STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    signal new_keycode   : STD_LOGIC := '0';
    signal keycode       : STD_LOGIC_VECTOR (7 downto 0);
    signal keycode_error : STD_LOGIC;
    
    signal count_out : STD_LOGIC_VECTOR (4 downto 0);
    
    signal user_input : STD_LOGIC_VECTOR (255 downto 0);
    signal saved_user_input : STD_LOGIC_VECTOR (255 downto 0) := (OTHERS => '0');
    signal decoded_hex : STD_LOGIC_VECTOR (255 downto 0) := (OTHERS => '0');
    
    signal ckt_mode : STD_LOGIC_VECTOR (1 downto 0);
    
    signal dmux_out : STD_LOGIC_VECTOR (255 downto 0);

begin
          
    count_led <= count_out;
    
    keyb: ps2_keyboard port map
        ( PS2_CLK     => PS2_CLK,
          PS2_DATA    => PS2_DATA,
          NEW_KEYCODE => new_keycode,
          KEYCODE     => keycode);
    
    inmod: input_module port map
        ( NEW_KEYCODE => new_keycode,
          KEYCODE     => keycode,
          EN          => ckt_mode(0),
          CLK         => CLK,
          RST         => ckt_mode(1),
          STRING_OUT  => user_input,
          COUNT_OUT       => count_out);
          
    hmem: hash_mem port map
        ( VAL_IN => user_input,
          CLK     => CLK,
          EN      => BTN,
          VAL_OUT => saved_user_input);
          
    decode: hex_decoder port map
        ( HASH_IN => saved_user_input, -- directly from saved_user_input for now
          HASH_OUT => decoded_hex (255 downto 224));

    mfsm: mode_fsm port map
        ( CLK         => CLK,
          RST         => '0',
          NEW_KEYCODE => new_keycode,
          KEYCODE     => keycode,
          MODE_ENABLE => ckt_mode);

    mdemux: mode_demux port map
        ( USER_INPUT  => user_input,
          HASH_OUTPUT => decoded_hex,
          MODE_ENABLE => ckt_mode,
          LCD_OUT     => dmux_out);
          
    sseg: sseg_driver port map
        (  DISPLAY => dmux_out (255 downto 224),
           CLK     => CLK,
           ANODES  => ANODES,
           CATHODES => CATHODES);

end Structural;


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
                -- KEYBOARD
                    PS2_CLK : inout STD_LOGIC;
                   PS2_DATA : in STD_LOGIC;
       PS2_CLEAR_DATA_READY : in STD_LOGIC;
                     -- LCD
                         RS : out STD_LOGIC;
                         RW : out STD_LOGIC;
                          E : out STD_LOGIC;
                   LCD_DATA : out STD_LOGIC_VECTOR (7 downto 0));
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
                STRING_OUT : out STD_LOGIC_VECTOR (255 downto 0));    
    end component;
    
    component output_module is
        Port (         CLK : in  STD_LOGIC;
                       RST : in  STD_LOGIC;
               NEW_KEYCODE : in  STD_LOGIC;
                   KEYCODE : in  STD_LOGIC_VECTOR (7 downto 0);
                   HASH_IN : in  STD_LOGIC_VECTOR (255 downto 0);
                STRING_OUT : OUT STD_LOGIC_VECTOR (255 downto 0));
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

    component lcd_driver is
    Port (     CLK : in STD_LOGIC;
           DISPLAY : in STD_LOGIC_VECTOR (255 downto 0);
         RS, RW, E : out STD_LOGIC;
          LCD_DATA : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    signal new_keycode   : STD_LOGIC;
    signal keycode       : STD_LOGIC_VECTOR (7 downto 0);
    signal keycode_error : STD_LOGIC;
    
    signal hash_in  : STD_LOGIC_VECTOR (255 downto 0);
    signal hash_out : STD_LOGIC_VECTOR (255 downto 0);
    
    signal user_input : STD_LOGIC_VECTOR (255 downto 0);
    signal ckt_output : STD_LOGIC_VECTOR (255 downto 0) := (OTHERS => '0');
    
    signal ckt_mode : STD_LOGIC_VECTOR (1 downto 0);
    
    signal dmux_out : STD_LOGIC_VECTOR (255 downto 0);

begin
          
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
          STRING_OUT  => user_input);
          
    outmod: output_module port map
        ( CLK         => CLK,
          RST         => ckt_mode(1),
          NEW_KEYCODE => new_keycode,
          KEYCODE     => keycode,
          HASH_IN     => user_input, -- directly from the user input register, include hash algorithm later
          STRING_OUT  => ckt_output);

    mfsm: mode_fsm port map
        ( CLK         => CLK,
          RST         => '0', -- add a circuit hard reset button later
          NEW_KEYCODE => new_keycode,
          KEYCODE     => keycode,
          MODE_ENABLE => ckt_mode);

    mdemux: mode_demux port map
        ( USER_INPUT  => user_input,
          HASH_OUTPUT => ckt_output,
          MODE_ENABLE => ckt_mode,
          LCD_OUT     => dmux_out);
          
    lcdd: lcd_driver port map
        ( CLK      => CLK,
          DISPLAY  => dmux_out,
		  RS       => RS,
          RW       => RW,
          E        => E,
          LCD_DATA => LCD_DATA);

end Structural;


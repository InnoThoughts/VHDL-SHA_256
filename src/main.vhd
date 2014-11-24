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
    Port (
        CLK : in STD_LOGIC;
        PS2_CLK : inout STD_LOGIC;
        PS2_DATA : in STD_LOGIC;
        PS2_CLEAR_DATA_READY : in STD_LOGIC;
        DISP_EN : out STD_LOGIC_VECTOR (3 downto 0);
        SEGMENTS: out STD_LOGIC_VECTOR (8 downto 0));
end main;

architecture Structural of main is

    component ps2_register is
        PORT ( PS2_DATA_READY,
               PS2_ERROR            : out STD_LOGIC;  
               PS2_KEY_CODE         : out STD_LOGIC_VECTOR(7 downto 0); 
               PS2_CLK              : inout STD_LOGIC;
               PS2_DATA             : in  STD_LOGIC;
               PS2_CLEAR_DATA_READY : in  STD_LOGIC);
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
        Port ( NEW_KEYCODE : in  STD_LOGIC;
                   KEYCODE : in  STD_LOGIC;
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
           MODE_ENABLE : in  STD_LOGIC_VECTOR (1 downto 0);
               LCD_OUT : out STD_LOGIC_VECTOR (255 downto 0));
    end component;

    component sseg_dec is
    Port (      ALU_VAL : in std_logic_vector(7 downto 0); 
					    SIGN : in std_logic;
						VALID : in std_logic;
                    CLK : in std_logic;
                DISP_EN : out std_logic_vector(3 downto 0);
               SEGMENTS : out std_logic_vector(7 downto 0));
    end component;
    
    signal new_keycode : std_logic;
    signal keycode : std_logic_vector (7 downto 0);
    signal keycode_error : std_logic;
    
    signal hash_in  : std_logic_vector (255 downto 0);
    signal hash_out : std_logic_vector (255 downto 0);
    
    signal user_input : std_logic_vector (255 downto 0);
    signal ckt_output : std_logic_vector (255 downto 0);
    
    signal ckt_mode : std_logic_vector (1 downto 0);
    
    signal dmux_out : std_logic_vector (255 downto 0);

begin

    keyboard: ps2_register port map
        ( PS2_CLK => PS2_CLK,
          PS2_DATA => PS2_DATA,
          PS2_CLEAR_DATA_READY => PS2_CLEAR_DATA_READY,
          PS2_DATA_READY => new_keycode,
          PS2_KEYCODE => keycode,
          PS2_ERROR => keycode_error);
    
    input_module: input_module port map
        ( NEW_KEYCODE => new_keycode,
          KEYCODE => keycode,
          EN => ckt_mode(1),
          CLK => CLK,
          RST => ckt_mode(0),
          STRING_OUT => user_input);
          
    output_module: output_module port map
        ( NEW_KEYCODE => new_keycode,
          KEYCODE => keycode,
          HASH_IN => user_input, -- directly from the user input register, include hash algorithm later
          STRING_OUT => ckt_output);

    mode_fsm: mode_fsm port map
        ( CLK => CLK,
          RST => '0', -- add a circuit hard reset button later
          NEW_KEYCODE => new_keycode,
          KEYCODE => new_keycode,
          MODE_ENABLE => ckt_mode);

    mode_demux: mode_demux port map
        ( USER_INPUT => user_input,
          HASH_OUTPUT => ckt_output,
          MODE_ENABLE => mode_enable,
          LCD_OUT => dmux_out);
          
    sseg_dec: sseg_dec port map
        ( ALU_VAL => dmux_out (255 downto 248),
		  SIGN => '0',
		  VALID => '1',
          CLK => CLK,
          DISP_EN => DISP_EN,
          SEGMENTS => SEGMENTS);

end Structural;


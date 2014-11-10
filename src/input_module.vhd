----------------------------------------------------------------------------------
-- Nate Graff and Kenan Pretzer
-- Module Name:    input_module - input_module_architecture
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

entity input_module is
    Port ( NEW_KEYCODE : in  STD_LOGIC;
               KEYCODE : in  STD_LOGIC_VECTOR (7 downto 0);
                    EN : in  STD_LOGIC;
                   CLK : in  STD_LOGIC;
                   RST : in  STD_LOGIC;
            STRING_OUT : out STD_LOGIC_VECTOR (255 downto 0));
end input_module;

architecture input_module_architecture of input_module is

    component counter_5b is
        Port ( INCREMENT : in  STD_LOGIC;
                     RST : in  STD_LOGIC;
                   COUNT : out STD_LOGIC_VECTOR (4 downto 0));
    end component;
    
    component mux_5to32 is
        Port (  SEL : in  STD_LOGIC_VECTOR (4 downto 0);
               CHAR : out STD_LOGIC_VECTOR (31 downto 0));
    end component;
    
    component memory_array is
        Port ( CHAR_IN : in  STD_LOGIC_VECTOR (7 downto 0);
                   SEL : in  STD_LOGIC_VECTOR (31 downto 0);
                   CLK : in  STD_LOGIC;
                OUTPUT : out STD_LOGIC_VECTOR (255 downto 0));
    end component;
    
    signal count_s   : STD_LOGIC_VECTOR (4 downto 0) := "0000";
    signal mem_sel_s : STD_LOGIC_VECTOR (31 downto 0);

begin

    count: counter_5b port map
        ( INCREMENT => NEW_KEYCODE,
          RST => '0',
          COUNT => count_s);

    mux: mux_5to32 port map
        ( SEL  => count_s,
          CHAR => mem_sel_s);

    memory: memory_array port map
        ( CHAR_IN => KEYCODE,
          SEL     => mem_sel_s,
          CLK     => CLK,
          OUTPUT  => STRING_OUT);

end input_module_architecture;


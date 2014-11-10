----------------------------------------------------------------------------------
-- Nate Graff and Kenan Pretzer
-- Module Name: line_register - Structural
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

entity line_register is
    Port ( CHAR_IN : in  STD_LOGIC_VECTOR (7 downto 0);
               SEL : in  STD_LOGIC_VECTOR (15 downto 0);
               CLK : in  STD_LOGIC;
            OUTPUT : out STD_LOGIC_VECTOR (127 downto 0));
end line_register;

architecture Structural of line_register is

    component word_register is
        Port ( CHAR_IN : in  STD_LOGIC_VECTOR (7 downto 0);
                   SEL : in  STD_LOGIC_VECTOR (3 downto 0);
                   CLK : in  STD_LOGIC;
                OUTPUT : out STD_LOGIC_VECTOR (31 downto 0));
    end component;

begin

    word_0: word_register port map
        ( CHAR_IN => CHAR_IN,
          SEL     => SEL (15 downto 12),
          CLK     => CLK,
          OUTPUT  => OUTPUT (127 downto 96));
        
    word_1: word_register port map
        ( CHAR_IN => CHAR_IN,
          SEL     => SEL (11 downto 8),
          CLK     => CLK,
          OUTPUT  => OUTPUT (95 downto 64));
    
    word_2: word_register port map
        ( CHAR_IN => CHAR_IN,
          SEL     => SEL (7 downto 4),
          CLK     => CLK,
          OUTPUT  => OUTPUT (63 downto 32));
    
    word_3: word_register port map
        ( CHAR_IN => CHAR_IN,
          SEL     => SEL (3 downto 0),
          CLK     => CLK,
          OUTPUT  => OUTPUT (31 downto 0));
    

end Structural;


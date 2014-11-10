----------------------------------------------------------------------------------
-- Nate Graff and Kenan Pretzer
-- Module Name: word_register - Structural
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

entity word_register is
    Port ( CHAR_IN : in  STD_LOGIC_VECTOR (7 downto 0);
               SEL : in  STD_LOGIC_VECTOR (3 downto 0);
               CLK : in  STD_LOGIC;
            OUTPUT : out STD_LOGIC_VECTOR (31 downto 0));
end word_register;

architecture Structural of word_register is

    component char_register is
        Port (        D : in  STD_LOGIC_VECTOR (7 downto 0);
                     EN : in  STD_LOGIC;
                    CLK : in  STD_LOGIC;
               CHAR_OUT : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

begin

    char_0: char_register port map
        ( D        => CHAR_IN,
          EN       => SEL(3),
          CLK      => CLK,
          CHAR_OUT => OUTPUT(31 downto 24));
    
    char_1: char_register port map
        ( D        => CHAR_IN,
          EN       => SEL(2),
          CLK      => CLK,
          CHAR_OUT => OUTPUT(23 downto 16));
    
    char_2: char_register port map
        ( D        => CHAR_IN,
          EN       => SEL(1),
          CLK      => CLK,
          CHAR_OUT => OUTPUT(15 downto 8));
    
    char_3: char_register port map
        ( D        => CHAR_IN,
          EN       => SEL(0),
          CLK      => CLK,
          CHAR_OUT => OUTPUT(7 downto 0));

end Structural;


----------------------------------------------------------------------------------
-- Nate Graff and Kenan Pretzer
-- Module Name: memory_array - Structural
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

entity memory_array is
    Port ( CHAR_IN : in  STD_LOGIC_VECTOR (7 downto 0);
               SEL : in  STD_LOGIC_VECTOR (31 downto 0);
               CLK : in  STD_LOGIC;
            OUTPUT : out STD_LOGIC_VECTOR (255 downto 0));
end memory_array;

architecture Structural of memory_array is

    component line_register is
        Port ( CHAR_IN : in  STD_LOGIC_VECTOR (7 downto 0);
                   SEL : in  STD_LOGIC_VECTOR (15 downto 0);
                   CLK : in  STD_LOGIC;
                OUTPUT : out STD_LOGIC_VECTOR (127 downto 0));
    end component;

begin

    line_0: line_register port map (
        CHAR_IN => CHAR_IN,
        SEL     => SEL (31 downto 16),
        CLK     => CLK,
        OUTPUT  => OUTPUT (255 downto 128));
    
    line_1: line_register port map (
        CHAR_IN => CHAR_IN,
        SEL     => SEL (15 downto 0),
        CLK     => CLK,
        OUTPUT  => OUTPUT (127 downto 0));

end Structural;


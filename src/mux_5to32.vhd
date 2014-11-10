----------------------------------------------------------------------------------
-- Nate Graff and Kenan Pretzer
-- Module Name:    mux_5to32 - Behavioral
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux_5to32 is
    Port (  SEL : in  STD_LOGIC_VECTOR (4 downto 0);
           CHAR : out STD_LOGIC_VECTOR (31 downto 0));
end mux_5to32;

architecture Behavioral of mux_5to32 is

begin

    mux: process(SEL) is
        variable char_num : integer;
    begin
        char_num := integer(to_unsigned(SEL));
        
        CHAR <= (others => '0');
        CHAR(char_num) <= '1';
    
    end process mux;

end Behavioral;


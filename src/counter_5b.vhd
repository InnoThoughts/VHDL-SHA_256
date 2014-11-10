----------------------------------------------------------------------------------
-- Nate Graff and Kenan Pretzer
-- Module Name:    counter_5b - Behavioral
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

entity counter_5b is
    Port ( INCREMENT : in  STD_LOGIC;
                 RST : in  STD_LOGIC;
               COUNT : out STD_LOGIC_VECTOR (4 downto 0));
end counter_5b;

architecture Behavioral of counter_5b is

begin

    counter: process(INCREMENT, RST)
        variable count_v : integer := 0;
    begin
        if(rising_edge(INCREMENT) and (count_v < 31)) then
            count_v := count_v + 1;
        end if;
        
        if(RST) then
            count_v := 0;
        end if;
        
        COUNT <= STD_LOGIC_VECTOR(to_unsigned(count_v));
        
    end process counter;

end Behavioral;


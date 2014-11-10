----------------------------------------------------------------------------------
-- Nate Graff and Kenan Pretzer
-- Module Name: char_register - Behavioral
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

entity char_register is
    Port (        D : in  STD_LOGIC_VECTOR (7 downto 0);
                 EN : in  STD_LOGIC;
                CLK : in  STD_LOGIC;
           CHAR_OUT : out  STD_LOGIC_VECTOR (7 downto 0));
end char_register;

architecture Behavioral of char_register is

begin

    flop: process(D, EN, CLK) is
        variable D_v : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    begin
        if(rising_edge(CLK) and EN = '1') then
            D_v <= D;
        end if;
        CHAR_OUT <= D_v;
    end process flop;

end Behavioral;


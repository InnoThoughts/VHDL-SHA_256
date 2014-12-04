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
                RST : in  STD_LOGIC;
           CHAR_OUT : out  STD_LOGIC_VECTOR (7 downto 0));
end char_register;

architecture Behavioral of char_register is

begin

    flop: process(D, EN, CLK, RST) is
        variable D_v : STD_LOGIC_VECTOR (7 downto 0) := "00010000";
    begin
        if(rising_edge(CLK) and EN = '1') then
            case D is
                when x"1C" => D_v := "01000001"; -- A
                when x"32" => D_v := "01000010"; -- B
                when x"21" => D_v := "01000011"; -- C
                when x"23" => D_v := "01000100"; -- D
                when x"24" => D_v := "01000101"; -- E
                when x"2B" => D_v := "01000110"; -- F
                when x"34" => D_v := "01000111"; -- G
                when x"33" => D_v := "01001000"; -- H
                when x"43" => D_v := "01001001"; -- I
                when x"3B" => D_v := "01001010"; -- J
                when x"42" => D_v := "01001011"; -- K
                when x"4B" => D_v := "01001100"; -- L
                when x"3A" => D_v := "01001101"; -- M
                when x"31" => D_v := "01001110"; -- N
                when x"44" => D_v := "01001111"; -- O
                when x"4D" => D_v := "01010000"; -- P
                when x"15" => D_v := "01010001"; -- Q
                when x"2D" => D_v := "01010010"; -- R
                when x"1B" => D_v := "01010011"; -- S
                when x"2C" => D_v := "01010100"; -- T
                when x"3C" => D_v := "01010101"; -- U
                when x"2A" => D_v := "01010110"; -- V
                when x"1D" => D_v := "01010111"; -- W
                when x"22" => D_v := "01011000"; -- X
                when x"35" => D_v := "01011001"; -- Y
                when x"1A" => D_v := "01011010"; -- Z
                when others => D_v := "00010000"; -- blank
            end case;
        end if;
        if(RST = '1') then
            D_v := "00010000";
        end if;
        CHAR_OUT <= D_v;
    end process flop;

end Behavioral;


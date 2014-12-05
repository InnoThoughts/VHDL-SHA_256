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
        variable D_v : STD_LOGIC_VECTOR (7 downto 0) := "11111111";
    begin
        if(rising_edge(CLK) and EN = '1') then
            case D is
                when x"1C" => D_v := "00010001"; -- A
                when x"32" => D_v := "00000001"; -- B
                when x"21" => D_v := "01100011"; -- C
                when x"23" => D_v := "10000101"; -- D
                when x"24" => D_v := "01100001"; -- E
                when x"2B" => D_v := "01110001"; -- F
                when x"34" => D_v := "01000001"; -- G
                when x"33" => D_v := "10010001"; -- H
                when x"43" => D_v := "10011111"; -- I
                when x"3B" => D_v := "10001111"; -- J
                when x"42" => D_v := "01010001"; -- K
                when x"4B" => D_v := "11100011"; -- L
                when x"3A" => D_v := "00001101"; -- M
                when x"31" => D_v := "11010101"; -- N
                when x"44" => D_v := "00000011"; -- O
                when x"4D" => D_v := "00110001"; -- P
                when x"15" => D_v := "00011000"; -- Q
                when x"2D" => D_v := "11110101"; -- R
                when x"1B" => D_v := "01001001"; -- S
                when x"2C" => D_v := "01110011"; -- T
                when x"3C" => D_v := "10000011"; -- U
                when x"2A" => D_v := "11000111"; -- V
                when x"1D" => D_v := "11000010"; -- W
                when x"22" => D_v := "11011001"; -- X
                when x"35" => D_v := "10011001"; -- Y
                when x"1A" => D_v := "00100101"; -- Z
                when others => D_v := "11111111"; -- blank
            end case;
        end if;
        if(RST = '1') then
            D_v := "11111111";
        end if;
        CHAR_OUT <= D_v;
    end process flop;

end Behavioral;


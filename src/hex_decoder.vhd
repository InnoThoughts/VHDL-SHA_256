----------------------------------------------------------------------------------
-- Nate Graff and Kenan Pretzer
-- Module Name: hex_decoder - Behavioral
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hex_decoder is
    Port ( HASH_IN : in  STD_LOGIC_VECTOR (255 downto 0);
           HASH_OUT : out STD_LOGIC_VECTOR (31 downto 0));
end hex_decoder;

architecture Behavioral of hex_decoder is

    signal hex_string : STD_LOGIC_VECTOR (511 downto 0);

begin

    decoder: process(HASH_IN)
        variable input : STD_LOGIC_VECTOR (3 downto 0);
    begin
        for I in 0 to 63 loop
            input := HASH_IN((4*I+3) downto (4*I));
            case input is
                when "0000" => hex_string ((8*I+7) downto 8*I) <= "00000011"; -- 0
                when "0001" => hex_string ((8*I+7) downto 8*I) <= "10011111"; -- 1
                when "0010" => hex_string ((8*I+7) downto 8*I) <= "00100101"; -- 2
                when "0011" => hex_string ((8*I+7) downto 8*I) <= "00001101"; -- 3
                when "0100" => hex_string ((8*I+7) downto 8*I) <= "10011001"; -- 4
                when "0101" => hex_string ((8*I+7) downto 8*I) <= "01001001"; -- 5
                when "0110" => hex_string ((8*I+7) downto 8*I) <= "01000001"; -- 6
                when "0111" => hex_string ((8*I+7) downto 8*I) <= "00011011"; -- 7
                when "1000" => hex_string ((8*I+7) downto 8*I) <= "00000001"; -- 8
                when "1001" => hex_string ((8*I+7) downto 8*I) <= "00011001"; -- 9
                when "1010" => hex_string ((8*I+7) downto 8*I) <= "00010001"; -- A
                when "1011" => hex_string ((8*I+7) downto 8*I) <= "11000001"; -- B
                when "1100" => hex_string ((8*I+7) downto 8*I) <= "01100011"; -- C
                when "1101" => hex_string ((8*I+7) downto 8*I) <= "10000101"; -- D
                when "1110" => hex_string ((8*I+7) downto 8*I) <= "01100001"; -- E
                when "1111" => hex_string ((8*I+7) downto 8*I) <= "01110001"; -- F
                when others => hex_string ((8*I+7) downto 8*I) <= "11111111"; -- undef (blank)
            end case;
            -- 63 ->  255, 252,  511, 504
            -- 62 ->  251, 248,  503, 496
            -- 61 ->  247, 244,  495, 488
            -- ...
            -- 3  ->   15,  12,   31,  24
            -- 2  ->   11,   8,   23,  16
            -- 1  ->    7,   4,   15,   8
            -- 0  ->    3,   0,    7,   0
            -- i  -> 4i+3,  4i, 8i+7,  8i
        end loop;
    end process decoder;
    
    HASH_OUT <= hex_string (511 downto 480);

end Behavioral;


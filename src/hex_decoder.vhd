----------------------------------------------------------------------------------
-- Nate Graff and Kenan Pretzer
-- Module Name: hex_decoder - Behavioral
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hex_decoder is
    Port ( HASH_IN : in  STD_LOGIC_VECTOR (255 downto 0);
           CHUNK_0 : out STD_LOGIC_VECTOR (127 downto 0);
           CHUNK_1 : out STD_LOGIC_VECTOR (127 downto 0);
           CHUNK_2 : out STD_LOGIC_VECTOR (127 downto 0);
           CHUNK_3 : out STD_LOGIC_VECTOR (127 downto 0));
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
                when "0000" => hex_string ((8*I+7) downto 8*I) <= "00110000"; -- 0
                when "0001" => hex_string ((8*I+7) downto 8*I) <= "00110001"; -- 1
                when "0010" => hex_string ((8*I+7) downto 8*I) <= "00110010"; -- 2
                when "0011" => hex_string ((8*I+7) downto 8*I) <= "00110011"; -- 3
                when "0100" => hex_string ((8*I+7) downto 8*I) <= "00110100"; -- 4
                when "0101" => hex_string ((8*I+7) downto 8*I) <= "00110101"; -- 5
                when "0110" => hex_string ((8*I+7) downto 8*I) <= "00110110"; -- 6
                when "0111" => hex_string ((8*I+7) downto 8*I) <= "00110111"; -- 7
                when "1000" => hex_string ((8*I+7) downto 8*I) <= "00111000"; -- 8
                when "1001" => hex_string ((8*I+7) downto 8*I) <= "00111001"; -- 9
                when "1010" => hex_string ((8*I+7) downto 8*I) <= "01000001"; -- A
                when "1011" => hex_string ((8*I+7) downto 8*I) <= "01000010"; -- B
                when "1100" => hex_string ((8*I+7) downto 8*I) <= "01000011"; -- C
                when "1101" => hex_string ((8*I+7) downto 8*I) <= "01000100"; -- D
                when "1110" => hex_string ((8*I+7) downto 8*I) <= "01000101"; -- E
                when "1111" => hex_string ((8*I+7) downto 8*I) <= "01000110"; -- F
                when others => hex_string ((8*I+7) downto 8*I) <= "00100000"; -- undef (blank)
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
    
    CHUNK_0 <= hex_string (511 downto 384);
    CHUNK_1 <= hex_string (383 downto 256);
    CHUNK_2 <= hex_string (255 downto 128);
    CHUNK_3 <= hex_string (127 downto 0);

end Behavioral;


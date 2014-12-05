----------------------------------------------------------------------------------
-- Nate Graff and Kenan Pretzer
-- Module Name: mode_demux - Behavioral
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mode_demux is
    Port (  USER_INPUT : in  STD_LOGIC_VECTOR (255 downto 0);
           HASH_OUTPUT : in  STD_LOGIC_VECTOR (255 downto 0);
           MODE_ENABLE : in  STD_LOGIC_VECTOR (1 downto 0);
               LCD_OUT : out STD_LOGIC_VECTOR (255 downto 0));
end mode_demux;

architecture Behavioral of mode_demux is

begin

    mode_select: process(USER_INPUT, HASH_OUTPUT, MODE_ENABLE)
    begin
        if(MODE_ENABLE(0) = '1') then
            LCD_OUT <= USER_INPUT;
        elsif(MODE_ENABLE(1) = '1') then
            LCD_OUT <= HASH_OUTPUT;
        else
            -- invalid state
            LCD_OUT <= USER_INPUT;
        end if;
    end process mode_select;

end Behavioral;
----------------------------------------------------------------------------------
-- Nate Graff and Kenan Pretzer
-- Module Name:    sseg_driver - Behavioral
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sseg_driver is
    Port ( DISPLAY : in  STD_LOGIC_VECTOR (31 downto 0);
           CLK : in  STD_LOGIC;
           ANODES : out  STD_LOGIC_VECTOR (3 downto 0);
           CATHODES : out  STD_LOGIC_VECTOR (7 downto 0));
end sseg_driver;

architecture Behavioral of sseg_driver is
    component clk_div is
        Port ( CLK : in STD_LOGIC;
              SCLK : out STD_LOGIC);
    end component;

    type state_val is (one, two, three, four);
    signal state : state_val := one;
    
    signal sclk : STD_LOGIC;
begin

    div: clk_div port map(
        CLK => CLK,
        SCLK => SCLK);

    proc: process(sclk, DISPLAY)
    begin
        if(rising_edge(sclk)) then
            case state is
                when one =>
                    ANODES <= "0111";
                    CATHODES <= DISPLAY (31 downto 24);--"01010101";
                    state <= two;
                when two =>
                    ANODES <= "1011";
                    CATHODES <= DISPLAY (23 downto 16);--"11110000";
                    state <= three;
                when three =>
                    ANODES <= "1101";
                    CATHODES <= DISPLAY (15 downto 8);--"00001111";
                    state <= four;
                when four =>
                    ANODES <= "1110";
                    CATHODES <= DISPLAY (7 downto 0);--"00000000";
                    state <= one;
             end case;
         end if;
    end process proc;


end Behavioral;


--------------------------------------------------------------------------------
-- Nate Graff and Kenan Pretzer 
-- Module Name: char_register_testbench
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
-- uncomment the following library declaration if using
-- arithmetic functions with signed or unsigned values
--use ieee.numeric_std.all;
 
entity char_register_testbench is
end char_register_testbench;
 
architecture Behavioral of char_register_testbench is 
 
    component char_register
        Port(        D : in  STD_LOGIC_VECTOR (7 downto 0);
                    EN : in  STD_LOGIC;
                   CLK : in  STD_LOGIC;
              CHAR_OUT : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

    --inputs
    signal D   : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal EN  : STD_LOGIC := '0';
    signal CLK : STD_LOGIC := '0';

    --outputs
    signal CHAR_OUT : STD_LOGIC_VECTOR (7 downto 0);
 
begin

    uut: char_register port map
        ( D        => D,
          EN       => EN,
          CLK      => CLK,
          CHAR_OUT => CHAR_OUT);

    stim_proc: process
    begin
        EN  <= '0';
        CLK <= '0';
        wait for 100 ns;
        
        EN <= '1';
        
        D <= "00000000";
        CLK <= '1';
        wait for 5 ns;
        CLK <= '0';
        assert(CHAR_OUT = "00000000");
        wait for 5 ns;
        
        D <= "11111111";
        CLK <= '1';
        wait for 5 ns;
        CLK <= '0';
        assert(CHAR_OUT = "11111111");
        wait for 5 ns;
        
        EN <= '0';
        
        D <= "00000000";
        CLK <= '1';
        wait for 5 ns;
        CLK <= '0';
        assert(CHAR_OUT = "11111111");
        wait for 5 ns;
        
        wait;
    end process;

end Behavioral;

--------------------------------------------------------------------------------
-- Nate Graff and Kenan Pretzer  
-- Module Name: word_register_testbench
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
-- uncomment the following library declaration if using
-- arithmetic functions with signed or unsigned values
--use ieee.numeric_std.all;
 
entity word_register_testbench is
end word_register_testbench;
 
architecture Behavioral of word_register_testbench is 

    component word_register
        Port( CHAR_IN : in  STD_LOGIC_VECTOR (7 downto 0);
                  SEL : in  STD_LOGIC_VECTOR (3 downto 0);
                  CLK : in  STD_LOGIC;
               OUTPUT : out STD_LOGIC_VECTOR (31 downto 0));
    end component;

    --inputs
    signal CHAR_IN : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal SEL     : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal CLK     : STD_LOGIC := '0';

    --outputs
    signal OUTPUT : STD_LOGIC_VECTOR(31 downto 0);
 
begin

    uut: word_register port map
        ( CHAR_IN => CHAR_IN,
          SEL     => SEL,
          CLK     => CLK,
          OUTPUT  => OUTPUT);

    stim_proc: process
    begin
        CLK <= '0';
        wait for 100 ns;
        
        CHAR_IN <= "11111111";
        SEL     <= "1000";
        CLK     <= '1';
        wait for 5 ns;
        CLK     <= '0';
        assert(OUTPUT = "11111111000000000000000000000000");
        wait for 5 ns;

        CHAR_IN <= "00000000";
        SEL     <= "1000";
        CLK     <= '1';
        wait for 5 ns;
        CLK     <= '0';
        assert(OUTPUT = "00000000000000000000000000000000");
        wait for 5 ns;
        
        CHAR_IN <= "11111111";
        SEL     <= "0100";
        CLK     <= '1';
        wait for 5 ns;
        CLK     <= '0';
        assert(OUTPUT = "00000000111111110000000000000000");
        wait for 5 ns;
        
        CHAR_IN <= "11111111";
        SEL     <= "0010";
        CLK     <= '1';
        wait for 5 ns;
        CLK     <= '0';
        assert(OUTPUT = "00000000111111111111111100000000");
        wait for 5 ns;
        
        CHAR_IN <= "11111111";
        SEL     <= "0001";
        CLK     <= '1';
        wait for 5 ns;
        CLK     <= '0';
        assert(OUTPUT = "00000000111111111111111111111111");
        wait for 5 ns;
        
        wait;
    end process;

end Behavioral;

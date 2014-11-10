--------------------------------------------------------------------------------
-- Nate Graff and Kenan Pretzer  
-- Module Name: count_5b_testbench
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
-- uncomment the following library declaration if using
-- arithmetic functions with signed or unsigned values
use IEEE.NUMERIC_STD.ALL;
 
entity counter_5b_testbench is
end counter_5b_testbench;
 
architecture Behavioral of counter_5b_testbench is 
 
    component counter_5b is
        Port( INCREMENT : in  STD_LOGIC;
                    RST : in  STD_LOGIC;
                  COUNT : out STD_LOGIC_VECTOR (4 downto 0));
    end component;

   --inputs
   signal INCREMENT : STD_LOGIC := '0';
   signal       RST : STD_LOGIC := '0';

   --outputs
   signal COUNT : STD_LOGIC_VECTOR (4 downto 0);
 
begin

    uut: counter_5b port map
        ( INCREMENT => INCREMENT,
          RST       => RST,
          COUNT     => COUNT);

    stim_proc: process
        variable counter_v : integer := 31;
    begin
        wait for 100 ns;  

        assert(to_integer(unsigned(COUNT)) = 31);
        for I in 1 to 31 loop
            counter_v := 31 - I;
        
            INCREMENT <= '1';
            wait for 5 ns;
            INCREMENT <= '0';
            wait for 5 ns;
            
            assert(to_integer(unsigned(COUNT)) = counter_v);
        end loop;

        wait;
    end process;

end Behavioral;

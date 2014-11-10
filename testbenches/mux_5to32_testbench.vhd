--------------------------------------------------------------------------------
-- Nate Graff and Kenan Pretzer  
-- Module Name: mux_5to32_testbench
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
-- uncomment the following library declaration if using
-- arithmetic functions with signed or unsigned values
use IEEE.NUMERIC_STD.ALL;
 
entity mux_5to32_testbench is
end mux_5to32_testbench;
 
architecture Behavioral of mux_5to32_testbench is 
 
    component mux_5to32
        Port(  SEL : in  STD_LOGIC_VECTOR (4 downto 0);
              CHAR : out STD_LOGIC_VECTOR (31 downto 0));
    end component;

   --inputs
   signal SEL : STD_LOGIC_VECTOR (4 downto 0) := (others => '0');

  --outputs
   signal CHAR : STD_LOGIC_VECTOR (31 downto 0);
 
begin

    uut: mux_5to32 port map
        ( SEL  => SEL,
          CHAR => CHAR);

    stim_proc: process
    begin
        wait for 100 ns;  

        for I in 0 to 31 loop
            SEL <= STD_LOGIC_VECTOR(to_unsigned(I, SEL'length));
            wait for 10 ns;
            assert(CHAR(I) = '1');
        end loop;

        wait;
    end process;

end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:54:18 12/04/2014 
-- Design Name: 
-- Module Name:    hash_mem - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
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

entity hash_mem is
    Port ( VAL_IN : in  STD_LOGIC_VECTOR (255 downto 0);
           CLK : in  STD_LOGIC;
           EN : in  STD_LOGIC;
           VAL_OUT : out STD_LOGIC_VECTOR (255 downto 0));
end hash_mem;

architecture Behavioral of hash_mem is

begin
    
    mem: process(CLK, EN, VAL_IN)
        variable HASH_v : STD_LOGIC_VECTOR (255 downto 0);
    begin
        if(rising_edge(CLK) and EN = '1') then
            HASH_v := VAL_IN;
        end if;
        
        VAL_OUT <= HASH_v;
    end process mem;
    
end Behavioral;


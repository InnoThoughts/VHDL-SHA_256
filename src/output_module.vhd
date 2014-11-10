----------------------------------------------------------------------------------
-- Nate Graff and Kenan Pretzer
-- Module Name:    output_module - output_module_architecture
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

entity output_module is
    Port ( NEW_KEYCODE : in  STD_LOGIC;
               KEYCODE : in  STD_LOGIC;
                    EN : in  STD_LOGIC;
               HASH_IN : in  STD_LOGIC_VECTOR (255 downto 0);
            STRING_OUT : OUT STD_LOGIC_VECTOR (255 downto 0));
end output_module;

architecture output_module_architecture of output_module is

begin


end output_module_architecture;


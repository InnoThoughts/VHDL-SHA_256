library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ps2_keyboard is
    Port (     PS2_CLK : in  STD_LOGIC;
              PS2_DATA : in  STD_LOGIC;
           NEW_KEYCODE : out STD_LOGIC;
               KEYCODE : out  STD_LOGIC_VECTOR (7 downto 0));
end ps2_keyboard;

architecture Behavioral of ps2_keyboard is
    signal BYTE_s : STD_LOGIC_VECTOR (10 downto 0) := (OTHERS => '1');
    signal READY_s : STD_LOGIC := '1';
begin

    ps2clkevent: process(PS2_CLK, PS2_DATA)
        variable COUNT : INTEGER := 0;
    begin
        -- The PS/2 spec states that the data signal should be
        -- read on the falling edge of the clock signal.
        if(falling_edge(PS2_CLK)) then
            BYTE_s <= PS2_DATA & BYTE_s (10 downto 1);
            COUNT := COUNT + 1;
            if(COUNT = 11) then
                READY_s <= '1';
                COUNT := 0;
            else
                READY_s <= '0';
            end if;
        end if;
    end process ps2clkevent;
    
    outputdata: process(READY_s)
    begin
        if(rising_edge(READY_s)) then
            KEYCODE <= BYTE_s (8 downto 1);
        end if;
    end process outputdata;
    
    NEW_KEYCODE <= READY_s;

end Behavioral;


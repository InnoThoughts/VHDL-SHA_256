----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:42:13 12/01/2014 
-- Design Name: 
-- Module Name:    lcd_driver - Behavioral 
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

entity lcd_driver is
    Port (      CLK : in  STD_LOGIC;
            DISPLAY : in  STD_LOGIC_VECTOR (255 downto 0);
                RST : in  STD_LOGIC;
                 RS : out STD_LOGIC;
                 RW : out STD_LOGIC;
                  E : out STD_LOGIC;
           LCD_DATA : out STD_LOGIC_VECTOR (7 downto 0));
end lcd_driver;

architecture Behavioral of lcd_driver is

    component lcd_controller IS
      PORT(
        clk        : IN    STD_LOGIC;  --system clock
        reset_n    : IN    STD_LOGIC;  --active low reinitializes lcd
        lcd_enable : IN    STD_LOGIC;  --latches data into lcd controller
        lcd_bus    : IN    STD_LOGIC_VECTOR(9 DOWNTO 0);  --data and control signals
        busy       : OUT   STD_LOGIC := '1';  --lcd controller busy/idle feedback
        rw, rs, e  : OUT   STD_LOGIC;  --read/write, setup/data, and enable for lcd
        lcd_data   : OUT   STD_LOGIC_VECTOR(7 DOWNTO 0)); --data signals for lcd
    END component;
    
    signal lcd_enable, lcd_busy : STD_LOGIC := '0';
    signal lcd_bus : STD_LOGIC_VECTOR (9 downto 0) := "0000000000";
    
begin

    lcd_control : lcd_controller PORT MAP(
        clk        => clk,
        reset_n    => RST,
        lcd_enable => lcd_enable,
        lcd_bus    => lcd_bus, 
        busy       => lcd_busy,
        rw         => rw,
        rs         => rs,
        e          => e,
        lcd_data   => lcd_data);
    
    driver: process(CLK, DISPLAY)
        variable char : INTEGER range 0 to 31 := 0;
    begin
        if(rising_edge(CLK)) then
            if(lcd_busy = '0' AND lcd_enable = '0') then

                lcd_enable <= '1';
                if(char <= 31) then
                    
                    --lcd_bus <= "10" & display (7 downto 0);
                    lcd_bus <= "10" & display((8*(31-char)+7) downto (8*(31-char))); 
                    -- 0 -> 255 : 248
                    -- 1 -> 247 : 240
                    -- ...
                    -- 31 -> 7 : 0
--                    if(char = 0) then
--                        lcd_bus <= "1001000001";
--                    else
--                        lcd_bus <= "1000010000";
--                    end if;
                    
                    char := char + 1;
                else
                    lcd_enable <= '0';
                end if;
            else
                lcd_enable <= '0';
            end if;
        end if;
    end process driver;

end Behavioral;


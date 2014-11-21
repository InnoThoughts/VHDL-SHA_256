----------------------------------------------------------------------------------
-- Nate Graff and Kenan Pretzer
-- Module Name: output_fsm - Behavioral
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mode_fsm is
    Port (         CLK : in  STD_LOGIC;
                   RST : in  STD_LOGIC;
           NEW_KEYCODE : in  STD_LOGIC;
               KEYCODE : in  STD_LOGIC_VECTOR (7 downto 0);
           MODE_ENABLE : out STD_LOGIC_VECTOR (1 downto 0));
end mode_fsm;

architecture Behavioral of mode_fsm is

    type state is (input_mode, output_mode);
    signal PS, NS : state := input_mode;

    -- Note: The Enter key is prefaced with an 0xF0 byte, remember this when
    -- implementing the keyboard interface
    constant enter_code : STD_LOGIC_VECTOR (7 downto 0) := "01011010"; -- 0x5A

begin

    seq: process(CLK, RST, NS)
    begin
        if(rising_edge(clk)) then
            if(RST = '1') then
                PS <= input_mode;
            else
                PS <= NS;
            end if;
        end if;
    end process seq;

    comb: process(PS, NEW_KEYCODE, KEYCODE)
    begin
        if(rising_edge(NEW_KEYCODE)) then
            case PS is

                when input_mode =>
                    if(KEYCODE = enter_code) then
                        NS <= output_mode;
                        MODE_ENABLE <= "10";
                    end if;

                when output_mode =>
                    if(KEYCODE = enter_code) then
                        NS <= input_mode;
                        mode_output <= "01";
                    end if;

            end case;
        end if;
    end process comb;

end Behavioral;


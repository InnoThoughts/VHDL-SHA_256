----------------------------------------------------------------------------------
-- Nate Graff and Kenan Pretzer
-- Module Name: output_fsm - Behavioral
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity output_fsm is
    Port (         CLK : in  STD_LOGIC;
                   RST : in  STD_LOGIC;
           NEW_KEYCODE : in  STD_LOGIC;
               KEYCODE : in  STD_LOGIC_VECTOR (7   downto 0);
               CHUNK_0 : in  STD_LOGIC_VECTOR (127 downto 0);
               CHUNK_1 : in  STD_LOGIC_VECTOR (127 downto 0);
               CHUNK_2 : in  STD_LOGIC_VECTOR (127 downto 0);
               CHUNK_3 : in  STD_LOGIC_VECTOR (127 downto 0);
            STRING_OUT : out STD_LOGIC_VECTOR (127 downto 0)); -- Mealy
end output_fsm;

architecture Behavioral of output_fsm is

    type state is (first_chunk, second_chunk, third_chunk, fourth_chunk);
    signal PS, NS : state := first_chunk;

    -- Note: arrow keys are prefaced with an 0xE0 byte, remember this when
    -- implementing the keyboard interface
    constant right_arrow : STD_LOGIC_VECTOR (7 downto 0) := "01110100"; -- 0x74
    constant  left_arrow : STD_LOGIC_VECTOR (7 downto 0) := "01101011"; -- 0x6B

begin

    seq: process(CLK, RST, NS, CHUNK_0, CHUNK_1, CHUNK_2, CHUNK_3)
    begin
        if(rising_edge(clk)) then
            if(RST = '1') then
                PS <= first_chunk;
            else
                PS <= NS;
            end if;

            if(PS = first_chunk) then
                STRING_OUT <= CHUNK_0;
            elsif(PS = second_chunk) then
                STRING_OUT <= CHUNK_1;
            elsif(PS = third_chunk) then
                STRING_OUT <= CHUNK_2;
            elsif(PS = fourth_chunk) then
                STRING_OUT <= CHUNK_3;
            else
                STRING_OUT <= CHUNK_0;
            end if;

        end if;
    end process seq;

    comb: process(PS, NEW_KEYCODE, KEYCODE)
    begin
        if(rising_edge(NEW_KEYCODE)) then
            case PS is

                when first_chunk =>
                    if(KEYCODE = right_arrow) then
                        NS <= second_chunk;
                    end if;

                when second_chunk =>
                    if(KEYCODE = right_arrow) then
                        NS <= third_chunk;
                    elsif(KEYCODE = left_arrow) then
                        NS <= first_chunk;
                    end if;

                when third_chunk =>
                    if(KEYCODE = right_arrow) then
                        NS <= fourth_chunk;
                    elsif(KEYCODE = left_arrow) then
                        NS <= third_chunk;
                    end if;

                when fourth_chunk =>
                    if(KEYCODE = left_arrow) then
                        NS <= third_chunk;
                    end if;

            end case;
        end if;
    end process comb;

end Behavioral;


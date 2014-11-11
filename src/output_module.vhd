----------------------------------------------------------------------------------
-- Nate Graff and Kenan Pretzer
-- Module Name: output_module - Structural
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity output_module is
    Port ( NEW_KEYCODE : in  STD_LOGIC;
               KEYCODE : in  STD_LOGIC;
               HASH_IN : in  STD_LOGIC_VECTOR (255 downto 0);
            STRING_OUT : OUT STD_LOGIC_VECTOR (255 downto 0));
end output_module;

architecture Structural of output_module is

    component hex_decoder is
        Port ( HASH_IN : in  STD_LOGIC_VECTOR (255 downto 0);
               CHUNK_0 : out STD_LOGIC_VECTOR (255 downto 0);
               CHUNK_1 : out STD_LOGIC_VECTOR (255 downto 0);
               CHUNK_2 : out STD_LOGIC_VECTOR (255 downto 0);
               CHUNK_3 : out STD_LOGIC_VECTOR (255 downto 0));
    end component;
    
    component output_fsm is
        Port (         CLK : in  STD_LOGIC;
                       RST : in  STD_LOGIC;
               NEW_KEYCODE : in  STD_LOGIC;
                   KEYCODE : in  STD_LOGIC_VECTOR (7   downto 0);
                   CHUNK_0 : in  STD_LOGIC_VECTOR (127 downto 0);
                   CHUNK_1 : in  STD_LOGIC_VECTOR (127 downto 0);
                   CHUNK_2 : in  STD_LOGIC_VECTOR (127 downto 0);
                   CHUNK_3 : in  STD_LOGIC_VECTOR (127 downto 0);
                STRING_OUT : out STD_LOGIC_VECTOR (127 downto 0)); -- Mealy
    end component;
    
    signal CHUNK_0, CHUNK_1, CHUNK_2, CHUNK_3 : STD_LOGIC_VECTOR (255 downto 0);

begin

    decoder: hex_decoder port map
        ( HASH_IN => HASH_IN,
          CHUNK_0 => CHUNK_0,
          CHUNK_1 => CHUNK_1,
          CHUNK_2 => CHUNK_2,
          CHUNK_3 => CHUNK_3);
          
    fsm: output_fsm port map
        ( NEW_KEYCODE => NEW_KEYCODE,
          KEYCODE     => KEYCODE,
          CHUNK_0     => CHUNK_0,
          CHUNK_1     => CHUNK_1,
          CHUNK_2     => CHUNK_2,
          CHUNK_3     => CHUNK_3,
          STRING_OUT  => STRING_OUT);

end Structural;


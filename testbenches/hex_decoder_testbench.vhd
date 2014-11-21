--------------------------------------------------------------------------------
-- Nate Graff and Kenan Pretzer
-- Module Name: hex_decoder_testbench - Behavioral
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
-- uncomment the following library declaration if using
-- arithmetic functions with signed or unsigned values
--use ieee.numeric_std.all;
 
entity hex_decoder_testbench is
end hex_decoder_testbench;
 
architecture behavior of hex_decoder_testbench is 
 
    -- component declaration for the unit under test (uut)
 
    component hex_decoder
        Port( HASH_IN : in  STD_LOGIC_VECTOR(255 downto 0);
              CHUNK_0 : out STD_LOGIC_VECTOR(127 downto 0);
              CHUNK_1 : out STD_LOGIC_VECTOR(127 downto 0);
              CHUNK_2 : out STD_LOGIC_VECTOR(127 downto 0);
              CHUNK_3 : out STD_LOGIC_VECTOR(127 downto 0));
    end component;

   --inputs
   signal HASH_IN : STD_LOGIC_VECTOR(255 downto 0) := (others => '0');

   signal sample_input : STD_LOGIC_VECTOR(63 downto 0) := "0000000100100011010001010110011110001001101010111100110111101111";

  --outputs
   signal CHUNK_0 : STD_LOGIC_VECTOR(127 downto 0);
   signal CHUNK_1 : STD_LOGIC_VECTOR(127 downto 0);
   signal CHUNK_2 : STD_LOGIC_VECTOR(127 downto 0);
   signal CHUNK_3 : STD_LOGIC_VECTOR(127 downto 0);

   signal sample_output : STD_LOGIC_VECTOR(127 downto 0) := "00110000001100010011001000110011001101000011010100110110001101110011100000111001010000010100001001000011010001000100010101000110";
   signal blank_output  : STD_LOGIC_VECTOR(127 downto 0) := "00110000001100000011000000110000001100000011000000110000001100000011000000110000001100000011000000110000001100000011000000110000"; 
begin

    uut: hex_decoder port map
        ( HASH_IN => HASH_IN,
          CHUNK_0 => CHUNK_0,
          CHUNK_1 => CHUNK_1,
          CHUNK_2 => CHUNK_2,
          CHUNK_3 => CHUNK_3);

    stim_proc: process
    begin
        wait for 100 ns;
      
        HASH_IN (255 downto 192) <= sample_input;
        wait for 10 ns;
        assert (CHUNK_0 = sample_output);
        assert (CHUNK_1 = blank_output);
        assert (CHUNK_2 = blank_output);
        assert (CHUNK_3 = blank_output);

        wait;
    end process;

end;

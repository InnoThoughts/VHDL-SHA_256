--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:40:01 11/16/2014
-- Design Name:   
-- Module Name:   C:/Kenan Files/School Work/2014 Fall/VHDL-SHA_256/algorithm_testbench.vhd
-- Project Name:  VHDL-SHA_256
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Algorithm_Implementation
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY algorithm_testbench IS
END algorithm_testbench;
 
ARCHITECTURE behavior OF algorithm_testbench IS
 
    COMPONENT Algorithm_Implementation
    PORT(
         message : IN  std_logic_vector(255 downto 0);
          digest : OUT std_logic_vector(255 downto 0));
    END COMPONENT;
    

    --Inputs
    signal message : std_logic_vector(255 downto 0) := (OTHERS => '0');

    --Outputs
    signal digest : std_logic_vector(255 downto 0);
 
BEGIN

   uut: Algorithm_Implementation PORT MAP (
       message => message,
       digest  => digest);

   stim_proc: process
   begin
		 wait for 100 ns;

		 message (127 downto 0) <= "00101001001010010010100100101001001010010010100100101001001010010010100100101001001010010010100100101001001010010010100100101001";
		 message (255 downto 128) <= "00101001001010010010100100101001001010010010100100101001001010010010100100101001001010010010100100101001001010010010100100101001";
		 wait for 10 ns;
		 assert (digest = "0010001010100100100000000101000101011001010011000001100101001001110111101110110101110000010000001000010100001100000111110000111110000111011001000101001101111111010100011001000110111110010101100111001100101101000101101010010101001100000111011000000101010011") report "Error, expected output of ." severity ERROR;

       wait;
   end process;

END;

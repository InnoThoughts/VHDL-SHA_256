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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY algorithm_testbench IS
END algorithm_testbench;
 
ARCHITECTURE behavior OF algorithm_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Algorithm_Implementation
    PORT(
         message : IN  std_logic_vector(255 downto 0);
         digest : OUT  std_logic_vector(255 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal message : std_logic_vector(255 downto 0) := (others => '0');

 	--Outputs
   signal digest : std_logic_vector(255 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Algorithm_Implementation PORT MAP (
          message => message,
          digest => digest
        );

--   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

--      wait for <clock>_period*10;

      -- insert stimulus here 
		message (255 downto 248) <= "01000001";

      wait;
   end process;

END;

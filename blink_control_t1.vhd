--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:53:47 11/25/2021
-- Design Name:   
-- Module Name:   D:/ISE/az7/blink_control_t1.vhd
-- Project Name:  az7
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: blink_control
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
library IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_arith.ALL;
USE IEEE.std_logic_unsigned.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY blink_control_t1 IS
END blink_control_t1;
 
ARCHITECTURE behavior OF blink_control_t1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT blink_control
    PORT(
         seg1 : OUT  std_logic_vector(6 downto 0);
         seg2 : OUT  std_logic_vector(6 downto 0);
         mode : OUT  std_logic_vector(1 downto 0);
         clk : IN  std_logic;
         LED1 : OUT  std_logic_vector(2 downto 0);
         LED2 : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';

 	--Outputs
   signal seg1 : std_logic_vector(6 downto 0);
   signal seg2 : std_logic_vector(6 downto 0);
   signal mode : std_logic_vector(1 downto 0);
   signal LED1 : std_logic_vector(2 downto 0);
   signal LED2 : std_logic_vector(2 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: blink_control PORT MAP (
          seg1 => seg1,
          seg2 => seg2,
          mode => mode,
          clk => clk,
          LED1 => LED1,
          LED2 => LED2
        );

	clk <= not(clk) after 1 ms;

END;

--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   04:30:46 11/26/2021
-- Design Name:   
-- Module Name:   D:/ISE/az7/TOP_t1.vhd
-- Project Name:  az7
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: TOP
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
USE STD.TEXTIO.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TOP_t1 IS
END TOP_t1;
 
ARCHITECTURE behavior OF TOP_t1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT TOP
    PORT(
         apply : IN  std_logic;
         blink : IN  std_logic;
         clk : IN  std_logic;
         input1 : IN  std_logic_vector(6 downto 0);
         input2 : IN  std_logic_vector(6 downto 0);
         output : OUT  bit_vector(7 downto 0);
         common : OUT  std_logic_vector(3 downto 0);
         LED1 : OUT  std_logic_vector(2 downto 0);
         LED2 : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal apply : std_logic := '0';
   signal blink : std_logic := '0';
   signal clk : std_logic := '0';
   signal input1 : std_logic_vector(6 downto 0) := (others => '0');
   signal input2 : std_logic_vector(6 downto 0) := (others => '0');

 	--Outputs
   signal output : bit_vector(7 downto 0);
   signal common : std_logic_vector(3 downto 0);
   signal LED1 : std_logic_vector(2 downto 0);
   signal LED2 : std_logic_vector(2 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: TOP PORT MAP (
          apply => apply,
          blink => blink,
          clk => clk,
          input1 => input1,
          input2 => input2,
          output => output,
          common => common,
          LED1 => LED1,
          LED2 => LED2
        );

   apply <= '1' after 10 us;
   blink <= '1' after 1 ms;
   clk <= not(clk) after 5 ns;
   input1 <= "0001110" after 7 us;
   input2 <= "0001100" after 7 us;

END;

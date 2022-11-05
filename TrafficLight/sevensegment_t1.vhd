--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:45:13 11/16/2021
-- Design Name:   
-- Module Name:   D:/ISE/az6/sevensegment/sevensegment_t1.vhd
-- Project Name:  sevensegment
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: sevensegment
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
 
ENTITY sevensegment_t1 IS
END sevensegment_t1;
 
ARCHITECTURE behavior OF sevensegment_t1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT sevensegment
    PORT(
         input1 : IN  std_logic_vector(6 downto 0);
         input2 : IN  std_logic_vector(6 downto 0);
         mode : IN  std_logic_vector(1 downto 0);
         clk : IN  std_logic;
         output : OUT  bit_vector(7 downto 0);
         com : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal input1 : std_logic_vector(6 downto 0) := (others => '0');
   signal input2 : std_logic_vector(6 downto 0) := (others => '0');
   signal mode : std_logic_vector(1 downto 0) := (others => '0');
   signal clk : std_logic := '0';

 	--Outputs
   signal output : bit_vector(7 downto 0);
   signal com : std_logic_vector(3 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: sevensegment PORT MAP (
          input1 => input1,
          input2 => input2,
          mode => mode,
          clk => clk,
          output => output,
          com => com
        );

	clk <= not(clk) after 10 ns;
	mode <= "01" after 2 ns, "10" after 400 ns;
	input1 <= "1100000" after 1 ns;
	input2 <= "0100010" after 1 ns;

END;

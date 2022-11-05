--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:28:00 11/17/2021
-- Design Name:   
-- Module Name:   D:/ISE/az6/sevensegment/input_control_t1.vhd
-- Project Name:  sevensegment
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: input_control
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
 
ENTITY input_control_t1 IS
END input_control_t1;
 
ARCHITECTURE behavior OF input_control_t1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT input_control
    PORT(
         input1 : IN  std_logic_vector(6 downto 0);
         input2 : IN  std_logic_vector(6 downto 0);
         apply : IN  std_logic;
         Green : OUT  std_logic_vector(6 downto 0);
         Yellow : OUT  std_logic_vector(6 downto 0);
         Red : OUT  std_logic_vector(6 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal input1 : std_logic_vector(6 downto 0) := (others => '0');
   signal input2 : std_logic_vector(6 downto 0) := (others => '0');
   signal apply : std_logic := '0';

 	--Outputs
   signal Green : std_logic_vector(6 downto 0);
   signal Yellow : std_logic_vector(6 downto 0);
   signal Red : std_logic_vector(6 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: input_control PORT MAP (
          input1 => input1,
          input2 => input2,
          apply => apply,
          Green => Green,
          Yellow => Yellow,
          Red => Red
        );

	input1 <= "1100000" after 150 ns, "0010111" after 300 ns, "1000111" after 450 ns;
	input2 <= "0100010" after 150 ns, "0010111" after 300 ns, "0101101" after 450 ns;
	apply <= not(apply) after 50 ns;

END;

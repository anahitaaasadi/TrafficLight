---------------------------------------------------------------------------------
-- File Name: input_control
-- Description:
-- Author: Anahita Asadi
-- Date: 2021.12.11
-- Last Modified: 2021.12.11
-- Organization: K. N. Toosi. University
---------------------------------------------------------------------------------
library IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_arith.ALL;
USE IEEE.std_logic_unsigned.ALL;
---------------------------------------------------------------------------------
entity input_control is port(	input1, input2: in std_logic_vector(6 downto 0);
										apply: in std_logic;
										Green, Yellow, Red: out std_logic_vector(6 downto 0));
end input_control;
---------------------------------------------------------------------------------
architecture behavioral of input_control is
begin	
process(apply)
begin
	if rising_edge(apply) then
		if (input1 < "1100011" and input2 < "1100011" and input1 > "0000000" and input2 > "0000000" and input1 /= input2) then		
			if (input1 > input2) then
				Red <= input1;
				Green <= input2;
				Yellow <= input1 - input2;
			elsif (input1 < input2) then
				Red <= input2;
				Green <= input1;
				Yellow <= input2 - input1;
			end if;
		end if;
	end if;
end process;
end behavioral;
---------------------------------------------------------------------------------
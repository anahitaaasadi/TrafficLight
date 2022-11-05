---------------------------------------------------------------------------------
-- File Name: sevensegment
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
entity blink_control is port(	seg1, seg2: out std_logic_vector(6 downto 0);
										mode: out std_logic_vector(1 downto 0);
										clk: in std_logic;
										LED1, LED2: out std_logic_vector(2 downto 0));
end blink_control;
---------------------------------------------------------------------------------
architecture behavioral of blink_control is

	type state is (led_off, led_on);
	signal pr_state: state := led_off;
	
	begin
	
process(clk)
	begin
		if rising_edge(clk) then
			case pr_state	is when led_off =>LED1 <= "000";
														LED2 <= "000";
														mode <= "00";
														pr_state <= led_on;
									when led_on =>	LED1 <= "100";
														LED2 <= "010";
														mode <= "00";
														pr_state <= led_off;
									when others =>	pr_state <= led_off;
			end case;
		end if;
end process;
end behavioral;
---------------------------------------------------------------------------------
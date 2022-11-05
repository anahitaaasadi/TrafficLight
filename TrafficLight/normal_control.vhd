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
entity normal_control is port(seg1, seg2: out std_logic_vector(6 downto 0);
										mode: out std_logic_vector(1 downto 0);
										clk: in std_logic;
										LED1, LED2: out std_logic_vector(2 downto 0);
										Red, Green, Yellow: in std_logic_vector(6 downto 0));
end normal_control;
---------------------------------------------------------------------------------
architecture behavioral of normal_control is
	
	type state is (S1, S2, S3, S4);
	signal pr_state: state := S1;
	
	begin
	
process(clk)

	variable count, seg2_temp, seg1_temp: std_logic_vector(6 downto 0) := "0000000";
	
	begin
		if rising_edge(clk) then
			if(	Red < "1100011" and Green < "1100011" and Yellow < "1100011" and
					Red > "0000000" and Green > "0000000" and Yellow > "0000000") then
				case pr_state	is when S1 =>	LED1 <= "100";
														LED2 <= "001";
														mode <= "11";
														seg1_temp := Red - count;
														seg2_temp := Green - count;
														if seg2_temp = "0000000" then
															pr_state <= S2;
															count := "0000000";
														else
															count := count + 1;														
															pr_state <= S1;
														end if;
										when S2 =>	LED1 <= "100";
														LED2 <= "010";
														mode <= "10";
														seg1_temp := Yellow - count;
														if seg1_temp = "000000" then
															pr_state <= S3;
															count := "0000000";
														else
															count := count + 1;														
															pr_state <= S2;
														end if;
										when S3 =>	LED1 <= "001";
														LED2 <= "100";
														mode <= "11";
														seg1_temp := Green - count;
														seg2_temp := Red - count;
														if seg1_temp = "0000000" then
															pr_state <= S4;
															count := "0000000";
														else
															count := count + 1;
															pr_state <= S3;
														end if;
										when S4 =>	LED1 <= "001";
														LED2 <= "100";
														mode <= "01";
														seg2_temp := Yellow - count;
														if seg2_temp = "0000000" then
															pr_state <= S1;
															count := "0000000";
														else
															count := count + 1;														
															pr_state <= S4;
														end if;
										when others =>	pr_state <= S1;
				end case;
				seg1 <= seg1_temp;
				seg2 <= seg2_temp;
			end if;
		end if;
end process;
end behavioral;
---------------------------------------------------------------------------------
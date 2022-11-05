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
USE STD.TEXTIO.ALL;
---------------------------------------------------------------------------------
entity sevensegment is port(	input1, input2: in std_logic_vector(6 downto 0);
										mode: in std_logic_vector(1 downto 0);
										clk: in std_logic;
										output: out bit_vector(7 downto 0);
										com: out std_logic_vector(3 downto 0));
end sevensegment;
---------------------------------------------------------------------------------
architecture behavioral of sevensegment is

	type RAM_type is array (0 to 9) of bit_vector(7 downto 0);
	
	function ram_initialize (filename: in string) return RAM_type is
		file file1: text is in filename;
		variable line1: line;
		variable RAM1: RAM_type;
		begin for i in RAM_type'range loop	readline(file1, line1);
														read(line1, RAM1(i));
												end loop;
		return RAM1;
	end function;	
	
	signal RAM: RAM_type := ram_initialize("values.txt");
	signal ones: std_logic_vector(6 downto 0) := "0000000";
	signal tens: std_logic_vector(3 downto 0) := "0000";
	
	type state is (M0, M1, M2, M3, M4, M5, M6, M7, M8, M9, M10, M11);
	signal pr_state1: state := M0;
	signal pr_state2: state := M6;
	
	begin
	
process(clk)
	begin
		if rising_edge(clk) then
			if (mode = "01") then
				case	pr_state1 is	when M0 =>	ones <= input1;
															tens <= "0000";				
															pr_state1 <= M1;
											when M1 =>	if (ones >= "1010") then
																ones <= ones - "1010";
																tens <= tens + "0001";
																pr_state1 <= M1;
															else
																pr_state1 <= M2;
															end if;
											when M2 =>	com <= "0001";
															output <= RAM(conv_integer(ones(3 downto 0)));
															pr_state1 <= M3;
											when M3 =>	com <= "0010";
															output <= RAM(conv_integer(tens));
															pr_state1 <= M4;
											when M4 =>	com <= "0100";
															output <= "10111111";
															pr_state1 <= M5;
											when M5 =>	com <= "1000";
															output <= "10111111";
															pr_state1 <= M2;
											when others =>	pr_state1 <= M0;
					end case;
			elsif (mode = "10") then
				case	pr_state2 is	when M6 =>	ones <= input2;
															tens <= "0000";
															pr_state2 <= M7;
											when M7 =>	if (ones >= "1010") then
																ones <= ones - "1010";
																tens <= tens + "0001";
																pr_state2 <= M7;
															else
																pr_state2 <= M8;
															end if;
											when M8 =>	com <= "0001";
															output <= RAM(conv_integer(ones(3 downto 0)));
															pr_state2 <= M9;
											when M9 =>	com <= "0010";
															output <= RAM(conv_integer(tens));
															pr_state2 <= M10;
											when M10 =>	com <= "0100";
															output <= "10111111";
															pr_state2 <= M11;
											when M11 =>	com <= "1000";
															output <= "10111111";
															pr_state2 <= M8;
											when others =>	pr_state2 <= M6;
				end case;
			end if;
		end if;
end process;
end behavioral;
---------------------------------------------------------------------------------
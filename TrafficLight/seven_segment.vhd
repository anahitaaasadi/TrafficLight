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
entity seven_segment is port(	input1, input2: in std_logic_vector(6 downto 0);
										mode: in std_logic_vector(1 downto 0);
										clk: in std_logic;
										output: out bit_vector(7 downto 0);
										com: out std_logic_vector(3 downto 0));
end seven_segment;
---------------------------------------------------------------------------------
architecture behavioral of seven_segment is

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
	
	signal ones1, ones2: std_logic_vector(6 downto 0) := "0000000";
	signal tens1, tens2: std_logic_vector(3 downto 0) := "0000";
	
	type state is (M0, M1, M2, M3, M4, M5, M6, M7, M8, M9, M10, M11, M12,
						M13, M14, M15, M16, M17, M18, M19, M20, M21, M22, M23);
	signal pr_state1: state := M0;
	signal pr_state2: state := M6;
	signal pr_state3: state := M12;
	signal pr_state4: state := M16;
	
begin
	
process(clk)
begin
	
	if rising_edge(clk) then
		if (mode = "01") then
				case	pr_state1 is	when M0 =>	ones1 <= input1;
															tens1 <= "0000";				
															pr_state1 <= M1;
											when M1 =>	if (ones1 >= "1010") then
																ones1 <= ones1 - "1010";
																tens1 <= tens1 + "0001";
																pr_state1 <= M1;
															else
																pr_state1 <= M2;
															end if;
											when M2 =>	com <= "0001";
															output <= RAM(conv_integer(ones1(3 downto 0)));
															pr_state1 <= M3;
											when M3 =>	com <= "0010";
															output <= RAM(conv_integer(tens1));
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
				case	pr_state2 is	when M6 =>	ones2 <= input2;
															tens2 <= "0000";
															pr_state2 <= M7;
											when M7 =>	if (ones2 >= "1010") then
																ones2 <= ones2 - "1010";
																tens2 <= tens2 + "0001";
																pr_state2 <= M7;
															else
																pr_state2 <= M8;
															end if;
											when M8 =>	com <= "0001";
															output <= RAM(conv_integer(ones2(3 downto 0)));
															pr_state2 <= M9;
											when M9 =>	com <= "0010";
															output <= RAM(conv_integer(tens2));
															pr_state2 <= M10;
											when M10 =>	com <= "0100";
															output <= "10111111";
															pr_state2 <= M11;
											when M11 =>	com <= "1000";
															output <= "10111111";
															pr_state2 <= M8;
											when others =>	pr_state2 <= M6;
				end case;
		elsif (mode = "00") then
			case	pr_state3 is	when M12 =>	com <= "0001";
														output <= "10111111";
														pr_state3 <= M13;
										when M13 =>	com <= "0010";
														output <= "10111111";
														pr_state3 <= M14;
										when M14 =>	com <= "0100";
														output <= "10111111";
														pr_state3 <= M15;
										when M15 =>	com <= "1000";
														output <= "10111111";
														pr_state3 <= M12;
										when others =>	pr_state3 <= M12;
				end case;
		elsif (mode = "11") then
			case	pr_state4 is	when M16 =>	ones1 <= input1;
														tens1 <= "0000";
														pr_state4 <= M17;
										when M17 =>	if (ones1 >= "1010") then
															ones1 <= ones1 - "1010";
															tens1 <= tens1 + "0001";
															pr_state4 <= M17;
														else
															pr_state4 <= M18;
														end if;
										when M18 =>	ones2 <= input2;
														tens2 <= "0000";
														pr_state4 <= M19;
										when M19 =>	if (ones2 >= "1010") then
															ones2 <= ones2 - "1010";
															tens2 <= tens2 + "0001";
															pr_state4 <= M19;
														else
															pr_state4 <= M20;
														end if;
										when M20 =>	com <= "0001";
														output <= RAM(conv_integer(ones1(3 downto 0)));
														pr_state4 <= M21;
										when M21 =>	com <= "0010";
														output <= RAM(conv_integer(tens1));
														pr_state4 <= M22;
										when M22 =>	com <= "0100";
														output <= RAM(conv_integer(ones2(3 downto 0)));
														pr_state4 <= M23;
										when M23 =>	com <= "1000";
														output <= RAM(conv_integer(tens2));
														pr_state4 <= M20;
										when others =>	pr_state4 <= M16;
			end case;
		end if;
	end if;
end process;
end behavioral;
---------------------------------------------------------------------------------
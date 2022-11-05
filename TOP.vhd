library IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_arith.ALL;
USE IEEE.std_logic_unsigned.ALL;
USE STD.TEXTIO.ALL;

entity TOP is port(	apply: in std_logic;
							blink: in std_logic;
							clk: in std_logic;
							input1, input2: in std_logic_vector (6 downto 0);
							output: out bit_vector(7 downto 0);
							common: out std_logic_vector(3 downto 0);
							LED1, LED2: out std_logic_vector(2 downto 0));
end TOP;

architecture Behavioral of TOP is

	component blink_control port(	seg1, seg2: out std_logic_vector(6 downto 0);
											mode: out std_logic_vector(1 downto 0);
											clk: in std_logic;
											LED1, LED2: out std_logic_vector(2 downto 0));
	END component;
	
	component seven_segment port(	input1, input2: in std_logic_vector(6 downto 0);
											mode: in std_logic_vector(1 downto 0);
											clk: in std_logic;
											output: out bit_vector(7 downto 0);
											com: out std_logic_vector(3 downto 0));
	END component;
	
	component input_control port(	input1, input2: in std_logic_vector(6 downto 0);
											apply: in std_logic;
											Green, Yellow, Red: out std_logic_vector(6 downto 0));
	END component;
	
	component normal_control port(seg1, seg2: out std_logic_vector(6 downto 0);
											mode: out std_logic_vector(1 downto 0);
											clk: in std_logic;
											LED1, LED2: out std_logic_vector(2 downto 0);
											Red, Green, Yellow: in std_logic_vector(6 downto 0));
	END component;

	component clock_devision generic(DIV  :  integer := 10);
									 port(	clk_in:	in std_logic;
												clk_out:	out std_logic);
	END component;

	signal mode: std_logic_vector(1 downto 0) := "00";
	signal Green, Yellow, Red: std_logic_vector(6 downto 0) := "0000000";
	signal input1_temp, input2_temp: std_logic_vector(6 downto 0) := "0000000";
	signal clk_dev: std_logic := '0';
	----------------------------------------------------------------------------------------
	signal seg1_blink_control, seg2_blink_control, seg1_normal_control, seg2_normal_control: std_logic_vector(6 downto 0) := "0000000";
	signal mode_blink_control, mode_normal_control: std_logic_vector(1 downto 0) := "00"; 
	signal blink_select, normal_select: std_logic := '0';
	signal LED1_blink_control, LED2_blink_control, LED1_normal_control, LED2_normal_control: std_logic_vector(2 downto 0) := "000";
	
begin	

	U1: blink_control port map(seg1_blink_control, seg2_blink_control, mode_blink_control, blink_select,
										LED1_blink_control, LED2_blink_control);
	U2: seven_segment port map(input1_temp, input2_temp, mode, clk, output, common);
	U3: input_control port map(input1, input2, apply, Green, Yellow, Red);
	U4: normal_control port map(	seg1_normal_control, seg2_normal_control, mode_normal_control, normal_select,
											LED1_normal_control, LED2_normal_control, Red, Green, Yellow);
	U5: clock_devision generic map (250) port map(clk, clk_dev);
	
	process(clk)
	begin
		if rising_edge(clk) then
			if blink = '1' then
				normal_select <= '0';
				blink_select <= clk_dev;
				mode <= mode_blink_control;
				LED1 <= LED1_blink_control;
				LED2 <= LED2_blink_control;
				input1_temp <= seg1_blink_control;
				input2_temp <= seg2_blink_control;
			else
				blink_select <= '0';
				normal_select <= clk_dev;
				mode <= mode_normal_control;
				LED1 <= LED1_normal_control;
				LED2 <= LED2_normal_control;
				input1_temp <= seg1_normal_control;
				input2_temp <= seg2_normal_control;
			end if;
		end if;
	end process;

end Behavioral;
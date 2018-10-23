----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.10.2018 00:03:35
-- Design Name: 
-- Module Name: led_driver - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity led_driver is
    Port (	
    		
    		clk		: in STD_LOGIC;
    		reset 	: in STD_LOGIC;
           	iter  	: in STD_LOGIC;
           	alarm 	: in STD_LOGIC;
           	speed 	: in std_logic_vector(1 downto 0);
			
			state	: in std_logic_vector(2 downto 0);

	        red	 	: out std_logic_vector(7 downto 0);
           	green	: out std_logic_vector(7 downto 0);
	        blue 	: out std_logic_vector(7 downto 0));
    
end led_driver;

architecture Behavioral of led_driver is
	component timer
		Port ( 	reset 	: in STD_LOGIC;
    			t_clk		: in STD_LOGIC;
    			timer 	: out STD_LOGIC);
	end component timer;


begin
	DUT : timer
	port map (
    	clk		=> clk,
		t_reset	=> t_reset,
    	t_alarm => t_alarm,
    	t_speed => t_speed,
    	timer 	=> timer
		);
process(clk, reset, iter, alarm, speed, state)

variable v_speed : std_logic_vector(1 downto 0);
variable v_state : std_logic_vector(2 downto 0);

begin
	if(reset = '1') then
		t_reset <= '1';
	elsif rising_edge(clk) then
		t_reset <= '0';
		if (rising_edge(timer) and iter = '0') then
			v_state := v_state + std_logic_vector(to_unsigned(1, 3));
			case(v_state) is
				--Standby
				when "000" => 
					red 	<= "11111111";
					green 	<= "11111111";
					blue	<= "11111111";
	
				--Red
				when "001" =>
					red 	<= "11111111";
					green 	<= "00000000";
					blue	<= "00000000";
				--Yellow
				when "010" =>
					red 	<= "11111111";
					green 	<= "11111111";
					blue	<= "00000000";
				--Green
				when "011" =>
					red 	<= "00000000";
					green 	<= "11111111";
					blue	<= "00000000";
				--Blue
				when "100" =>
					red 	<= "00000000";
					green 	<= "00000000";
					blue	<= "11111111";
				--Purple
				when "101" =>
					red 	<= "10000000";
					green 	<= "00000000";
					blue	<= "10000000";
				when others =>
					null;
			end case;
		elsif (rising_edge(timer) and iter = '1') then
			case(v_state) is
				--Standby
				when "000" => 
					red 	<= "11111111";
					green 	<= "11111111";
					blue	<= "11111111";
	
				--Red
				when "001" =>
					red 	<= "11111111";
					green 	<= "00000000";
					blue	<= "00000000";
				--Yellow
				when "010" =>
					red 	<= "11111111";
					green 	<= "11111111";
					blue	<= "00000000";
				--Purple
				when "011" =>
					red 	<= "10000000";
					green 	<= "00000000";
					blue	<= "10000000";
				--Blue
				when "100" =>
					red 	<= "00000000";
					green 	<= "00000000";
					blue	<= "11111111";
				--Green
				when "101" =>
					red 	<= "00000000";
					green 	<= "11111111";
					blue	<= "00000000";
				when others =>
					null;
			end case;
		end if;
	end if;
end process;
end Behavioral;

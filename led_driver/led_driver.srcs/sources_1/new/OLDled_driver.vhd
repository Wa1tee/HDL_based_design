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
use IEEE.NUMERIC_STD.ALL;

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

	        red	 	: out std_logic_vector(7 downto 0);
           	green	: out std_logic_vector(7 downto 0);
	        blue 	: out std_logic_vector(7 downto 0));
    
end led_driver;

architecture Behavioral of led_driver is
	component timer
		Port ( 	
    			t_clk		: in STD_LOGIC;
				t_reset 	: in STD_LOGIC;
				t_alarm	: in STD_LOGIC;
				t_speed : in std_logic_vector(1 downto 0);
    			t_timer 	: out STD_LOGIC
    	);
	end component timer;

	signal t_clk : STD_LOGIC;
	signal t_reset : STD_LOGIC;
	signal t_alarm : STD_LOGIC;
	signal t_speed : std_logic_vector(1 downto 0);
	signal t_timer   : STD_LOGIC;

begin
	module : timer
	port map (
    	t_clk		=> t_clk,
		t_reset		=> t_reset,
    	t_alarm 	=> t_alarm,
    	t_speed 	=> t_speed,
    	t_timer 	=> t_timer
		);

--iterate : process (reset, clk)
--begin
--  if (reset = '1') then
    
--  elsif (rising_edge(clock)) then

--  end if;
--end process iterate;

process(clk, reset, iter, alarm, speed, t_timer)

variable v_speed : std_logic_vector(1 downto 0) := "11";
variable v_state : integer := 0;

begin
	
	t_clk <= clk;

	if(reset = '1') then
		t_reset <= '1';
		v_state := 0;
		t_speed <= "11";
		report "reset" severity note;
	elsif rising_edge(clk) then
		t_reset <= '0';
		v_speed := speed;
		t_alarm <= alarm;

		if (v_state = 0) then
			t_speed <= "11";
		else
			t_speed <= speed;
		end if;


		if (rising_edge(t_timer)) then
			if (v_state = 5) then
				v_state := 1;
			elsif (v_state = 0) then
				v_state := v_state + 1;
				--t_speed <= v_speed;
			else
				v_state := v_state + 1;
			end if;
		end if;

		if (iter = '0') then
			-- default loop	
			case(v_state) is
				--Standby
				when 0 => 
					red 	<= "11111111";
					green 	<= "11111111";
					blue	<= "11111111";
	
				--Red
				when 1 =>
					red 	<= "11111111";
					green 	<= "00000000";
					blue	<= "00000000";
				--Yellow
				when 2 =>
					red 	<= "11111111";
					green 	<= "11111111";
					blue	<= "00000000";
				--Green
				when 3 =>
					red 	<= "00000000";
					green 	<= "11111111";
					blue	<= "00000000";
				--Blue
				when 4 =>
					red 	<= "00000000";
					green 	<= "00000000";
					blue	<= "11111111";
				--Purple
				when 5 =>
					red 	<= "10000000";
					green 	<= "00000000";
					blue	<= "10000000";
				when others =>
					null;
			end case;
		elsif(iter = '1') then
			-- backwards loop
			case(v_state) is
				--Standby
				when 0 => 
					red 	<= "11111111";
					green 	<= "11111111";
					blue	<= "11111111";
				--Red
				when 1 =>
					red 	<= "11111111";
					green 	<= "00000000";
					blue	<= "00000000";
				--Yellow
				when 2 =>
					red 	<= "11111111";
					green 	<= "11111111";
					blue	<= "00000000";
				--Purple
				when 3 =>
					red 	<= "10000000";
					green 	<= "00000000";
					blue	<= "10000000";
				--Blue
				when 4 =>
					red 	<= "00000000";
					green 	<= "00000000";
					blue	<= "11111111";
				--Green
				when 5 =>
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

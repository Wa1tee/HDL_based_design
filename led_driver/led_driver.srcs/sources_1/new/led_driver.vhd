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
				t_alarm		: in STD_LOGIC;
				t_speed 	: in std_logic_vector(1 downto 0);
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

main : process (clk, reset, iter, alarm, speed, t_timer)
variable v_state : integer := 0;
begin
	t_clk 	<= clk;
	t_reset <= reset;
	t_alarm <= alarm;
	t_speed <= speed;

  if (reset = '1') then
	v_state := 0;

	--standby
	red 	<= "11111111";
	green 	<= "11111111";
	blue 	<= "11111111";
	
	report "reset" severity note;
  elsif (rising_edge(t_timer)) then
	v_state := v_state +1;


	if (v_state = 1) then
		red 	<= "11111111";
		green 	<= "00000000";
		blue	<= "00000000";
		report "state change" severity note;
	elsif (v_state = 2) then
		red 	<= "11111111";
		green 	<= "00000000";
		blue	<= "00000000";
		report "state change" severity note;
	elsif (v_state = 3) then
		red 	<= "00000000";
		green 	<= "11111111";
		blue	<= "00000000";
		report "state change" severity note;
	elsif (v_state = 4) then
		red 	<= "00000000";
		green 	<= "00000000";
		blue	<= "11111111";
		report "state change" severity note;
	elsif (v_state = 5) then
		red 	<= "10000000";
		green 	<= "00000000";
		blue	<= "10000000";	
		report "state change" severity note;
	end if;
	

  	--if (v_state = 1) then
  	--	v_state := 0;
  	--	red <= "00000000";
  	--else
  	--	v_state := 1;
  	--	red <= "11111111";
  	--end if;
  end if;

 -- case(v_state) is
	--	--Standby
	--	when 0 => 
	--		red 	<= "11111111";
	--		green 	<= "11111111";
	--		blue	<= "11111111";
	--	--Red
	--	when 1 =>
	--		red 	<= "11111111";
	--		green 	<= "00000000";
	--		blue	<= "00000000";
	--	--Yellow
	--	when 2 =>
	--		red 	<= "11111111";
	--		green 	<= "11111111";
	--		blue	<= "00000000";
	--	--Green
	--	when 3 =>
	--		red 	<= "00000000";
	--		green 	<= "11111111";
	--		blue	<= "00000000";
	--	--Blue
	--	when 4 =>
	--		red 	<= "00000000";
	--		green 	<= "00000000";
	--		blue	<= "11111111";
	--	--Purple
	--	when 5 =>
	--		red 	<= "10000000";
	--		green 	<= "00000000";
	--		blue	<= "10000000";
	--	when others =>
	--		v_state := 1;
			
	--end case;
end process main;
end Behavioral;

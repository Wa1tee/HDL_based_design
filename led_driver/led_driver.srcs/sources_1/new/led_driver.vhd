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

main : process (clk, reset, iter, alarm, speed)
variable v_state : integer := 0;
begin
	t_clk <= clk;
	t_reset <= reset;

  if (reset = '1') then
  	red <= "11111111";
  elsif (rising_edge(t_timer)) then
  	
  		if (v_state = 1) then
  			v_state := 0;
  			red <= "00000000";
  		else
  			v_state := 0;
  			red <= "11111111";
  		end if;
  	
  end if;
end process main;
end Behavioral;

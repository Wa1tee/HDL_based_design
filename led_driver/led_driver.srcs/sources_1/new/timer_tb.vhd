----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.10.2018 00:03:35
-- Design Name: 
-- Module Name: led_driver_tb - TB
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

entity timer_tb is
end timer_tb;

architecture tb of timer_tb is
component timer
		Port ( 	
    		t_clk		: in STD_LOGIC;
    		t_reset : in STD_LOGIC;
    		t_alarm	: in STD_LOGIC;
    		t_speed : in std_logic_vector(1 downto 0);
    		t_timer 	: out STD_LOGIC
    		);
end component timer;

--timer
signal t_clk	: STD_LOGIC;
signal t_reset 	: STD_LOGIC;
signal t_alarm	: STD_LOGIC;
signal t_speed 	: std_logic_vector(1 downto 0);
signal t_timer 	: STD_LOGIC;

begin

UUT: timer
	port map (
    	t_clk		=> t_clk,
		t_reset		=> t_reset,
    	t_alarm 	=> t_alarm,
    	t_speed 	=> t_speed,

    	t_timer 	=> t_timer
		);


clock : process
begin
    t_clk <= '1';
    wait for 5ns;
    t_clk <= '0';
    wait for 5ns;
end process clock;

timertest : process
begin
	t_reset <= '1';
	wait for 2ns;
	t_reset <= '0';
	wait for 2ns;

	t_speed <= "01";
	t_alarm <= '0';

	

	wait for 20000000ns;
end process timertest;
end tb;

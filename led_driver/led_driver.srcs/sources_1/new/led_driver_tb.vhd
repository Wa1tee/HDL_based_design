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

entity led_driver_tb is
end led_driver_tb;

architecture tb of led_driver_tb is
component led_driver
		Port ( 
			clk		: in STD_LOGIC;
    		reset 	: in STD_LOGIC;
           	iter  	: in STD_LOGIC;
           	alarm 	: in STD_LOGIC;
           	speed 	: in std_logic_vector(1 downto 0);

	        red	 	: out std_logic_vector(7 downto 0);
           	green	: out std_logic_vector(7 downto 0);
	        blue 	: out std_logic_vector(7 downto 0));
end component;


--driver
signal clk		: STD_LOGIC;
signal reset 	: STD_LOGIC;
signal iter  	: STD_LOGIC;
signal alarm 	: STD_LOGIC;
signal speed 	: std_logic_vector(1 downto 0);

signal red	 	: std_logic_vector(7 downto 0);
signal green	: std_logic_vector(7 downto 0);
signal blue 	: std_logic_vector(7 downto 0);



begin

DUT: led_driver 
	port map(
		clk		=> clk,
		reset	=> reset,
		iter 	=> iter,
		alarm	=> alarm,
		speed	=> speed,

		red 	=> red,
		green 	=> green,
		blue 	=> blue
	);




clock : process
begin
    clk <= '1';
    wait for 5ns;
    clk <= '0';
    wait for 5ns;
end process clock;

timertest : process
begin
	reset <= '1';
	wait for 10ns;
	reset <= '0';

	speed <= "00";
	iter <= '0';

	wait for 20000ms;
end process timertest;
end tb;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.10.2018 00:03:35
-- Design Name: 
-- Module Name: timer - Behavioral
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

entity timer is
    Port ( 	reset 		: in STD_LOGIC;
    		clk			: in STD_LOGIC;
    		alarm		: in STD_LOGIC;
    		speed 		: in std_logic_vector(1 downto 0)
    		);
    
end timer;

architecture Behavioral of timer is
	component led_driver
		Port (	timer 	: in STD_LOGIC; 
    			reset 	: in STD_LOGIC;
    	       	iter  	: in STD_LOGIC;
    	       	--alarm 	: in STD_LOGIC;
    	       	--speed 	: in std_logic_vector(1 downto 0);
				
				state	: in std_logic_vector(2 downto 0);
				
		        red	 	: out std_logic_vector(7 downto 0);
		        blue 	: out std_logic_vector(7 downto 0);
    	       	green	: out std_logic_vector(7 downto 0));
	end component led_driver;

variable v_time : std_logic_vector(7 downto 0) := "00000000";
variable v_speed : std_logic_vector(1 downto 0) := "00";
variable v_state : std_logic_vector(2 downto 0) := "000";

begin
	DUT : led_driver
	port map(
		timer => timer,
		reset => reset,
		iter  => iter,
		alarm => alarm,
		state => state,
		red	  => red,
		blue  => blue,
		green => green
	);

	if (reset = '1') then
		v_time := 0;
		state <= "000";
		v_state := "000";
	elsif (rising_edge(clk)) then
		case(speed) is
			-- color per second
			when "00" => 

			-- color per 3 seconds
			when "01" => 

			-- color per 5 seconds
			when "10" => 

			when others =>
				null;
		end case;
	end if;

end Behavioral;
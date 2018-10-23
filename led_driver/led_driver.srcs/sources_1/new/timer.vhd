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
    Port ( 	reset 	: in STD_LOGIC;
    		t_clk	: in STD_LOGIC;
    		alarm	: in STD_LOGIC;
    		speed 	: in std_logic_vector(1 downto 0),
    		timer 	: out STD_LOGIC
    		);
    
end timer;

architecture Behavioral of timer is
	
variable v_time : std_logic_vector(7 downto 0) := "00000000";
variable v_speed : std_logic_vector(1 downto 0) := "00";
variable v_state : std_logic_vector(2 downto 0) := "000";

begin
	

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
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity timer is
    Port ( 	
    		t_clk		: in STD_LOGIC;
    		t_reset 	: in STD_LOGIC;
    		t_alarm		: in STD_LOGIC;
    		t_speed 	: in std_logic_vector(1 downto 0);
    		t_timer 	: out STD_LOGIC
    		);
    
end timer;

architecture Behavioral of timer is
begin

process(t_clk, t_reset, t_alarm, t_speed)	

variable v_time  : integer;
variable v_alarm : integer;
variable v_trigger : STD_LOGIC;
variable v_speed : std_logic_vector(1 downto 0) := "00";
variable v_out : STD_LOGIC := '0';



begin


	if (t_reset = '1') then
		v_time := 0;
		v_alarm := 0;
		v_trigger := '0';
	elsif (rising_edge(t_clk)) then
		if (v_time = 5) then
			v_out := '1';
			--v_time := 0;
			v_time := v_time + 1;

		elsif (v_time = 10) then
			v_out := '0';
			v_time := v_time + 1;
		else
			v_time := v_time + 1;
		end if;
	end if;
	t_timer <= v_out;
end process;
end Behavioral;
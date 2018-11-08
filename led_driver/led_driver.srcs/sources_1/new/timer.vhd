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

variable v_time  : integer := 0;
variable v_alarm : STD_LOGIC := '0';
--variable v_trigger : STD_LOGIC;
variable v_speed : integer := 1;
variable v_out : STD_LOGIC := '0';
variable v_standby : STD_LOGIC := '0';



begin
	if (t_speed = "00") then
		--1s
		v_speed := 10;
	elsif (t_speed = "01") then
		--3s
		v_speed := 30;
	elsif (t_speed = "10") then
		--5s
		v_speed := 50;	
		
	end if;

	if (t_alarm = '1') then
		report "Timer alarm triggered" severity note;
		v_alarm := '1';
		v_standby := '0';

	end if;

	--if (v_alarm = '1') then
	--	if (v_time = 70) then
	--		v_alarm := '0';
	--	else
	--		v_time := v_time +1;
			
	--	end if;
	--end if;

	if (t_reset = '1') then
		v_time := 0;
		v_standby := '1';
		
		--v_trigger := '0';
	elsif (v_alarm ='1') then
		if (v_time = 70) then
			v_alarm := '0';
		else
			v_time := v_time +1;
			
		end if;
		t_timer <= t_clk;

	elsif (rising_edge(t_clk)) then
		--v_time := v_time +1;

		--alarm state

		--standby state
		if (v_standby = '1') then
			if (v_time = 4) then
				v_standby := '0';
				v_time := 0;
				v_out := '1';

			else
				v_time := v_time + 1;
				v_out := '0';
			end if;
		else
			if (v_time = v_speed) then
				v_time := 0;
				v_out := '1';
			else
				v_time := v_time +1;
				v_out := '0';
			end if;
		end if;

		t_timer <= v_out;

	end if;
end process;
end Behavioral;
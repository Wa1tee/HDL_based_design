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
    		t_reset : in STD_LOGIC;
    		t_alarm	: in STD_LOGIC;
    		t_speed : in std_logic_vector(1 downto 0);
    		t_timer 	: out STD_LOGIC
    		);
    
end timer;

architecture Behavioral of timer is
begin

process(t_clk, t_reset, t_alarm, t_speed, t_timer)	

variable v_time  : integer;
variable v_alarm : integer;
variable v_trigger : STD_LOGIC;
variable v_speed : std_logic_vector(1 downto 0) := "00";


begin

	if (t_reset = '1') then
		v_time := 0;
		v_alarm := 0;
		v_trigger := '0';
		v_time := 0;
	elsif (rising_edge(t_clk)) then
		if(t_alarm = '1') then
			v_alarm := 0;
			v_trigger := '1';
			v_time := 0;
		end if;

		if (v_trigger = '1' ) then
			v_alarm := v_alarm + 1;

			if (v_alarm = 700000000) then
				v_trigger := '0';
			end if;

			case(v_speed) is
				-- 4 second standby
				when "00" =>
					if (v_time = 40000000) then
						v_time := 0;
						t_timer <= '1';
					end if;
				-- color per second
				when "01" => 
					if (v_time = 10000000) then
						v_time := 0;
						t_timer <= '1';
					end if;
				-- color per 3 seconds
				when "10" => 
					if (v_time = 30000000) then
						v_time := 0;
						t_timer <= '1';
					end if;
				-- color per 5 seconds
				when "11" => 
					if (v_time = 50000000) then
						v_time := 0;
						t_timer <= '1';
					end if;
				
				when others =>
					t_timer <= 0;
			end case;
		end if;
		v_time := v_time + 1;
		--t_timer <= '0';
		case(v_speed) is
			-- 4 second standby
			when "00" =>
				if (v_time = 400000000) then
					v_time := 0;
					t_timer <= '1';
				end if;
			-- color per second
			when "01" => 
				if (v_time = 100000000) then
					v_time := 0;
					t_timer <= '1';
				end if;
			-- color per 3 seconds
			when "10" => 
				if (v_time = 300000000) then
					v_time := 0;
					t_timer <= '1';
				end if;
			-- color per 5 seconds
			when "11" => 
				if (v_time = 500000000) then
					v_time := 0;
					t_timer <= '1';
				end if;
			
			when others =>
				t_timer <= 0;
		end case;
	end if;
end process;
end Behavioral;
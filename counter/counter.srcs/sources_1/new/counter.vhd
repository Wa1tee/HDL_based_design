----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Antti Auranen
-- 
-- Create Date: 11.10.2018 09:47:28
-- Design Name: 
-- Module Name: counter - Behavioral
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

entity counter is
    Port ( clk		: in STD_LOGIC;
    	   reset 	: in STD_LOGIC;
           enable 	: in STD_LOGIC;
           load 	: in STD_LOGIC;
           down_up 	: in STD_LOGIC;
           data 	: in std_logic_vector (3 downto 0);
           count 	: out std_logic_vector (3 downto 0);
           over 	: out STD_LOGIC);
end counter;

architecture Behavioral of counter is

begin
process (clk, reset, enable, load, down_up, data)
	variable v_count : integer := 0;
	variable v_over  : std_logic;
begin
	if (reset = '1') then
		--resetting
		v_count := 0;
		v_over := '0';

	elsif (rising_edge(clk)) then

		if (enable = '1') then
			if (load = '1') then
				--load data
				v_count := to_integer(unsigned(data));
			else	
				case(down_up) is
					when '0' =>
						--counter up
						if (v_count = 15) then
							v_over := '1';
							v_count := 0;
						else
							v_count := v_count +1;
						end if;
					when others =>
					--counter down
						if (v_count = 0) then
							v_over := '1';
							v_count := 15;
						else
							v_count := v_count -1;
						end if;
				end case;
			end if;
		end if;
		
		over <= v_over;
		count <= std_logic_vector(to_unsigned(v_count, 4));
	end if;
end process;
end Behavioral;

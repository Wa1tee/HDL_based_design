----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Antti Auranen
-- 
-- Create Date: 17.10.2018 18:04:10
-- Design Name: 
-- Module Name: doublecounter - Behavioral
-- Project Name: HDL based design coursework
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

entity doublecounter is
    Port ( clk		: in STD_LOGIC;
    	   reset 	: in STD_LOGIC;
           enable 	: in STD_LOGIC;
           load 	: in STD_LOGIC;
           down_up 	: in STD_LOGIC;
           data 	: in std_logic_vector (7 downto 0);
           count_0 	: out std_logic_vector (3 downto 0);
           count_1 	: out std_logic_vector (3 downto 0);
           over 	: out STD_LOGIC);
end doublecounter;

architecture Behavioral of doublecounter is
begin


process (clk, reset, enable, load, down_up, data)
	variable v_count : integer := 0;
	--variable v_over  : std_logic;
	variable v_help  : std_logic_vector(7 downto 0);
begin
	if (reset = '1') then
		--resetting
		v_count := 0;
		count_0 <= "0000";
    	count_1 <= "0000";
    	over 	<= '0';
	elsif(rising_edge(clk)) then
		if (enable = '1') then
			if (load = '1') then
				--load data
				v_count := to_integer(unsigned(data));
			else	
				case(down_up) is
					when '0' =>
						--counter up
						if (v_count = 255) then
							over <= '1';
							v_count := 0;
						else
							v_count := v_count +1;
						end if;
					when others =>
						--counter down
						if (v_count = 0) then
							over <= '1';
							v_count := 255;
						else
							v_count := v_count -1;
						end if;
				end case;
			end if;
		end if;
	end if;
		
		v_help := std_logic_vector(to_unsigned(v_count, 8));
		count_0 <= v_help(7 downto 4);
		count_1 <= v_help(3 downto 0);
	
end process;
end Behavioral;

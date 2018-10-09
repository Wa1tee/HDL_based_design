----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.10.2018 19:01:45
-- Design Name: 
-- Module Name: bcd_2_bar_tb - Behavior
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

entity bcd_2_bar_tb is
end bcd_2_bar_tb;

architecture tb of bcd_2_bar is
	component bcd_2_bar
	port (
		bcd : in std_logic_vector (3 downto 0);
        bar_graph : out std_logic_vector (8 downto 0)
	);
	end component;

	signal test_bcd, test_bar : std_logic_vector;
begin
	DUT: bcd_2_bar port map (bcd => test_bcd, bar_graph => test_bar);

	process
	begin
		for i in 0 to 9 loop
			case i is
                when 0 =>
                test_bcd <= "0000";
                when 1 =>
                test_bcd <= "0001";
                when 2 =>
                test_bcd <= "0010";
                when 3 =>
                test_bcd <= "0011";
                when 4 =>
                test_bcd <= "0100";
                when 5 =>
                test_bcd <= "0101";
                when 6 =>
                test_bcd <= "0110";
                when 7 =>
                test_bcd <= "0111";
                when 8 =>
                test_bcd <= "1000";
                when 9 =>
                test_bcd <= "1001";
                when others => report "unreachable" severity failure;
            end case;
			wait for 20ns;
			
		end loop;
	end process;
end tb;
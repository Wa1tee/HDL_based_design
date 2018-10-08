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
--  Port ( );
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
		for i in std_logic_vector range "0000" to "1001" loop
			test_bcd <= i;
			wait for 10ns;
			assert test_bar
		end loop;
	end process;
end tb;

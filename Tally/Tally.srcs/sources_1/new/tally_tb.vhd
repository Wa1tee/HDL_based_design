----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.10.2018 14:33:34
-- Design Name: 
-- Module Name: tally_tb - Behavioral
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

entity tally_tb is
end tally_tb;

architecture tb of tally_tb is
	component tally
		 Port ( scoresA : in std_logic_vector (2 downto 0);
           		scoresB : in std_logic_vector (2 downto 0);
           		winner : out std_logic_vector (1 downto 0));
	end component;

	signal test_A : std_logic_vector (2 downto 0);
	signal test_B : std_logic_vector (2 downto 0);
	signal test_win : std_logic_vector (1 downto 0);

begin
	DUT: tally port map (scoresA => test_A, scoresB => test_B, winner => test_win);

	process
	begin
		for i in 0 to 7 loop
		 	for j in 0 to 7 loop
				test_A <= std_logic_vector(to_signed(i, 3));
				test_B <= std_logic_vector(to_signed(j, 3));
				wait for 10ns;
			end loop;
		end loop;
	end process;
end tb;

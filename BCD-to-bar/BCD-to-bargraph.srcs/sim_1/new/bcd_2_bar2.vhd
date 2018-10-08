----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.10.2018 18:02:08
-- Design Name: 
-- Module Name: bcd_2_bar2 - Behavioral
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

entity bcd_2_bar2 is
    Port ( bcd : in std_logic_vector (3 downto 0);
           bar_graph : out std_logic_vector (8 downto 0));
end bcd_2_bar2;

architecture Behavioral of bcd_2_bar2 is

begin
	process(bcd)
	begin
		bar_graph <= 	"111111111" when bcd = "0000" else
		 				"111111110" when bcd = "0001" else
		 				"111111100" when bcd = "0010" else
		 				"111111000" when bcd = "0011" else
		 				"111110000" when bcd = "0100" else
		 				"111100000" when bcd = "0101" else
		 				"111000000" when bcd = "0110" else
		 				"110000000" when bcd = "0111" else
		 				"100000000" when bcd = "1000" else
		 				"000000000" when bcd = "1001";
	end process;


end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.10.2018 14:33:34
-- Design Name: 
-- Module Name: tally - Behavioral
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

entity tally is
    Port ( scoresA : in std_logic_vector (2 downto 0);
           scoresB : in std_logic_vector (2 downto 0);
           winner : out std_logic_vector (1 downto 0));
end tally;

architecture Behavioral of tally is

begin
process (scoresA, scoresB)
begin
	case(scoresA) is
		when "000" => 
			case(scoresB) is
				when "000" => winner <= "00";
				when others => winner <= "10";
			end case;
		when "100" =>
			case(scoresB) is
				when "000" => winner <= "01"; 
				when "100" => winner <= "11";
				when "010" => winner <= "11";
				when "001" => winner <= "11";
				when others => winner <= "10";
 			end case;
 		when "010" =>
			case(scoresB) is
				when "000" => winner <= "01"; 
				when "100" => winner <= "11";
				when "010" => winner <= "11";
				when "001" => winner <= "11";
				when others => winner <= "10";
 			end case;
 		when "001" =>
			case(scoresB) is
				when "000" => winner <= "01"; 
				when "100" => winner <= "11";
				when "010" => winner <= "11";
				when "001" => winner <= "11";
				when others => winner <= "10";
 			end case;
 		when "011" =>
			case(scoresB) is
				when "110" => winner <= "11";
				when "101" => winner <= "11";
				when "011" => winner <= "11";
				when "111" => winner <= "10";
				when others => winner <= "01";
 			end case;
 		when "101" =>
			case(scoresB) is
				when "110" => winner <= "11";
				when "101" => winner <= "11";
				when "011" => winner <= "11";
				when "111" => winner <= "10";
				when others => winner <= "01";
 			end case;
 		when "110" =>
			case(scoresB) is
				when "110" => winner <= "11";
				when "101" => winner <= "11";
				when "011" => winner <= "11";
				when "111" => winner <= "10";
				when others => winner <= "01";
 			end case;
 		when "111" =>
			case(scoresB) is
				when "111" => winner <= "11";
				when others => winner <= "01";
 			end case;
 		when others => winner <= "00";
	end case;
end process;
end Behavioral;

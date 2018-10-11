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
--variable sumA : natural range 0 to 3 := 0;
--variable sumB : natural range 0 to 3 := 0;
begin
	
	--for i in 0 to 2 loop
	--	if scoresA(i) = '1' then
	--		sumA := sumA + 1;
	--	end if;
		
	--end loop;

	--sumB := 0;
	--for j in 0 to 2 loop
	--	if scoresB(j) = '1' then
	--		sumB := sumB + 1;
	--	end if;
		
	--end loop;

	--if (sumA = 0 and sumB = 0) then
	--	winner <= "00";
	--elsif (sumA > sumB) then
	--	winner <= "01";
	--elsif (sumA < sumB) then
	--	winner <= "10";
	--elsif (sumA = sumB) then
	--	winner <= "11";
	--end if;
	
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

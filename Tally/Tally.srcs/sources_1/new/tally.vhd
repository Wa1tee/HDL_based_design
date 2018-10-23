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
	variable v_A : integer := 0;
	variable v_B : integer := 0;
begin
	v_B := 0;
	v_A := 0;
	for i in 0 to 2 loop
		if (scoresA(i) = '1') then
			v_A := v_A + 1;
		end if;
	end loop;

	for i in 0 to 2 loop
		if (scoresB(i) = '1') then
			v_B := v_B + 1;
		end if;
	end loop;

	if (v_B = 0 and v_A = 0) then
		winner <= "00";
	elsif (v_B = v_A) then
		winner <= "11";
	elsif (v_A > v_B) then
		winner <= "10";
	elsif (v_A < v_B) then
		winner <= "01";
	end if;
end process;
end Behavioral;

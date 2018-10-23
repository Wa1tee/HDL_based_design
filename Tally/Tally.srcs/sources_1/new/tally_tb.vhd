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

	function result (signal A, B : std_logic_vector(2 downto 0)) return std_logic_vector is
	--variable v_A, v_B : integer := 0;
	begin
		--for i in 0 to 2 loop
		--	if (scoresA(i) = '1') then
		--		v_A := v_A + 1;
		--	end if;
		--end loop;
	
		--for i in 0 to 2 loop
		--	if (scoresB(i) = '1') then
		--		v_B := v_B + 1;
		--	end if;
		--end loop;
	
		--if (v_B = 0 and v_A = 0) then
		--	winner <= "00";
		--elsif (v_B = v_A) then
		--	winner <= "11";
		--elsif (v_A > v_B) then
		--	winner <= "10";
		--elsif (v_A < v_B) then
		--	winner <= "01";
		--end if;

		case(A) is
			when "000" => 
				case(B) is
					when "000" 	=> return "00";
					when others => return "01";
				end case;
			when "100" =>
				case(B) is
					when "000" 	=> return "01";
					when "100" 	=> return "11";
					when "010" 	=> return "11";
					when "001" 	=> return "11";
					when others => return "10";
	 			end case;
	 		when "010" =>
				case(B) is
					when "000" 	=> return "01";
					when "100" 	=> return "11";
					when "010" 	=> return "11";
					when "001" 	=> return "11";
					when others => return "10";
	 			end case;
	 		when "001" =>
				case(B) is
					when "000" 	=> return "01";
					when "100" 	=> return "11";
					when "010" 	=> return "11";
					when "001" 	=> return "11";
					when others => return "10";
	 			end case;
	 		when "011" =>
				case(B) is
					when "110" 	=> return "11";
					when "101" 	=> return "11";
					when "011" 	=> return "11";
					when "111" 	=> return "10";
					when others => return "01";
	 			end case;
	 		when "101" =>
				case(B) is
					when "110" 	=> return "11";
					when "101" 	=> return "11";
					when "011" 	=> return "11";
					when "111" 	=> return "10";
					when others => return "01";
	 			end case;
	 		when "110" =>
				case(B) is
					when "110" 	=> return "11";
					when "101" 	=> return "11";
					when "011" 	=> return "11";
					when "111" 	=> return "10";
					when others => return "01";
	 			end case;
	 		when "111" =>
				case(B) is
					when "111" 	=> return "11";
					when others => return "01";
	 			end case;
	 		when others => return "00";
		end case;
	end result;

	signal scoresA : std_logic_vector (2 downto 0);
	signal scoresB : std_logic_vector (2 downto 0);
	signal winner : std_logic_vector (1 downto 0);

begin
	DUT: tally port map (scoresA => scoresA, scoresB => scoresB, winner => winner);

	process
	begin
		for i in 0 to 7 loop
		 	for j in 0 to 7 loop
				scoresA <= std_logic_vector(to_signed(i, 3));
				scoresB <= std_logic_vector(to_signed(j, 3));
				wait for 1ns;
				assert result(scoresA, scoresB) = winner report "Error" severity error;
			end loop;
		end loop;
		wait for 200ns;
	end process;
end tb;

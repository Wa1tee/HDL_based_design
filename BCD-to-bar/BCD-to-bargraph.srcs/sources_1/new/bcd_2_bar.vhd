----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.10.2018 16:06:39
-- Design Name: 
-- Module Name: bcd_2_bar - Behavioral
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

entity bcd_2_bar is
    Port ( bcd : in std_logic_vector (3 downto 0);
           bar_graph : out std_logic_vector (8 downto 0)
    );
end bcd_2_bar;

architecture Behavioral of bcd_2_bar is

begin
process(bcd)
begin
    case bcd is
        when "0000" =>
        bar_graph <= "111111111";
        when "0001" =>
        bar_graph <= "111111110";
        when "0010" =>
        bar_graph <= "111111100";
        when "0011" =>
        bar_graph <= "111111000";
        when "0100" =>
        bar_graph <= "111110000";
        when "0101" =>
        bar_graph <= "111100000";
        when "0110" =>
        bar_graph <= "111000000";
        when "0111" =>
        bar_graph <= "110000000";
        when "1000" =>
        bar_graph <= "100000000";
        when "1001" =>
        bar_graph <= "000000000";
        when others => report "unreachable" severity failure;
    end case;
end process;

end Behavioral;

--architecture Behavioral of bcd_2_bar is

--begin
--    process (bcd)
--    begin
--        bar_graph <=    "111111111" when bcd = "0000";
--        bar_graph <=    "111111110" when bcd = "0001";
--        bar_graph <=    "111111100" when bcd = "0010";
--        bar_graph <=    "111111000" when bcd = "0011";
--        bar_graph <=    "111110000" when bcd = "0100";
--        bar_graph <=    "111100000" when bcd = "0101";
--        bar_graph <=    "111000000" when bcd = "0110";
--        bar_graph <=    "110000000" when bcd = "0111";
--        bar_graph <=    "100000000" when bcd = "1000";
--        bar_graph <=    "000000000" when bcd = "1001";
        
--    end process;


--end Behavioral;
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bcd_2_bar_tb is
end bcd_2_bar_tb;

architecture tb of bcd_2_bar is
  component bcd_2_bar
    port (
      bcd        : in std_logic_vector (3 downto 0);
      bar_graph  : out std_logic_vector (8 downto 0)
    );
  end component;

  signal test_bcd : std_logic_vector (3 downto 0);
  signal test_bar : std_logic_vector (8 downto 0);

begin
  DUT: bcd_2_bar port map (bcd => test_bcd, bar_graph => test_bar);

  process
  begin
    for i in 0 to 15 loop
      test_bcd <= "0000" + std_logic_vector(to_unsigned(i, 4));
      wait for 20ns;
      for j in 0 to 9 loop
        case j is
          when 0 =>
          assert test_bar = "111111111" report "error" severity error;
          when 1 =>
          assert test_bar = "111111110" report "error" severity error;
          when 2 =>
          assert test_bar = "111111100" report "error" severity error;
          when 3 =>
          assert test_bar = "111111000" report "error" severity error;
          when 4 =>
          assert test_bar = "111110000" report "error" severity error;
          when 5 =>
          assert test_bar = "111100000" report "error" severity error;
          when 6 =>
          assert test_bar = "111000000" report "error" severity error;
          when 7 =>
          assert test_bar = "110000000" report "error" severity error;
          when 8 =>
          assert test_bar = "100000000" report "error" severity error;
          when 9 =>
          assert test_bar = "000000000" report "error" severity error;
          when others => report "unreachable" severity error;
        end case;
      end loop;
        
    end loop;
  end process;
end tb;

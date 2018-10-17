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

architecture tb of bcd_2_bar_tb is
  component bcd_2_bar
    port (
      bcd        : in std_logic_vector (3 downto 0);
      bar_graph  : out std_logic_vector (8 downto 0)
    );
  end component;

  signal test_bcd : std_logic_vector (3 downto 0) := (others => '0');
  signal test_bar : std_logic_vector (8 downto 0);

begin
  DUT: bcd_2_bar port map (bcd => test_bcd, bar_graph => test_bar);

  process
  begin
    for i in 0 to 15 loop
      test_bcd <= std_logic_vector(to_signed(i, 4));
      wait for 20ns;
      case(std_logic_vector(to_signed(i, 4))) is
              when "0000" => assert test_bar = "111111111" report "Error" severity error;
              when "0001" => assert test_bar = "111111110" report "Error" severity error;
              when "0010" => assert test_bar = "111111100" report "Error" severity error;
              when "0011" => assert test_bar = "111111000" report "Error" severity error;
              when "0100" => assert test_bar = "111110000" report "Error" severity error;
              when "0101" => assert test_bar = "111100000" report "Error" severity error;
              when "0110" => assert test_bar = "111000000" report "Error" severity error;
              when "0111" => assert test_bar = "110000000" report "Error" severity error;
              when "1000" => assert test_bar = "100000000" report "Error" severity error;
              when "1001" => assert test_bar = "000000000" report "Error" severity error;
              when others =>
                null;
      end case;      
    end loop;
  end process;
end tb;

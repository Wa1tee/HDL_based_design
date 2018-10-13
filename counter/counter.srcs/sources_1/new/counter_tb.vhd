----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.10.2018 09:47:28
-- Design Name: 
-- Module Name: counter_tb - Behavioral
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

entity counter_tb is
end counter_tb;

architecture tb of counter_tb is
	component counter 
		Port ( clk      : in STD_LOGIC;
           reset    : in STD_LOGIC;
           enable   : in STD_LOGIC;
           load     : in STD_LOGIC;
           down_up  : in STD_LOGIC;
           data     : in std_logic_vector (15 downto 0);
           count    : out std_logic_vector (15 downto 0);
           overflow : out STD_LOGIC);
	end component;

  --Inputs
  signal test_clk     : in STD_LOGIC;
  signal test_reset   : in STD_LOGIC;
  signal test_enable  : in STD_LOGIC;
  signal test_load    : in STD_LOGIC;
  signal test_down_up : in STD_LOGIC;
  signal test_data    : in std_logic_vector (15 downto 0);

  --Outputs
  signal test_count     : out std_logic_vector (15 downto 0);
  signal test_overflow  : out STD_LOGIC;
begin
  DUT: counter port map (
      clk       => test_clk,
      reset     => test_reset, 
      enable    => test_enable, 
      load      => test_load,
      down_up   => test_down_up,
      data      => test_data,
      count     => test_count,
      overflow  => test_overflow );

  process
  v_clk : STD_LOGIC;
  v_testcount : std_logic_vector(15 downto 0) := '0';
  begin
    t_enable : for i in 0 to 2 loop
      test_enable <= 0;
      --generate clock signal (does it work like this lol?)
      if (v_clk = 0) then
        v_clk := 1;
        test_clk <= v_clk;
      else
        v_clk := 0;
        test_clk <= v_clk;  
      end if;

      -- test cases where the count output should be "0000000000000000"
      case(i) is
        when 0 => 
          test_data <= "1010101010101010";
          test_load <= 1;
          wait for 20ns;
          assert test_count = "0000000000000000" report "test_enable failed at 0" severity error;
          assert test_overflow = 0 report "test_enable overflow failed at 0" severity error;

        when 1 =>
          test_down_up <= 0;
          wait for 20ns;
          assert test_count = "0000000000000000" report "test_enable failed at 1" severity error;
          assert test_overflow = 0 report "test_enable overflow failed at 1" severity error;

        when 2 =>
          test_down_up <= 1;
          wait for 20ns;
          assert test_count = "0000000000000000" report "test_enable failed at 2" severity error;
          assert test_overflow = 0 report "test_enable overflow failed at 2" severity error;

        when others =>
          assert false report "test_enable shouldn't get here" severity failure;
      end case;
    end loop;

    t_counting : for i in 0 to 15 loop
      test_enable <= 1;
      --generate clock signal (does it work like this?(probably not, google and fix later lol))

      if (v_clk = 0) then
        v_clk := 1;
        test_clk <= v_clk;
      else
        v_clk := 0;
        test_clk <= v_clk;  
      end if;
    
      test_down_up <= 1;
      v_testcount := v_testcount + std_logic_vector(to_signed(1, 16));
      wait for 20ns;
      assert test_count = v_testcount; report "counting up failed" severity error;
    end loop;

  end process;
end tb;

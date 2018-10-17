----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Antti Auranen
-- 
-- Create Date: 17.10.2018 18:04:10
-- Design Name: 
-- Module Name: doublecounter_tb - Behavioral
-- Project Name: HDL based design coursework
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

use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity doublecounter_tb is
end doublecounter_tb;

architecture tb of doublecounter_tb is
	component doublecounter 
		Port ( clk      : in STD_LOGIC;
           reset    : in STD_LOGIC;
           enable   : in STD_LOGIC;
           load     : in STD_LOGIC;
           down_up  : in STD_LOGIC;
           data     : in std_logic_vector (7 downto 0);
           count_0  : out std_logic_vector (3 downto 0);
           count_1  : out std_logic_vector (3 downto 0);
           overflow : out STD_LOGIC);
	end component;

  --Inputs
  --signal test_clk     : in STD_LOGIC := '0';
  signal test_reset   : in STD_LOGIC;
  signal test_enable  : in STD_LOGIC;
  signal test_load    : in STD_LOGIC;
  signal test_down_up : in STD_LOGIC;
  signal test_data    : in std_logic_vector (7 downto 0);

  --Outputs
  signal test_count_0     : out std_logic_vector (3 downto 0);
  signal test_count_1     : out std_logic_vector (3 downto 0);
  signal test_overflow  : out STD_LOGIC;
begin
  DUT: counter port map (
      clk       => test_clk,
      reset     => test_reset, 
      enable    => test_enable, 
      load      => test_load,
      down_up   => test_down_up,
      data      => test_data,
      count_0   => test_count_0,
      count_1   => test_count_1,
      overflow  => test_overflow );

  clock:process
  begin
    clk <= '1';
    wait for 10ns;
    clk <= '0';
    wait for 10ns;
  end process clock;

  test:process
  
  variable v_testcount : std_logic_vector(3 downto 0);

  begin
    t_enable : for i in 0 to 2 loop
      test_enable <= '0';
      -- test cases where the count output should be "0000"
      case(i) is
        when 0 => 
          test_data <= "1010";
          test_load <= '1';
          wait for 20ns;
          assert test_count_0 = "0000" report "test_enable failed at 0" severity error;
          assert test_count_1 = "0000" report "test_enable failed at 0" severity error;
          assert test_overflow = '0' report "test_enable overflow failed at 0" severity error;

        when 1 =>
          test_down_up <= '0';
          wait for 20ns;
          assert test_count_0 = "0000" report "test_enable failed at 1" severity error;
          assert test_count_1 = "0000" report "test_enable failed at 1" severity error;
          assert test_overflow = '0' report "test_enable overflow failed at 1" severity error;

        when 2 =>
          test_down_up <= '1';
          wait for 20ns;
          assert test_count_0 = "0000" report "test_enable failed at 2" severity error;
          assert test_count_1 = "0000" report "test_enable failed at 2" severity error;
          assert test_overflow = '0' report "test_enable overflow failed at 2" severity error;

        when others =>
          assert false report "test_enable shouldn't get here" severity failure;
      end case;
    end loop;

    --count up 0 through 15
    v_testcount <= std_logic_vector(to_signed(0, 4));
    for i in 0 to 15 loop
      test_enable <= '1';
      
      test_down_up <= '1';
      v_testcount := v_testcount + std_logic_vector(to_signed(1, 4));
      wait for 20ns;
      assert test_count_0 = v_testcount report "counting up failed" severity error;
      assert test_overflow = '0' report "overflow counting up" severity error;
    end loop;

    --count down 15 through 0
    test_count  <= std_logic_vector(to_signed(15, 4));
    v_testcount <= std_logic_vector(to_signed(15, 4));
    for i in 0 to 15 loop
      test_enable <= '1';
    
      test_down_up <= '0';
      v_testcount := v_testcount - std_logic_vector(to_signed(1, 4));
      wait for 20ns;
      assert test_count_0 = v_testcount report "counting down failed" severity error;
      assert test_overflow = '0' report "overflow counting down" severity error;
    end loop;

    --test reset
    --count up 0 through 15
    test_count <= std_logic_vector(to_signed(0, 4));
    v_testcount <= std_logic_vector(to_signed(0, 4));
    for i in 0 to 15 loop
      test_enable <= '1';
      test_data <= std_logic_vector(to_signed(i, 4));
      wait for 20ns;
      
      test_load <= '1';
      wait for 20ns;
      assert test_count_0 = std_logic_vector(to_signed(i, 4)) report "data loading failed" severity error;

      test_reset <= '1';
      wait for 20ns;
      assert test_count_0 = "0000" report "reset failed counting up" severity error;
    end loop;

    --count down 15 through 0
    for i in 15 downto 0 loop
      test_enable <= '1';

      test_data <= std_logic_vector(to_signed(i, 4));
      wait for 20ns;
      
      test_load <= '1';
      wait for 20ns;
      assert test_count_0 = std_logic_vector(to_signed(i, 4)) report "data loading failed" severity error;

      test_reset <= '1';
      wait for 20ns;
      assert test_count_0 = "0000" report "reset failed counting up" severity error;
    end loop;


    --test overflow
    test_enable <= '1';
    test_data <= std_logic_vector(to_signed(15, 4));
    wait for 20ns;
    test_load <= '1';
    test_down_up <= '1';
    wait for 15ns;
    assert test_overflow = '1' report "overflow failed" severity error;

    --test underflow
    test_data <= std_logic_vector(to_signed(0, 4));
    wait for 20ns;
    test_load <= '1';
    test_down_up <= '0';
    wait for 15ns;
    assert test_overflow = '1' report "overflow failed" severity error;

  end process test;
end tb;

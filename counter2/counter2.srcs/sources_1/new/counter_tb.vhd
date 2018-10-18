
-- Company: 
-- Engineer: Antti Auranen
-- 
-- Create Date: 11.10.2018 09:47:28
-- Design Name: 
-- Module Name: counter_tb - Behavioral
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
           data     : in std_logic_vector (3 downto 0);
           count    : out std_logic_vector (3 downto 0);
           overflow : out STD_LOGIC);
	end component;

  --Inputs
  signal clk     :  STD_LOGIC := '0';
  signal reset   :  STD_LOGIC := '0';
  signal enable  :  STD_LOGIC := '0';
  signal load    :  STD_LOGIC := '0';
  signal down_up :  STD_LOGIC := '0';
  signal data    :  std_logic_vector (3 downto 0);

  --Outputs
  signal count     : std_logic_vector (3 downto 0);
  signal overflow  : STD_LOGIC;
begin
  DUT: counter port map (
      clk       => clk,
      reset     => reset, 
      enable    => enable, 
      load      => load,
      down_up   => down_up,
      data      => data,
      count     => count,
      overflow  => overflow );

  clock : process
  begin
    clk <= '1';
    wait for 10ns;
    clk <= '0';
    wait for 10ns;
  end process clock;


  test : process
  
  variable v_testcount : std_logic_vector(3 downto 0);

  begin
    report "Test begin" severity note;
      
    for i in 0 to 2 loop
      enable <= '0';
      -- test cases where the count output should be "0000"
      case(i) is
        when 0 => 
          data <= "1010";
          load <= '1';
          wait for 10ns;
          assert count = "0000" report "enable failed at 0" severity error;
          
          assert overflow = '0' report "enable overflow failed at 0" severity error;

        when 1 =>
          down_up <= '0';
          wait for 10ns;
          assert count = "0000" report "enable failed at 1" severity error;
          
          assert overflow = '0' report "enable overflow failed at 1" severity error;

        when 2 =>
          down_up <= '1';
          wait for 10ns;
          assert count = "0000" report "enable failed at 2" severity error;
          assert overflow = '0' report "enable overflow failed at 2" severity error;

        when others =>
          assert false report "enable shouldn't get here" severity failure;
      end case;
    end loop;

    --count up 0 through 15
    v_testcount := std_logic_vector(to_signed(0, 4));
    for i in 0 to 15 loop
      enable <= '1';
      
      down_up <= '1';
      if (v_testcount = "1111") then
        assert false report "Loop too long" severity failure;
      end if;
      v_testcount := v_testcount + "0001";
      wait for 10ns;
      assert count = v_testcount report "counting up failed" severity error;
      assert overflow = '0' report "overflow counting up" severity error;
    end loop;

    --count down 15 through 0
    count  <= std_logic_vector(to_signed(15, 4));
    v_testcount := std_logic_vector(to_signed(15, 4));
    for i in 0 to 15 loop
      enable <= '1';
    
      down_up <= '0';
      v_testcount := v_testcount - std_logic_vector(to_signed(1, 4));
      wait for 10ns;
      assert count = v_testcount report "counting down failed" severity error;
      assert overflow = '0' report "overflow counting down" severity error;
    end loop;

    --test reset
    --count up 0 through 15
    count <= std_logic_vector(to_signed(0, 4));
    v_testcount := std_logic_vector(to_signed(0, 4));
    for i in 0 to 15 loop
      enable <= '1';
      data <= std_logic_vector(to_signed(i, 4));
      wait for 10ns;
      
      load <= '1';
      wait for 10ns;
      assert count = std_logic_vector(to_signed(i, 4)) report "data loading failed" severity error;

      reset <= '1';
      wait for 10ns;
      assert count = "0000" report "reset failed counting up" severity error;
    end loop;

    --count down 15 through 0
    for i in 15 downto 0 loop
      enable <= '1';

      data <= std_logic_vector(to_signed(i, 4));
      wait for 10ns;
      
      load <= '1';
      wait for 10ns;
      assert count = std_logic_vector(to_signed(i, 4)) report "data loading failed" severity error;

      reset <= '1';
      wait for 10ns;
      assert count = "0000" report "reset failed counting up" severity error;
    end loop;


    --test overflow
    enable <= '1';
    data <= std_logic_vector(to_signed(15, 4));
    wait for 10ns;
    load <= '1';
    down_up <= '1';
    wait for 15ns;
    assert overflow = '1' report "overflow failed" severity error;

    --test underflow
    data <= std_logic_vector(to_signed(0, 4));
    wait for 10ns;
    load <= '1';
    down_up <= '0';
    wait for 15ns;
    assert overflow = '1' report "overflow failed" severity error;

    report "Test finished" severity note;
  end process test;
end tb;

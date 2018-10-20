
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
           over     : out STD_LOGIC);
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
  signal over  : STD_LOGIC;
begin
  DUT: counter port map (
      clk       => clk,
      reset     => reset, 
      enable    => enable, 
      load      => load,
      down_up   => down_up,
      data      => data,
      count     => count,
      over  => over );

  clock : process
  begin
    clk <= '1';
    wait for 10ns;
    clk <= '0';
    wait for 10ns;
  end process clock;


  test : process
  
  variable v_testcount : integer := 0;

  begin
    report "Test begin" severity note;

    down_up <= '0';
    enable <= '1';
    wait for 20ns;
    enable <= '0';

    reset <= '1';
    wait for 20ns;
    reset <= '0';
    wait for 20ns;
    assert count = "0000" report "First reset not working" severity error;

    enable <= '0';
    data <= "0101";
    load <= '1';
    wait for 10ns;
    assert count = "0000" report "enable 0 failed" severity error;

    load <= '0';

    down_up <= '0';
    wait for 10ns;
    assert count = "0000" report "enable 0 failed" severity error;

    down_up <= '1';
    wait for 10ns;
    assert count = "0000" report "enable 0 failed" severity error;

    down_up <= '0';
    wait for 10ns;

    enable <= '1';
    for i in 0 to 15 loop
        assert count = std_logic_vector(to_unsigned(i,4)) report "Counting up failed" severity error;
        wait for 20ns;
    end loop;

    down_up <= '1';
    data <= "1111";
    load <= '1';
    wait for 20ns;
    load <= '0';

    for i in 0 to 15 loop
        assert count = std_logic_vector(to_unsigned((15-i),4)) report "Counting down failed" severity error;
        wait for 20ns;
    end loop;

    for i in 0 to 15 loop
      data <= std_logic_vector(to_unsigned(i,4));
      load <= '1';
      wait for 20ns;
      load <= '0';
      assert count = std_logic_vector(to_unsigned(i,4)) report "Loading failed" severity error;
      reset <= '1';
      wait for 20ns;
      reset <= '0';
    end loop;

    data <= "1111";
    load <= '1';
    wait for 10ns;
    load <= '0';
    down_up <= '0';
    wait for 10ns;
    assert count = "0000" report "overflow count failed" severity error;
    assert over = '1' report "overflow failed" severity error;

    reset <= '1';
    wait for 10ns;
    reset <= '0';

    down_up <= '1';
    data <= "0000";
    load <= '1';
    wait for 10ns;
    load <= '0';
    wait for 10ns;

    assert count = "1111" report "underflow count failed" severity error;
    assert over = '1' report "underflow failed" severity error;
    report "Test finished" severity note;
  end process test;
end tb;

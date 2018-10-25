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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity doublecounter_tb is
end doublecounter_tb;

architecture tb of doublecounter_tb is
	component doublecounter 
		Port ( clk 		 : in STD_LOGIC;
           		reset    : in STD_LOGIC;
           		enable   : in STD_LOGIC;
           		load     : in STD_LOGIC;
           		down_up  : in STD_LOGIC;
           		data     : in std_logic_vector (7 downto 0);
           		count_0  : out std_logic_vector (3 downto 0);
           		count_1  : out std_logic_vector (3 downto 0);
           		over 	 : out STD_LOGIC);
	end component;

  --Inputs
  signal clk     : STD_LOGIC;
  signal reset   : STD_LOGIC;
  signal enable  : STD_LOGIC;
  signal load    : STD_LOGIC;
  signal down_up : STD_LOGIC;
  signal data    : std_logic_vector (7 downto 0);

  --Outputs
  signal count_0	: std_logic_vector (3 downto 0);
  signal count_1    : std_logic_vector (3 downto 0);
  signal over  		: STD_LOGIC;
begin
  DUT: doublecounter port map (
      clk       => clk,
      reset     => reset, 
      enable    => enable, 
      load      => load,
      down_up   => down_up,
      data      => data,
      count_0   => count_0,
      count_1   => count_1,
      over  	=> over );

  clock : process
  begin
    clk <= '1';
    wait for 5ns;
    clk <= '0';
    wait for 5ns;
  end process clock;

  test : process
  variable help : std_logic_vector(7 downto 0);
  begin
  	report "Test begin" severity note;

  	down_up <= '0';
  	enable <= '1';
  	wait for 2ns;
  	enable <= '0';

    reset <= '1';
    wait for 2ns;
    reset <= '0';
    wait for 2ns;
    assert count_1 = "0000" report "First reset not working for count_1" severity error;
    assert count_0 = "0000" report "First reset not working for count_0" severity error;

    enable <= '0';
    data <= "01010101";
    load <= '1';
    wait for 2ns;
    assert count_1 = "0000" report "enable 0 failed" severity error;
    assert count_0 = "0000" report "enable 0 failed" severity error;

    load <= '0';

    down_up <= '0';
    wait for 2ns;
    assert count_1 = "0000" report "enable 0 failed" severity error;
    assert count_0 = "0000" report "enable 0 failed" severity error;

    down_up <= '1';
    wait for 2ns;
    assert count_1 = "0000" report "enable 0 failed" severity error;
    assert count_0 = "0000" report "enable 0 failed" severity error;

    down_up <= '0';
    wait for 2ns;

    --count up
    enable <= '1';
    for i in 0 to 255 loop
        help := std_logic_vector(to_unsigned(i, 8));

        assert count_0 = help(7 downto 4) report "Counting 0 up failed at i:" & integer'image(i) severity error;
        
        assert count_1 = help(3 downto 0) report "Counting 1 up failed at i:" & integer'image(i)  severity error;
        
        wait for 10ns;
    end loop;


    down_up <= '1';
    data <= "11111111";
    load <= '1';
    wait for 2ns;
    load <= '0';

    --count down
	for i in 0 to 255 loop
        help := std_logic_vector(to_unsigned(255 - i, 8));

        assert count_0 = help(7 downto 4) report "Counting 0 down failed at i:" & integer'image(i) severity error;
        
        assert count_1 = help(3 downto 0) report "Counting 1 down failed at i:" & integer'image(i) severity error;
        
        wait for 10ns;
    end loop;

    --loading data
    
      data <= "01010101";
      load <= '1';
      wait for 10ns;
      load <= '0';

      assert count_0 = "0101" report "Data loading failed" severity error;
      assert count_1 = "0101" report "Data loading failed" severity error;
      
     
    

    --overflow test

    data <= "11111111";
    down_up <= '0';

    load <= '1';
    wait for 1ns;
    load <= '0';
    
    wait for 1ns;
    assert count_1 = "0000" report "overflow count failed" severity error;
    assert count_0 = "0000" report "overflow count failed" severity error;
    assert over = '1' report "overflow failed" severity error;

    data <= "00000000";
    down_up <= '1';

    load <= '1';
    wait for 1ns;
    load <= '0';

    wait for 1ns;
    assert count_1 = "1111" report "underflow count failed" severity error;
    assert count_0 = "1111" report "underflow count failed" severity error;
    assert over = '1' report "underflow failed" severity error;

    report "Test finished" severity note;
  end process test;
end tb;

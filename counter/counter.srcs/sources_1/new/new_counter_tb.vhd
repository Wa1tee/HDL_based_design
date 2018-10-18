
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

  clockp : process
  begin
    wait for 10ns;
    clk <= not clk;
  end process clockp;


  test : process
  
  variable v_testcount : std_logic_vector(3 downto 0);

  begin

    report "test begin" severity note;

    wait until clk = 1;
    wait until clk = 0;

    enable <= '0';
    wait for rising_edge(clk);
    data <= "1010";
    load <= '1';
    wait for 10ns;
    assert count = "0000" report "enable failed" severity error;
    assert overflow = '0' report "error" severity error;

  end process test;
end tb;
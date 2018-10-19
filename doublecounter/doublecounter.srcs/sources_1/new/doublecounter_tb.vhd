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
    wait for 10ns;
    clk <= '0';
    wait for 10ns;
  end process clock;

  test : process
  begin
  	report "Test begin" severity note;

  	down_up <= '0';
  	enable <= '1';
  	wait for 1000ns;


  end process test;
end tb;

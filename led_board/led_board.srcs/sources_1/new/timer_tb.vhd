----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.11.2018 12:37:16
-- Design Name: 
-- Module Name: timer_tb - Behavioral
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

entity timer_tb is
end timer_tb;

architecture Behavioral of timer_tb is
	component timer
   	port (
     	t_reset : in  STD_LOGIC;
     	t_clock : in  STD_LOGIC;
    	t_timer : out STD_LOGIC  
   	);
  	end component timer;
  	signal t_reset : STD_LOGIC;
  	signal t_clock : STD_LOGIC;
  	signal t_timer : STD_LOGIC;
begin
	DUT : timer
  	Port map (
      t_reset => t_reset,
      t_clock => t_clock,
      t_timer => t_timer
    );
    clk : process
    begin
      t_clock <= '1';
      wait for 4ns;
      t_clock <= '0';
      wait for 4ns;
    end process clk;


end Behavioral;

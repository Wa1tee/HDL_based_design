----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.11.2018 12:37:16
-- Design Name: 
-- Module Name: controller - Behavioral
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

entity controller is
    Port ( 
           	reset : in STD_LOGIC;
    		    clock : in STD_LOGIC;
           	alarm : in STD_LOGIC;
           	speed : in STD_LOGIC;
           	iter  : in STD_LOGIC;
           	R : out STD_LOGIC_vector (7 downto 0);
           	G : out STD_LOGIC_vector (7 downto 0);
           	B : out STD_LOGIC_vector (7 downto 0));
end controller;

architecture Behavioral of controller is
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
  
  module : timer
  Port map (
      t_reset => t_reset,
      t_clock => t_clock,
      t_timer => t_timer
    );

	driver : process (reset, clock, alarm, speed, iter, t_timer)
	begin
	  if (reset = '1') then
	    
	  elsif (rising_edge(clock)) then
	
	  end if;
	end process driver;


end Behavioral;

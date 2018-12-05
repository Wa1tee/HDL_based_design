----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.12.2018 14:23:46
-- Design Name: 
-- Module Name: led_top - Behavioral
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

entity led_top is
  Port ( 
  	sysclk  : in STD_LOGIC;
  	btn 	: in STD_LOGIC_VECTOR(3 downto 0);
  	led5_r	: out STD_LOGIC_VECTOR(7 downto 0);
	led5_g	: out STD_LOGIC_VECTOR(7 downto 0);
	led5_b	: out STD_LOGIC_VECTOR(7 downto 0)
  );
end led_top;

architecture Behavioral of led_top is
	component controller
        Port (
          reset : in STD_LOGIC;
          clock : in STD_LOGIC;
          alarm : in STD_LOGIC;
          speed : in STD_LOGIC;
          iter  : in STD_LOGIC;
          R : out STD_LOGIC_vector (7 downto 0);
          G : out STD_LOGIC_vector (7 downto 0);
          B : out STD_LOGIC_vector (7 downto 0));
    end component controller;
begin

led : controller
port map(
	clock 	=> sysclk,
	reset 	=> btn(0),
	alarm 	=> btn(1),
	speed 	=> btn(2),
	iter  	=> btn(3),
	R 		=> led5_r,
	G 		=> led5_g,
	B 		=> led5_b
 	);
end Behavioral;

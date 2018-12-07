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
  	btn 	  : in STD_LOGIC_VECTOR(3 downto 0);
  	led5_r	: out STD_LOGIC;
    led5_g	: out STD_LOGIC;
    led5_b	: out STD_LOGIC
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
          B : out STD_LOGIC_vector (7 downto 0)
          );
    end component controller;

  signal R : STD_LOGIC_vector(7 downto 0);
  signal G : STD_LOGIC_vector(7 downto 0);
  signal B : STD_LOGIC_vector(7 downto 0);
  
  signal R_out : STD_LOGIC;
  signal G_out : STD_LOGIC;
  signal B_out : STD_LOGIC;
  
  
  signal count : unsigned(7 downto 0);


begin

led : controller
port map(
	clock 	=> sysclk,
	reset 	=> btn(0),
	alarm 	=> btn(1),
	speed 	=> btn(2),
	iter  	=> btn(3),
	R 		=> R,
	G 		=> G,
	B 		=> B
 	);



top : process (sysclk, R, G, B)
begin
  
  if (rising_edge(sysclk)) then
    if (count < unsigned(R)) then
      R_out <= '1';
    else
      R_out <= '0';
    end if;

    if (count < unsigned(G)) then
      G_out <= '1';
    else
      G_out <= '0';
    end if;

    if (count < unsigned(B)) then
      B_out <= '1';
    else
      B_out <= '0';
    end if;

    if (count = "11111111") then
      count <= "00000000";
    else
      count <= count + "1";
    end if;

    led5_r <= R_out;
    led5_g <= G_out;
    led5_b <= B_out;
  end if;
end process top;
end Behavioral;

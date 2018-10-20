----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.10.2018 00:03:35
-- Design Name: 
-- Module Name: led_driver - Behavioral
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

entity led_driver is
    Port ( reset 	: in STD_LOGIC;
           speed 	: in STD_LOGIC;
           iter  	: in STD_LOGIC;
           alarm 	: in STD_LOGIC;

           red 	 	: out std_logic_vector(7 downto 0);
           blue 	: out std_logic_vector(7 downto 0);
           green	: out std_logic_vector(7 downto 0));
    
end led_driver;

architecture Behavioral of led_driver is

begin


end Behavioral;

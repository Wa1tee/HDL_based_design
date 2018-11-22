----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.11.2018 12:37:16
-- Design Name: 
-- Module Name: controller_tb - Behavioral
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

entity controller_tb is
end controller_tb;

architecture Behavioral of controller_tb is
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

    signal reset : STD_LOGIC;
    signal clock : STD_LOGIC;
    signal alarm : STD_LOGIC;
    signal speed : STD_LOGIC;
    signal iter  : STD_LOGIC;
    signal R : STD_LOGIC_vector (7 downto 0);
    signal G : STD_LOGIC_vector (7 downto 0);
    signal B : STD_LOGIC_vector (7 downto 0));

begin
    DUT: controller
    Port map (
        reset => reset,
        clock => clock,
        alarm => alarm,
        speed => speed,
        iter  => iter,
        R     => R,
        G     => G,
        B     => B
    );

    clk : process
    begin
      clock <= '1';
      wait for 4ns;
      clock <= '0';
      wait for 4ns;
    end process clk;


end Behavioral;

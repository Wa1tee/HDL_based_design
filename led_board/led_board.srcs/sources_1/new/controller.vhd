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

  signal s_state : unsigned(3 downto 0) := "0000";

begin

  module : timer
  Port map (
      t_reset => t_reset,
      t_clock => t_clock,
      t_timer => t_timer
    );

  state : process (reset, t_timer)
  begin
    t_clock <= clock;
    t_reset <= reset;

    if (reset = '1') then
        s_state <= "0000";
    elsif (rising_edge(t_timer)) then
        if (s_state = "0001") then
            s_state <= "0000";
        else
            s_state <= "0001";
        end if;
    end if;
  end process;

  driver : process (reset, clock, alarm, speed, iter)
  begin
    
    if (reset = '1') then
        null;
    elsif (rising_edge(clock)) then
        if (s_state = "0000") then
            R <= "11111111";
            G <= "11111111";
            B <= "11111111";
        else
            R <= "00000000";
            G <= "00000000";
            B <= "00000000";
        end if;
    end if;
  end process;


end Behavioral;

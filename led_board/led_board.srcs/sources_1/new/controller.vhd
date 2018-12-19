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
--
--
---------------------

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
          clock    : in STD_LOGIC;
          resetbtn : in STD_LOGIC;
          alarmbtn : in STD_LOGIC;
          speedbtn : in STD_LOGIC;
          iterbtn  : in STD_LOGIC;
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

  -- Signals to refer to buttons last stages
  signal last_resetbtn : STD_LOGIC := '0';
  signal last_alarmbtn : STD_LOGIC := '0';
  signal last_speedbtn : STD_LOGIC := '0';
  signal last_iterbtn  : STD_LOGIC := '0';

  -- Signals for timer module
  signal t_reset : STD_LOGIC;
  signal t_clock : STD_LOGIC;
  signal t_timer : STD_LOGIC;

  -- Signals for led outputs
  signal s_R : STD_LOGIC_vector (7 downto 0);
  signal s_G : STD_LOGIC_vector (7 downto 0);
  signal s_B : STD_LOGIC_vector (7 downto 0);

  -- Help signals
  signal s_state      : unsigned(2 downto 0) := "000";
  signal s_last_state : unsigned(2 downto 0) := "000";

  signal s_count      : unsigned(6 downto 0) := "0000000";
  signal s_last_count : unsigned(6 downto 0) := "0000000";

  signal s_alarmstatus      : unsigned(6 downto 0) := "0000000";
  signal s_last_alarmstatus : unsigned(6 downto 0) := "0000000";

  signal s_iter   : STD_LOGIC := '0';

  signal s_speed    : unsigned(5 downto 0) := "001010";
  signal s_standby  : STD_LOGIC := '1';

  signal s_blink    : unsigned(5 downto 0) := "000001";

  function next_state (f_state : in unsigned(2 downto 0)) return unsigned(2 downto 0) is
  begin
    if (f_state = "101") then
      return "001";
    elsif (f_state = "111") then
      return "001";
    elsif (f_state = "000") then
      return "001";
    else
      return f_state + "1";
    end if;
  end next_state;

begin
  module : timer
  Port map (
      t_reset => t_reset,
      t_clock => t_clock,
      t_timer => t_timer
    );

  main : process (clock, resetbtn, speedbtn, iterbtn, alarmbtn, t_timer)
  begin

    t_clock <= clock;
    t_reset <= resetbtn;

    if (rising_edge(t_timer)) then
      if (s_alarmstatus > "0000000") then
        if (s_count = s_blink) then
          s_state <= "000";
          s_count <= "0000000";
        else
          s_state <= "111";
          s_count <= s_last_count + 1;
          
          

        end if;
        --s_last_count <= s_count;
        s_alarmstatus <= s_last_alarmstatus -1;
      
      elsif (s_standby = '1') then
        if (s_count = "0101000") then
          s_state <= "001";
          s_standby <= '0';
          s_count <= "0000000";
        else
          s_count <= s_last_count + "1";
        end if;  
      
      elsif (s_count = s_speed) then
        s_state <= next_state(s_last_state);
        s_count <= "0000000";
      else
        s_count <= s_last_count + "1";
      end if;
    end if;
    
    s_last_alarmstatus <= s_alarmstatus;
    s_last_count <= s_count;
    s_last_state <= s_state;

    if (resetbtn = '1') then
      s_state <= "000";
      s_count <= "0000000";
      s_speed <= "001010";
      s_alarmstatus <= "0000000";
      s_standby <= '1';
      s_blink <= "000001";

    elsif (rising_edge(clock)) then
      if (speedbtn = '1' AND last_speedbtn = '0') then
        case(s_speed) is
        when "001010" => 
          s_speed <= "011110";
          s_blink <= "000011";
        when "011110" =>
          s_speed <= "110010";
          s_blink <= "000101";
        when others =>
          s_speed <= "001010";
          s_blink <= "000001";
      end case;
      end if;
      last_speedbtn <= speedbtn;

      if (iterbtn = '1' AND last_iterbtn = '0') then
        if (s_iter = '1') then
          s_iter <= '0';
        else
          s_iter <= '1';
        end if;
      end if;
      last_iterbtn <= iterbtn;

      if (alarmbtn = '1' AND last_alarmbtn = '0') then
        s_alarmstatus <= "1000110";
        s_count <= "0000000";
      end if;

    end if;
    
  end process main;


  leds : process (clock, s_R, s_G, s_B, s_state, s_iter)
  begin

    if (rising_edge(clock)) then

      case(s_iter) is
        when '0' =>
          if (s_state = "000") then
            s_R  <= "01111111";
            s_G  <= "01111111";
            s_B  <= "01111111";
          elsif (s_state = "111") then
            s_R  <= "00000000";
            s_G  <= "00000000";
            s_B  <= "00000000";
          elsif (s_state = "001") then
            s_R  <= "01111111";
            s_G  <= "00000000";
            s_B  <= "00000000";
          elsif (s_state = "010") then
            s_R  <= "01111111";
            s_G  <= "01111111";
            s_B  <= "00000000";
          elsif (s_state = "011") then
            s_R  <= "00000000";
            s_G  <= "01111111";
            s_B  <= "00000000";
          elsif (s_state = "100") then
            s_R  <= "00000000";
            s_G  <= "00000000";
            s_B  <= "01111111";
          elsif (s_state = "101") then
            s_R  <= "00111111";
            s_G  <= "00000000";
            s_B  <= "00111111";  
          end if;

        when '1' =>
          
          if (s_state = "000") then
            s_R  <= "01111111";
            s_G  <= "01111111";
            s_B  <= "01111111";
          elsif (s_state = "111") then
            s_R  <= "00000000";
            s_G  <= "00000000";
            s_B  <= "00000000";
          elsif (s_state = "001") then
            s_R  <= "01111111";
            s_G  <= "00000000";
            s_B  <= "00000000";
          --Yellow
          elsif (s_state = "010") then
            s_R  <= "01111111";
            s_G  <= "01111111";
            s_B  <= "00000000";
          --Purple
          elsif (s_state = "011") then
            s_R  <= "00111111";
            s_G  <= "00000000";
            s_B  <= "00111111";
          --B
          elsif (s_state = "100") then
            s_R  <= "00000000";
            s_G  <= "00000000";
            s_B  <= "01111111";
          --G
          elsif (s_state = "101") then
            s_R  <= "00000000";
            s_G  <= "01111111";
            s_B  <= "00000000";
          end if;        
        when others =>
          s_R  <= "00000000";
          s_G  <= "00000000";
          s_B  <= "00000000";
        end case;
    end if;

    R <= s_R;
    G <= s_G;
    B <= s_B;

  end process leds;
end Behavioral;
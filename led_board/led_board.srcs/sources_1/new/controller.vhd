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
-- TODO: Split into two or three processes
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

  signal last_reset : STD_LOGIC := '0';
  signal last_alarm : STD_LOGIC := '0';
  signal last_speed : STD_LOGIC := '0';
  signal last_iter  : STD_LOGIC := '0';

  signal t_reset : STD_LOGIC;
  signal t_clock : STD_LOGIC;
  signal t_timer : STD_LOGIC;

  signal s_state : unsigned(2 downto 0) := "000";

  signal s_count    : unsigned(5 downto 0) := "000000";

  signal s_iter   : STD_LOGIC := '0';

  signal s_alarm : unsigned(6 downto 0) := "0000000";
  signal s_blink : unsigned(4 downto 0) := "00001";



  --references for counting timer events
  signal s_speed    : unsigned(5 downto 0) := "001010";
  signal s_standby  : unsigned(5 downto 0) := "101000";
  --signal s_speed1   : unsigned(5 downto 0) := "001010";
  --signal s_speed2   : unsigned(5 downto 0) := "011110";
  --signal s_speed3   : unsigned(5 downto 0) := "110010";

  signal s_R : STD_LOGIC_vector (7 downto 0);
  signal s_G : STD_LOGIC_vector (7 downto 0);
  signal s_B : STD_LOGIC_vector (7 downto 0);

begin

  module : timer
  Port map (
      t_reset => t_reset,
      t_clock => t_clock,
      t_timer => t_timer
    );

  

  leds : process (reset, clock)
  begin
    t_clock <= clock;
    t_reset <= reset;


    if (rising_edge(clock)) then
        --if (speed = '1' and last_speed = '0') then

        --  if (s_speed = "001010") then
        --    s_speed <= "011110";
        --    s_blink <= "000011";
        --  elsif (s_speed = "011110") then
        --    s_speed <= "110010";
        --    s_blink <= "000101";
        --  else
        --    s_speed <= "001010";
        --    s_blink <= "000001";
        --  end if;
        --end if;
        --last_speed <= speed;

        --if (iter = last_iter) then
        --   if (s_iter = '1') then
        --     s_iter <= '0';
        --   else
        --     s_iter <= '1';
        --   end if;
        --end if;
        --last_iter <= iter;

        --if (alarm = '1' and last_alarm = '0') then
        --  --s_alarm <= '1';
        --  --s_count <= "000000";
        --  s_alarm <= "1000110";
        --end if;
        --last_alarm <= alarm;

        case(s_iter) is
        when '0' =>
          if (s_state = "000") then
            s_R  <= "11111111";
            s_G  <= "11111111";
            s_B  <= "11111111";
          elsif (s_state = "111") then
            s_R  <= "00000000";
            s_G  <= "00000000";
            s_B  <= "00000000";
          elsif (s_state = "001") then
            s_R  <= "11111111";
            s_G  <= "00000000";
            s_B  <= "00000000";
          elsif (s_state = "010") then
            s_R  <= "11111111";
            s_G  <= "11111111";
            s_B  <= "00000000";
          elsif (s_state = "011") then
            s_R  <= "00000000";
            s_G  <= "11111111";
            s_B  <= "00000000";
          elsif (s_state = "100") then
            s_R  <= "00000000";
            s_G  <= "00000000";
            s_B  <= "11111111";
          elsif (s_state = "101") then
            s_R  <= "10000000";
            s_G  <= "00000000";
            s_B  <= "10000000";  
          end if;
        when '1' =>
          
          if (s_state = "001") then
            s_R  <= "11111111";
            s_G  <= "00000000";
            s_B  <= "00000000";
          --Yellow
          elsif (s_state = "010") then
            s_R  <= "11111111";
            s_G  <= "11111111";
            s_B  <= "00000000";
          --Purple
          elsif (s_state = "011") then
            s_R  <= "10000000";
            s_G  <= "00000000";
            s_B  <= "10000000";
          --B
          elsif (s_state = "100") then
            s_R  <= "00000000";
            s_G  <= "00000000";
            s_B  <= "11111111";
          --G
          elsif (s_state = "101") then
            s_R  <= "00000000";
            s_G  <= "11111111";
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

    

  
    

    --if (reset = '1') then
    --    s_count <= "000000";
    --    s_state <= "000";
    --    s_speed <= "001010";
    --    s_alarm <= "0000000";
    
    --elsif (rising_edge(t_timer)) then
    --    if (s_alarm = "0000000") then
    --      if (s_state = "000") then
    --                --standby 4s
    --          if (s_count = s_standby) then
    --            s_state <= "001";
    --            s_count <= "000000";
    --          else
    --            s_count <= s_count + "1";
    --          end if;
    --      else
    --        --iterate states "001" through "101"
    --        if (s_count = s_speed) then
    --          s_count <= "000000";
    --          if (s_state = "101") then
    --            s_state <= "001";
    --          else
    --            s_state <= s_state + "1";
    --          end if;
    --        end if;
    --      end if;
    --    else
    --      s_alarm <= s_alarm - "1";
    --      if (s_count = s_blink) then
    --        s_count <= "000000";
    --        if (s_state = "000") then
    --          s_state <= "111";
    --        else
    --          s_state <= "000";
    --        end if;
    --      else
    --        s_count <= s_count + "1";
    --      end if;

    --    end if;
    --end if;

  end process;

  states : process (reset, speed, alarm, iter, t_timer)
  begin
    --if (reset = '1') then
    --    s_count <= "000000";
    --    s_state <= "000";
    --    s_speed <= "001010";
    --    s_alarm <= "0000000";
    
    

    if (speed = '1' and last_speed = '0') then

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
    last_speed <= speed;

    if (iter = last_iter) then
      case(s_iter) is
        when '1' =>
          s_iter <= '0';
        when others =>
          s_iter <= '1';
      end case;
    end if;
    last_iter <= iter;

    if (alarm = '1' and last_alarm = '0') then
      --s_alarm <= '1';
      --s_count <= "000000";
      s_alarm <= "1000110";
    end if;
    last_alarm <= alarm;

    if (reset = '1') then
        s_count <= "000000";
        s_state <= "000";
        s_speed <= "001010";
        s_alarm <= "0000000";

    elsif (rising_edge(t_timer)) then
        if (s_alarm = "0000000") then
          if (s_state = "000") then
                    --standby 4s
              if (s_count = s_standby) then
                s_state <= "001";
                s_count <= "000000";
              else
                s_count <= s_count + "1";
              end if;
          else
            --iterate states "001" through "101"
            if (s_count = s_speed) then
              s_count <= "000000";
              if (s_state = "101") then
                s_state <= "001";
              else
                s_state <= s_state + "1";
              end if;
            end if;
          end if;
        else
          s_alarm <= s_alarm - "1";
          if (s_count = s_blink) then
            s_count <= "000000";
            if (s_state = "000") then
              s_state <= "111";
            else
              s_state <= "000";
            end if;
          else
            s_count <= s_count + "1";
          end if;

        end if;
    end if;
  end process states;

end Behavioral;

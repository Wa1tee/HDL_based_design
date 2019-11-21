----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.12.2018 11:47:16
-- Design Name: 
-- Module Name: alarm_top - Behavioral
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

entity alarm_top is
  Port (
  	sysclk 	: in STD_LOGIC;
  	btn 		: in STD_LOGIC_VECTOR(2 downto 0);
  	sw 			: in STD_LOGIC_VECTOR(1 downto 0);
  	led5_r	: out STD_LOGIC;
    led5_g	: out STD_LOGIC;
    led5_b	: out STD_LOGIC;

    lumi		: in STD_LOGIC_VECTOR(11 downto 0)
    --buzz 		: out STD_LOGIC
  );
end alarm_top;

architecture Behavioral of alarm_top is
	component alarm
		Generic ( 	
			data_width : integer := 16;
			addr_width : integer := 3
		);

  	Port ( 
  		reset 				: in STD_LOGIC; -- Button 0
    	clock 				: in STD_LOGIC;
    	power_switch 	: in STD_LOGIC; -- Switch 0
    	buzzer_switch : in STD_LOGIC; -- Switch 1
    	calibrate 		: in STD_LOGIC; -- Button 1
    	snooze				: in STD_LOGIC; -- Button 2

    	-- Analog sensor. Testing with illuminance sensor
    	sensor  			: in STD_LOGIC_VECTOR(11 downto 0);

    	--buzzer  : out STD_LOGIC_VECTOR(7 downto 0);
    	R 			: out STD_LOGIC_VECTOR(7 downto 0);
    	G 			: out STD_LOGIC_VECTOR(7 downto 0);
    	B 			: out STD_LOGIC_VECTOR(7 downto 0)
  	);
	end component;


  signal R : STD_LOGIC_vector(7 downto 0);
  signal G : STD_LOGIC_vector(7 downto 0);
  signal B : STD_LOGIC_vector(7 downto 0);
  signal buzzer : STD_LOGIC_vector(7 downto 0);

  
  signal R_out : STD_LOGIC;
  signal G_out : STD_LOGIC;
  signal B_out : STD_LOGIC;
  signal buzz_out : STD_LOGIC;
    
  signal count : unsigned(7 downto 0);
  signal last_count : unsigned(7 downto 0);

begin

  module : alarm
  port map(
    clock         => sysclk,
    reset         => btn(0),
    calibrate     => btn(1),
    snooze        => btn(2),
    power_switch  => sw(0),
    buzzer_switch => sw(1),
    sensor        => lumi,
    buzzer        => buzz,
    R             => R,
    G             => G,
    B             => B
  );

  top : process (sysclk, R, G, B)
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
      --if (count < unsigned(buzzer)) then
      --  buzz_out <= '1';
      --else
      --  buzz_out <= '0';
      --end if;
  
      if (count = "11111111") then
        count <= "00000000";
      else
        count <= last_count + "1";
      end if;
  
      last_count <= count;
  
      led5_r <= R_out;
      led5_g <= G_out;
      led5_b <= B_out;
      buzz   <= buzz_out;
    end if;
  end process top;
end Behavioral;

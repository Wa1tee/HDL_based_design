----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.12.2018 23:36:31
-- Design Name: 
-- Module Name: alarm - Behavioral
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

entity alarm is
	Generic ( 	
		data_width : integer := 16;
		addr_width : integer := 3
	);

  Port ( 
  	reset 				: in STD_LOGIC; -- Button
    clock 				: in STD_LOGIC;
    power_switch 	: in STD_LOGIC; -- Switch
    buzzer_switch : in STD_LOGIC; -- Switch
    calibrate 		: in STD_LOGIC; -- Button
    snooze				: in STD_LOGIC; -- Button

    -- Analog sensor. Testing with illuminance sensor
    sensor  			: in STD_LOGIC_VECTOR(128 downto 0);

    buzzer  : out STD_LOGIC_VECTOR(128 downto 0);
    R 			: out STD_LOGIC_VECTOR(255 downto 0);
    G 			: out STD_LOGIC_VECTOR(255 downto 0);
    B 			: out STD_LOGIC_VECTOR(255 downto 0)

  );
end alarm;

architecture Behavioral of alarm is
	component sp_ram
		Generic ( 	
			data_width : integer := 16;
			addr_width : integer := 3
		);
  	Port ( 
    	addr	: in STD_LOGIC_VECTOR (addr_width -1 downto 0);
    	data	: inout STD_LOGIC_VECTOR (data_width -1 downto 0);
    	rw 		: in STD_LOGIC;
    	clock : in STD_LOGIC
   	);
	end component sp_ram;
	
	component timer
    port (
      t_reset : in  STD_LOGIC;
      t_clock : in  STD_LOGIC;
      t_timer : out STD_LOGIC
    );
  end component timer;

	signal ram_addr : STD_LOGIC_VECTOR (addr_width -1 downto 0);
	signal ram_data : STD_LOGIC_VECTOR (data_width -1 downto 0);
	signal ram_rw 	: STD_LOGIC;

begin

main : process (reset, clock)
begin
	if (power_switch = '1') then
		
  	if (reset = '1') then
	  	  
	  elsif (rising_edge(clock)) then
	
  	end if; -- reset/clock edge
	end if; -- power switch
end process main;

end Behavioral;

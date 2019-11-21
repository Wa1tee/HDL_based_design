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
    -- value used to calculate 10% of the treshold values to be implemented 
    -- value used to calculate 15% of the treshold values to be implemented
		data_width : integer := 16;
		addr_width : integer := 3
	);

  Port ( 
  	reset 				: in STD_LOGIC; -- Button
    clock 				: in STD_LOGIC;
    power_switch 	: in STD_LOGIC; -- Switch
    --buzzer_switch : in STD_LOGIC; -- Switch
    calibrate 		: in STD_LOGIC; -- Button
    snooze				: in STD_LOGIC; -- Button

    -- Analog sensor. Testing with potentiometer
    --sensor  			: in STD_LOGIC_VECTOR(11 downto 0);

    --buzzer  : out STD_LOGIC_VECTOR(7 downto 0);
    R 			: out STD_LOGIC;                   -- Red    (255, 0,   0  )
    G 			: out STD_LOGIC;                   -- Green  (0,   255, 0  )
    B 			: out STD_LOGIC;                   -- Blue   (0,   191, 255)
    O       : out STD_LOGIC                    -- Orange (255, 128, 0  )

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

	signal last_resetbtn 	: STD_LOGIC := '0';
  signal last_snooze 		: STD_LOGIC := '0';
  signal last_calibrate : STD_LOGIC := '0';

	signal s_count      : unsigned(6 downto 0) := "0000000";
  signal s_last_count : unsigned(6 downto 0) := "0000000";

  signal s_alarmstatus      : unsigned(6 downto 0) := "0000000";
  signal s_last_alarmstatus : unsigned(6 downto 0) := "0000000";

  signal s_calibration      : STD_LOGIC := '1';
  signal s_last_calibration : STD_LOGIC;

  signal s_snoozestatus      : unsigned(6 downto 0) := "0000000";
  signal s_last_snoozestatus : unsigned(6 downto 0) := "0000000";

begin

module : timer
	Port map (
		t_reset => t_reset,
		t_clock => t_clock,
		t_timer => t_timer
	);

main : process (reset, clock)
begin
	if (power_switch = '1') then
		
  	if (reset = '1' AND last_resetbtn = '0') then
  		s_calibration   <= '1';
  		s_snoozestatus  <= "0000000";
  		s_alarmstatus   <= "0000000";
  		s_count         <= "0000000";

	  elsif (rising_edge(clock)) then
      if (s_count < "1111110") then
        if (R) then
          R <= 0;
          G <= 1;
        elsif (G) then
          G <= 0;
          B <= 1;
        elsif (B) then
          B <= 0;
          O <= 1;
        elsif (O) then
          O <= 0;
          R <= 1;
        end if;
      end if;
      s_last_count <= s_count;
      s_count <= s_last_count + 1;

    end if; -- reset/clock edge
	end if; -- power switch
end process main;

--calibration : process()
--begin

--end process calibration;

end Behavioral;

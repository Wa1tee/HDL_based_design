----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.11.2018 12:37:16
-- Design Name: 
-- Module Name: timer - Behavioral
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

entity timer is
    Port ( 	
    		t_reset : in STD_LOGIC;
    		t_clock : in STD_LOGIC;
           	t_timer : out STD_LOGIC);
end timer;

architecture Behavioral of timer is
begin
	timing : process (t_reset, t_clock)
	variable v_time : integer := 0;
	begin
	  if (t_reset = '1') then
	  	v_time := 0;
	  	t_timer <= '0';
	  elsif (rising_edge(t_clock)) then
		v_time := v_time + 1;
	  	if (v_time = 10) then
	  		t_timer <= '1';
	  		v_time := 0;
	  	else
	  		t_timer <= '0';
	  	end if;
	  end if;
	end process timing;

end Behavioral;

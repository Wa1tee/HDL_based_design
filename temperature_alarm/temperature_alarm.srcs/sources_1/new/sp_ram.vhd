----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.12.2018 12:54:21
-- Design Name: 
-- Module Name: sp_ram - Behavioral
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

entity sp_ram is
	Generic ( 	data_width : integer := 16;
				addr_width : integer := 3
		);
    Port ( addr		: in STD_LOGIC_VECTOR (addr_width -1 downto 0);
           data		: inout STD_LOGIC_VECTOR (data_width -1 downto 0);
           rw 		: in STD_LOGIC;
           clock 	: in STD_LOGIC
           );
end sp_ram;

architecture Behavioral of sp_ram is
	function write (f_addr : in STD_LOGIC_VECTOR(addr_width -1 downto 0),
					f_data : in STD_LOGIC_VECTOR(data_width -1 downto 0)) 
	return STD_LOGIC is
	begin
		
		if (rising_edge(clock)) then
			
			
		end if;
		return return_signal;
	end write;

	function read ( f_addr : in STD_LOGIC_VECTOR(addr_width -1 downto 0),
					f_data : in STD_LOGIC_VECTOR(data_width -1 downto 0)) 
	return STD_LOGIC is
	begin
		if (rising_edge(clock)) then
			
		end if;

		return '0';
	end read;
begin
	RTL : process (addr, data, rw, clock)
	signal s_addr : STD_LOGIC_VECTOR(addr_width -1 downto 0);
	signal s_data : STD_LOGIC_VECTOR(data_width -1 downto 0);

	begin
	  if (rising_edge(clock)) then
		if (rw = '1') then
			--write

		else
			--read
		end if;
	  end if;
	end process RTL;

end Behavioral;

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
end sp_ram;

architecture Behavioral of sp_ram is
	--signal reg : STD_LOGIC_VECTOR(addr_width -1 downto 0);
	signal ram : STD_LOGIC_VECTOR(data_width -1 downto 0);
	
begin
	RTL : process (addr, data, rw, clock)
	begin

	  if (rising_edge(clock)) then
			if (rw = '1') then
				--write
				ram(addr) <= data;
			else
				data <= ram(addr);
			end if;
		end if;
	end process RTL;

end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.12.2018 12:55:56
-- Design Name: 
-- Module Name: sp_ram_tb - Behavioral
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

entity sp_ram_tb is
end sp_ram_tb;

architecture Behavioral of sp_ram_tb is
	component sp_ram
		Generic ( 	data_width : integer := 16;
					addr_width : integer := 3
		);

    	Port (  addr	: in STD_LOGIC_VECTOR (addr_width -1 downto 0);
           		data	: inout STD_LOGIC_VECTOR (data_width -1 downto 0);
           		rw 		: in STD_LOGIC;
           		clock 	: in STD_LOGIC
           );

	end component sp_ram;

	function write (f_addr : in STD_LOGIC_VECTOR(addr_width -1 downto 0),
					f_data : in STD_LOGIC_VECTOR(data_width -1 downto 0)) 
	return STD_LOGIC is
	begin
		rw <= '1';
		if (rising_edge(clock)) then
			addr <= f_addr;
			
		end if;
		return return_signal;
	end write;

	function read ( f_addr : in STD_LOGIC_VECTOR(addr_width -1 downto 0),
					f_data : in STD_LOGIC_VECTOR(data_width -1 downto 0)) 
	return STD_LOGIC is
	begin
		rw <= '0';

		return '0';
	end read;
begin
	DUT: sp_ram
		Port map (
			addr  => addr,
			data  => data,
			rw 	  => rw,
			clock => clock
			);

	clk : process
	begin
	  clock <= '1';
	  wait for 4ns;
	  clock <= '0';
	end process clk;

	test : process
	begin
	  wait for 10ns;
	  

	end process test;
end Behavioral;

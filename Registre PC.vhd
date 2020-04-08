library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity registre_PC is
	port(	clk, rst : in std_logic;
			DataIn : in std_logic_vector (31 downto 0);
			DataOut : out std_logic_vector (31 downto 0));
end entity registre_PC;


architecture ARCHI of registre_PC is
signal SData : std_logic_vector (31 downto 0);
begin
process(clk, rst)
	begin
	if(rst='1') then
		SData<=X"00000000";
	else if(rising_edge(clk)) then
		SData<=DataIn;
	end if;
	end if;
end process;
DataOut<=SData;

end architecture ARCHI;
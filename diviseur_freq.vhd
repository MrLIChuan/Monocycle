
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity diviseur_freq is
port( clk,rst : in std_logic;
      clk_final : out std_logic);
end diviseur_freq;

architecture ARCHI1 of diviseur_freq is
signal temp : std_logic_vector(25 downto 0);
begin
process(clk,rst)
begin
   if rst='1' then temp<="00000000000000000000000000";
	elsif (rising_edge(clk)) then
		if (temp < "10111110101111000010000000") then
			temp <= temp + "00000000000000000000000001";
		else
			temp<="00000000000000000000000000";
		end if;
	end if;
end process;
clk_final<='1' when(temp<"01011111010111100001000000") else'0';	
end ARCHI1;





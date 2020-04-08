library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity extension_signe is
generic(
		N : integer := 8);
	port(	E : in std_logic_vector (N-1 downto 0);
			S : out std_logic_vector (31 downto 0));
end entity extension_signe;


architecture ARCHI of extension_signe is
begin
	S(31 downto N) <= (others=>E(N-1));
	S(N-1 downto 0) <=E;
end architecture ARCHI;



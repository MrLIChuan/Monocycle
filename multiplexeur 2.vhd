library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity multiplexeur_2 is
generic(
		N : positive range 1 to 32 := 4);
	port(	COM : in std_logic;
			A, B : in std_logic_vector (N-1 downto 0);
			S : out std_logic_vector (N-1 downto 0));
end entity multiplexeur_2;



architecture ARCHI of multiplexeur_2 is
begin
	with COM select
	S<=A when '0',
	   B when others;
end architecture ARCHI;

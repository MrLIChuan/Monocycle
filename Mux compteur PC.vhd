library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity muxCompteurPC is
	port(	nPCsel : in std_logic;
			BusPC, BusExtend : in std_logic_vector (31 downto 0);
			S : out std_logic_vector (31 downto 0));
end entity muxCompteurPC;

architecture ARCHI of muxCompteurPC is
signal sortie : std_logic_vector(31 downto 0);
begin


	with nPCsel select
	sortie<=std_logic_vector(signed(BusPC)+to_signed(1, 32)) when '0',
			std_logic_vector(signed(BusPC)+to_signed(1, 32)+signed(BusExtend)) when others;
	S<=sortie;
													 
end architecture ARCHI;
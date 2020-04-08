library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity assemblage is
	port ( clk, rst : in std_logic;
		   HEX0: out std_logic_vector(6 downto 0);
		   HEX1: out std_logic_vector(6 downto 0));
			
			
end entity assemblage;

architecture ARCHI of assemblage is

signal SDivOut: std_logic;
signal SW: std_logic_vector(31 downto 0);

begin

	diviseur: entity WORK.diviseur_freq(ARCHI1) port map ( clk=>clk, rst=>rst,
																clk_final=>SDivOut);
																
	AssemblageFinal: entity WORK.assemblage_final(ARCHI1) port map ( clk=>SDivOut, rst=>rst, W=>SW);
	
	Dec7Seg: entity WORK.dec_7seg(ARCHI) port map ( busW=>SW, seg=>HEX0, seg2=>HEX1);	



end architecture ARCHI;
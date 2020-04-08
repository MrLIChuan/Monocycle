library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity unite_traitement is
	port (  clk, WE , rst, RegSel: in std_logic;
			OP : in std_logic_vector (1 downto 0);
			RA, RB, RW : in std_logic_vector (3 downto 0);
			N : out std_logic;
			W : out std_logic_vector (31 downto 0));
end entity unite_traitement;

architecture ARCHI1 of unite_traitement is
signal SbusA, SbusB , SW: std_logic_vector(31 downto 0);
signal SMuxOut : std_logic_vector (3 downto 0);
begin
	
	G1: entity WORK.multiplexeur_2(ARCHI) port map ( COM => RegSel, A => RB,
													 B => RW, S => SMuxOut);
	
	G2: entity WORK.BancRegistres32(ARCHI1) port map (  clk => clk, WE=>WE, rst=>rst,
														RA=>RA, RB=>SMuxOut, RW=>SMuxOut,
														W=>SW,
														A=>SbusA, B=>SbusB);
	
	G3: entity WORK.ALU(ARCHI) port map (   OP=> OP,
											A=>SbusA, B=>SbusB,
											S=>SW, N=>N);
W<=SW;
end architecture ARCHI1;
	
	
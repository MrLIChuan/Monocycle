library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity UniteGestionInstructions is
	port (  clk, rst, nPCsel: in std_logic;
			Offset : in std_logic_vector (23 downto 0);
			Instruction : out std_logic_vector (31 downto 0));
end entity UniteGestionInstructions;
									
									
									
architecture ARCHI1 of UniteGestionInstructions is
signal SPCOut, SExtenOut, SMuxOut: std_logic_vector(31 downto 0);
begin

	G1: entity WORK.extension_signe(ARCHI) generic map(N=>24) port map ( E=>Offset,
														 S=>SExtenOut);

	G2: entity WORK.muxCompteurPC(ARCHI) port map ( nPCsel=>nPCsel, BusPC=>SPCOut, BusExtend=>SExtenOut,
													 S=>SMuxOut);
														
	G3: entity WORK.registre_PC(ARCHI) port map ( clk=>clk, rst=>rst,
													DataIn=>SMuxOut,
													DataOut=>SPCOut);
	
	G4: entity WORK.memoire_instructions(ARCHI1) port map ( Addr=>SPCOut,
													 Instruction=>Instruction);

end architecture ARCHI1;
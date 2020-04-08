library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;


entity assemblage_unite_traitement is
	port (  clk, RegW , rst, COM1, COM2, WrEn, RegSel: in std_logic;
			OP : in std_logic_vector (1 downto 0);
			RA, RB, RW : in std_logic_vector (3 downto 0);
			Imm : in std_logic_vector (7 downto 0);
			flag : out std_logic;
			W : out std_logic_vector (31 downto 0));
end entity assemblage_unite_traitement;




									
architecture ARCHI1 of assemblage_unite_traitement is
signal SALUOut, SDataOut, SExtenOut, SBusA, SBusB, SBusW, SMux1Out: std_logic_vector(31 downto 0);
signal SMuxOut : std_logic_vector (3 downto 0);
begin
	
	G1: entity WORK.multiplexeur_2(ARCHI) port map ( COM => RegSel, A => RB,
													 B => RW, S => SMuxOut);	
	
	G2: entity WORK.BancRegistres32(ARCHI1) port map (  clk => clk, WE=>RegW, rst=>rst,
														RA=>RA, RB=>SMuxOut, RW=>RW,
														W=>SBusW,
														A=>SBusA, B=>SBusB);

	G3: entity WORK.extension_signe(ARCHI) generic map(N=>8) port map ( E=>Imm,
														 S=>SExtenOut);

	G4: entity WORK.multiplexeur_2(ARCHI) generic map(N=>32) port map ( COM=>COM1, A=>SBusB, B=>SExtenOut,
													 S=>SMux1Out);
														
	G5: entity WORK.ALU(ARCHI) port map ( OP=> OP,
										  A=>SBusA, B=>SMux1Out,
										  S=>SALUOut, N=>flag);

	G6: entity WORK.memoire_donnees(ARCHI1) port map (	DataIn=>SBusB, CLK=>clk,
														WrEn=>WrEn, Addr=>SALUOut(5 downto 0),
														DataOut=>SDataOut);
	
	G7: entity WORK.multiplexeur_2(ARCHI) generic map(N=>32) port map ( COM=>COM2, A=>SALUOut, B=>SDataOut,
													 S=>SBusW);
W<=SBusW;
end architecture ARCHI1;
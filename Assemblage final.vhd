library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity assemblage_final is
	port ( clk, rst : in std_logic;
		   W : out std_logic_vector (31 downto 0));
end entity assemblage_final;

architecture ARCHI1 of assemblage_final is
signal SFlagN, SnPCSel, SRegWr , SALUsrc, SMemWr, SWrSrc, SRegSel: std_logic;
signal RA, SRB, SRW : std_logic_vector(3 downto 0);
signal SALUctr : std_logic_vector(1 downto 0);
signal SOffset : std_logic_vector(23 downto 0);
signal SImm : std_logic_vector (7 downto 0);
signal SInstruction : std_logic_vector (31 downto 0);
begin
	G1: entity WORK.UniteGestionInstructions(ARCHI1) port map ( clk=>clk, rst=>rst,
																nPCSel=>SnPCSel, Offset=>SOffset,
																Instruction=>SInstruction);
								
	G2: entity WORK.Unitecontrole(ARCHI) port map ( clk=>clk, rst=>rst, Instruction=>SInstruction,
													ALUctr=>SALUctr, RegWr=>SRegWr,
													ALUsrc=>SALUsrc, MemWr=>SMemWr,
													WrSrc=>SWrSrc, RegSel=>SRegSel,
													RA=>RA, RB=>SRB, RW=>SRW,
													Imm=>SImm, Offset=>SOffset, FlagN=>SFlagN, nPCSel=>SnPCSel);
													
	G3: entity WORK.assemblage_unite_traitement(ARCHI1) port map ( clk=>clk, rst=>rst, RegW=> SRegWr,
																   COM1=>SALUsrc, COM2=>SWrSRC, WrEn=>SMemWr,
																   RegSel=>SRegSel, OP=>SALUctr, RA=>RA,
																   RB=>SRB, RW=>SRW, Imm=>SImm,
																   flag=>SFlagN, W=>W);
													



end architecture;
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity Unitecontrole is
	port (  FlagN, clk, rst : in std_logic;
			Instruction : in std_logic_vector (31 downto 0);
			ALUctr : out std_logic_vector (1 downto 0);
			nPCSel, RegWr, ALUsrc, MemWr, WrSrc, RegSel : out std_logic;
			RA, RB, RW: out std_logic_vector(3 downto 0);
			Imm: out std_logic_vector (7 downto 0);
			Offset: out std_logic_vector(23 downto 0));
end entity Unitecontrole;



architecture ARCHI of Unitecontrole is
signal SExtenOut, SPSROut: std_logic_vector(31 downto 0);
signal SPSRIn : std_logic;
signal P : std_logic_vector(1 downto 0);

begin

P(0)<=FlagN;
P(1)<='0';

	G1: entity WORK.extension_signe(ARCHI) generic map(N=>2) port map ( E=>P,
														 S=>SExtenOut);
	
		
	G2: entity WORK.registreComCharg(ARCHI) port map (  clk => clk, WE=>SPSRIn, rst=>rst,
														DataIn=>SExtenOut, DataOut=>SPSROut);
	
	G3: entity WORK.DecodeurInstructions(ARCHI) port map ( Instruction=> Instruction,
											PSR=>SPSROut, nPCSel=>nPCSel, ALUctr => ALUctr, 
											RegWr=>RegWr, ALUsrc=>ALUsrc,
											PSREn=>SPSRIn, MemWr=>MemWr, WrSrc=>WrSrc,
											RegSel=>RegSel,RA=>RA, RB=>RB, RW=>RW,
											Imm=>Imm, Offset=>Offset);

end architecture ARCHI;
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity DecodeurInstructions is
	port(	Instruction, PSR : in std_logic_vector (31 downto 0);
			nPCSel, RegWr, ALUSrc, MemWr, WrSrc, PSREn : out std_logic;
			RegSel : out std_logic;
			RA, RB, RW : out std_logic_vector (3 downto 0);
			Imm : out std_logic_vector (7 downto 0);
			Offset : out std_logic_vector (23 downto 0);
			ALUctr : out std_logic_vector (1 downto 0));
end entity DecodeurInstructions;

architecture ARCHI of DecodeurInstructions is
type enum_instruction is (MOV, ADDi, ADDr, CMP, LDR, STR, BAL, BLT,NOP);
signal instr_courante : enum_instruction;
signal INT : std_logic_vector(11 downto 0);
begin
process(INT, instr_courante)
	begin
		case INT is
			when "111000101000" => instr_courante <= ADDi;
			when "111000001000" => instr_courante <= ADDr;
			when "111000111010" => instr_courante <= MOV;
			when "111000110101" => instr_courante <= CMP;
			when "111001100001" => instr_courante <= LDR; 
			when "111001100000" => instr_courante <= STR;
			when "111010100000" => instr_courante <= BAL;
			when "101110100000" => instr_courante <= BLT;
			when "111010101111" => instr_courante <= BAL;
			when "101110101111" => instr_courante <= BLT;
			when others => instr_courante <= NOP;
		end case;
	
end process;

process(instr_courante, PSR)
	begin
		case instr_courante is
			when ADDi => nPCSel <= '0';
						 RegWr <= '1';
						 ALUSrc <= '1';
						 ALUCtr <= "00";
						 PSREn <= '0';
						 MemWr <= '0';
						 WrSrc <= '0';
						 RegSel <= '0';
			when ADDr => nPCSel <= '0';
						 RegWr <= '1';
						 ALUSrc <= '0';
						 ALUCtr <= "00";
						 PSREn <= '0';
						 MemWr <= '0';
						 WrSrc <= '0';
						 RegSel <= '0';
			when BAL => nPCSel <= '1';
						 RegWr <= '0';
						 ALUSrc <= '-';
						 ALUCtr <= "--";
						 PSREn <= '0';
						 MemWr <= '0';
						 WrSrc <= '0';	
						 RegSel <= '0';
			when BLT => 
				if (PSR(0) = '1') then
					nPCSel <= '1';
				else 
					nPCSel <= '0';
			    end if;
						 RegWr <= '0';
						 ALUSrc <= '-';
						 ALUCtr <= "--";
						 PSREn <= '0';
						 MemWr <= '0';
						 WrSrc <= '0';
						 RegSel <= '0';
			when CMP => nPCSel <= '0';
						 RegWr <= '0';
						 ALUSrc <= '1';
						 ALUCtr <= "10";
						 PSREn <= '1';
						 MemWr <= '0';
						 WrSrc <= '-';	
						 RegSel <= '0';
			when LDR => nPCSel <= '0';
						 RegWr <= '1';
						 ALUSrc <= '1';
						 ALUCtr <= "00";
						 PSREn <= '0';
						 MemWr <= '0';
						 WrSrc <= '1';
						 RegSel <= '0';
			when MOV => nPCSel <= '0';
						 RegWr <= '1';
						 ALUSrc <= '1';
						 ALUCtr <= "01";
						 PSREn <= '0';
						 MemWr <= '0';
						 WrSrc <= '0';
						 RegSel <= '0';
			when STR => nPCSel <= '0';
						 RegWr <= '0';
						 ALUSrc <= '1';
						 ALUCtr <= "00";
						 PSREn <= '0';
						 MemWr <= '1';
						 WrSrc <= '-';	
						 RegSel <= '1';	
			when others => nPCSel <= '0';
						 RegWr <= '-';
						 ALUSrc <= '-';
						 ALUCtr <= "--";
						 PSREn <= '-';
						 MemWr <= '-';
						 WrSrc <= '-';
						 RegSel <= '-';
			end case;
						 
						 
						 
						 
end process;
	
	INT <= Instruction(31 downto 20);
	RA <= Instruction(19 downto 16);
	RB <= Instruction(3 downto 0);
	RW <= Instruction(15 downto 12);
	Imm <= Instruction(7 downto 0);
	Offset <= Instruction(23 downto 0);

end architecture ARCHI;
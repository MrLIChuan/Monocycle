library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;


entity assemblage_unite_traitement_tb IS
	port(	TestOK: out BOOLEAN);
END assemblage_unite_traitement_tb;

architecture archi1 of assemblage_unite_traitement_tb is

signal BusW	: std_logic_vector(31 downto 0);
signal RegW, Rst, clk, COM1, COM2, WrEn,RegSel: std_logic;
signal RA, RB, RW : std_logic_vector (3 downto 0);
signal OP : std_logic_vector (1 downto 0);
signal Imm : std_logic_vector (7 downto 0);

begin

process
	begin
	--Début
	TestOK <= TRUE;
	wait for 5 ns;
	
	Rst<='0';
	clk<='0';
	RegW<='0';
	RA<="1111";
	RB<="0001";
	COM1<='0';	--Pour lire le bus B
	COM2<='0';
	OP<="00"; -- Addition de A et B
	wait for 5 ns;
	
		if BusW /= X"00000030" then
			--TestOK <= FALSE;
			assert busW=X"00000030" report "Erreur addition 2 registres" severity warning;
		end if;
	
	clk<='0';
	RegW<='0';
	RA<="1111";
	Imm<="00000010";
	COM1<='1';	--Pour lire la sortie de l'extender
	COM2<='0';
	--RB<="0001";
	OP<="00"; -- Addition de A et B
	wait for 5 ns;
	clk<='1';
	RegW<='1';
	RW<="0010";	--écriture dans le registre 2
	wait for 5 ns;
	--lire busW
	--clk<='0';
	--RegW<='0';
	--RA<="0010";
	--OP<="11";	--Lire A
	--wait for 5 ns;
		if BusW /= X"00000032" then	--50 en hexa
			TestOK <= FALSE;
			assert busW=X"00000032" report "Erreur addition registre + valeur Imm" severity warning;
		end if;
	
	wait for 5 ns;
	
	clk<='0';
	RegW<='0';
	RA<="0010";
	
	COM1<='0';	--Pour lire la sortie de l'extender
	COM2<='0';
	RB<="1111";
	OP<="10"; -- soustraction de a et B (50-48)
	wait for 5 ns;
	
		if BusW /= X"00000002" then	
			TestOK <= FALSE;
			assert busW=X"00000002" report "Erreur soustraction de 2 registres" severity warning;
		end if;
	
	wait for 5 ns;
	
	clk<='0';
	RegW<='0';
	RA<="1111";
	Imm<="00000010";
	COM1<='1';	--Pour lire la sortie de l'extender
	COM2<='0';
	--RB<="1111";
	OP<="10"; -- soustraction de a et Imm (48-2)
	wait for 5 ns;
	
		if BusW /= X"0000002E" then	
			TestOK <= FALSE;
			assert busW=X"0000002E" report "Erreur soustraction registre - Imm" severity warning;
		end if;
	
	wait for 5 ns;
	
	clk<='0';
	RegW<='0';
	RA<="1111";
	Imm<="00001111";	--15
	COM1<='1';	--Pour lire la sortie de l'extender
	COM2<='1';
	RB<="0010";
	OP<="00"; -- addition de A et Imm (48 + 15)
	wait for 5 ns;
	clk<='1';
	WrEn<='1';
	wait for 5 ns;
	clk<='0';
	--wait for 5 ns;
		if BusW /= X"00000032" then	
			--TestOK <= FALSE;
			assert busW=X"00000032" report "Erreur d'écriture ou de lecture dans la mémoire" severity warning;
		end if;
	
	wait for 5 ns;
	clk<='1';
	RegW<='1';
	RW<="0011";	--écriture dans le registre 3
	wait for 5 ns;
		
	wait;
end process;

G1: entity work.assemblage_unite_traitement port map(
	 RegW=>RegW , rst => Rst, RA => RA, RB => RB, RW=>RW, clk=>clk, COM1=>COM1, COM2=>COM2, WrEn=>WrEn, OP=>OP, Imm=>Imm,RegSel => RegSel
	);
	
end architecture archi1;
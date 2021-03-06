library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity unite_traitement_tb IS
	port(	--clk, WE , rst: in std_logic;
			--OP : in std_logic_vector (1 downto 0);
			--RA, RB, RW : in std_logic_vector (3 downto 0);
			TestOK: out BOOLEAN);
END unite_traitement_tb;

architecture archi1 of unite_traitement_tb is

signal BusW	: std_logic_vector(31 downto 0);
signal WE, Rst, clk, RegSel: std_logic;
signal RA, RB, RW : std_logic_vector (3 downto 0);
signal OP : std_logic_vector (1 downto 0);

begin

process
		begin
	--D�but
	TestOK <= TRUE;
	wait for 5 ns;
	
	Rst<='0';
	clk<='0';
	WE<='0';
	RA<="1111";
	OP<="11"; -- Lire A
	wait for 5 ns;
	clk<='1';
	WE<='1';
	RW<="0001";
	wait for 5 ns;
	--lire busW
	clk<='0';
	WE<='0';
	RA<="0001";
	OP<="11";
	wait for 5 ns;--R1=R15
		      
		if BusW /= X"00000030" then
		TestOK <= FALSE;
	assert busW=X"00000030" report "Error on busW" severity warning;
	end if;
	wait for 5 ns;
	
	
	clk<='0';--R1=R1+R15
	WE<='0';
	RA<="0001";
	RB<="1111";
	OP<="00";
	wait for 5 ns;
	clk<='1';
	WE<='1';
	RW<="0001";
	wait for 5 ns;
	--lire busW
	clk<='0';
	WE<='0';
	RA<="0001";
	OP<="11";
	wait for 5 ns;
	if BusW /= X"00000060" then
		TestOK <= FALSE;
		assert busW=X"00000060" report "Error on busW" severity warning;
	end if;
	wait for 5 ns;
	
	clk<='0';
	WE<='0';
	RA<="0001";
	RB<="1111";
	OP<="00";--R2=R1+R15
	wait for 5 ns;
	clk<='1';
	WE<='1';
	RW<="0010";
	wait for 5 ns;
	--lire busW
	clk<='0';
	WE<='0';
	RA<="0010";
	OP<="11";
	wait for 5 ns;
	if BusW /= X"00000090" then
		TestOK <= FALSE;
		assert busW=X"00000090" report "Error on busW" severity warning;
	end if;
	wait for 5 ns;	

	clk<='0';
	WE<='0';
	RA<="0001";
	RB<="1111";
	OP<="10";--R3=R1-R15
	wait for 5 ns;
	clk<='1';
	WE<='1';
	RW<="0011";
	wait for 5 ns;
	--lire busW
	clk<='0';
	WE<='0';
	RA<="0011";
	OP<="11";
	wait for 5 ns;
	if BusW /= X"00000030" then
		TestOK <= FALSE;
		assert busW=X"00000030" report "Error on busW" severity warning;
	end if;
	wait for 5 ns;

	clk<='0';
	WE<='0';
	RA<="0111";
	RB<="1111";
	OP<="10";--R5=R7-R15
	wait for 5 ns;
	clk<='1';
	WE<='1';
	RW<="0101";
	wait for 5 ns;
	--lire busW
	clk<='0';
	WE<='0';
	RA<="0101";
	OP<="11";
	wait for 5 ns;
	if BusW /= X"FFFFFFD0" then
		TestOK <= FALSE;	
		assert busW=X"FFFFFFD0" report "Error on busW" severity warning;
	end if;
	wait;
	
end process;

G1: entity work.unite_traitement port map(
	 WE=>WE , rst => Rst, RA => RA, RB => RB, RW=>RW, clk=>clk, W=>BusW, OP=>OP,RegSel=>RegSel
	);
	
end architecture;
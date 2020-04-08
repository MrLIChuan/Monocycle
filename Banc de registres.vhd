library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity BancRegistres32 is
	port(	clk, WE , rst: in std_logic;
			RA, RB, RW : in std_logic_vector (3 downto 0);
			W : in std_logic_vector (31 downto 0);
			A, B : out std_logic_vector (31 downto 0));
end entity BancRegistres32;

architecture ARCHI1 of BancRegistres32 is
-- Declaration Type Tableau Memoire
type table is array(15 downto 0) of std_logic_vector(31 downto 0);

-- Fonction d'Initialisation du Banc de Registres
function init_banc return table is
	variable result : table;
		begin
			for i in 14 downto 0 loop
				result(i) := (others=>'0');
			end loop;
			result(15):=X"00000030";
			return result;
end init_banc;

-- Declaration et Initialisation du Banc de Registres 16x32 bits
signal Banc: table:=init_banc;

begin
--Nous allons utiliser la façon de unsigned à changer des variables
	A <= Banc(to_integer(unsigned(RA)));
	B <= Banc(to_integer(unsigned(RB)));

	process (clk, rst)
	begin
		if(rst = '1') then
			banc <= init_banc;
		elsif(rising_edge(clk)) then		--reset prioritaire
			if(WE = '1') then
				Banc(to_integer(unsigned(RW))) <= W;
			end if;
		end if;
	end process;
end architecture ARCHI1;
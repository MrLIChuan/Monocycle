library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity memoire_instructions is
	port(	--CLK : in std_logic;
			Addr : in std_logic_vector (31 downto 0);
			Instruction : out std_logic_vector (31 downto 0));
end entity memoire_instructions;

architecture ARCHI1 of memoire_instructions is
-- Declaration Type Tableau Memoire
type table is array(63 downto 0) of std_logic_vector(31 downto 0);

-- Fonction Initiale du Banc de Registres
function init_banc return table is
	variable result : table;
		begin
			result(0) := "11100011101000000001000100100000";
			result(1) := "11100011101000000010000000000000";
			result(2) := "11100110000100010000000000000000";
			result(3) := "11100000100000100010000000000000";
			result(4) := "11100010100000010001000000000001";
			result(5) := "11100011010100010000000000101010";
			result(6) := "10111010111111111111111111111011";	--offset de -4 -1 du multiplexeur
			result(7) := "11100110000000010010000000000000";
			result(8) := "11101010111111111111111111110111";
		
			for i in 63 downto 9 loop
				result(i) := (others=>'0');
			end loop;
			--result(63):=X"00000030";
			return result;
end init_banc;

-- Déclaration et Initialisation du Banc de Registres 6x32 bits
signal Banc: table:=init_banc;
signal Addr6b: std_logic_vector(5 downto 0);

begin

	Addr6b<=Addr(5 downto 0);

	Instruction <= Banc(to_integer(unsigned(Addr6b)));

end architecture ARCHI1;
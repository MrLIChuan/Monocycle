library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity memoire_donnees is
	port(	CLK, WrEn : in std_logic;
			DataIn : in std_logic_vector (31 downto 0);
			Addr : in std_logic_vector (5 downto 0);
			DataOut : out std_logic_vector (31 downto 0));
end entity memoire_donnees;

architecture ARCHI1 of memoire_donnees is
-- Declaration Type Tableau Memoire
type table is array(63 downto 0) of std_logic_vector(31 downto 0);

-- Fonction d'Initialisation du Banc de Registres
function init_banc return table is
	variable result : table;
		begin
			for i in 63 downto 0 loop
				result(i) := (others=>'0');
			end loop;
			--result(63):=X"00000030";
			return result;
end init_banc;

-- Déclaration et Initialisation du Banc de Registres 6x32 bits
signal Banc: table:=init_banc;

begin

	DataOut <= Banc(to_integer(unsigned(Addr)));
	

	process (CLK)
	begin
		if(rising_edge(CLK)) then		
			if(WrEn = '1') then
				Banc(to_integer(unsigned(Addr))) <= DataIn;
			end if;
		end if;
	end process;
end architecture ARCHI1;
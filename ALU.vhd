library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity ALU is
  port ( 	OP : in std_logic_vector (1 downto 0);
			A, B : in std_logic_vector (31 downto 0);
			S : out std_logic_vector (31 downto 0);
			N : out std_logic);
			--resultat          : out std_logic_vector(31 downto 0)
end entity ALU;

architecture ARCHI of ALU is
begin
	with OP select
	S <= std_logic_vector(signed(A) + signed(B)) when "00",	--Add
		 B when "01",--Y=B
		 std_logic_vector(signed(A) - signed(B)) when "10",--SUB
		 A when others;--"11",--Y=A
		-- "--------" when others;
	process(A, B, OP)	
		begin
			if (A<B and OP="10") then
				N <= '1';--Si le résultat est négatif
			else
				N <= '0';--Si le résultat est positif
			end if;
	end process;
	
	
	

end architecture ARCHI;
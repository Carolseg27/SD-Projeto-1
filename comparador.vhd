LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY comparador IS 

PORT (   A, B: in std_logic;
			G, S, E: out std_logic -- G means that A is greater than B, S smaller than, and E is equal
     );

END comparador;

Architecture struct of comparador IS

BEGIN

G <= A AND (NOT B);
S <= (NOT A) AND B;
E <= NOT (A XOR B);
	
END struct;
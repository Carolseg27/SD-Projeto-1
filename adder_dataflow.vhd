library ieee;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY adder_dataflow IS

PORT ( 
			A,B: in std_logic_vector(3 downto 0);
			Cin: in std_logic;
			S: out std_logic_vector(3 downto 0);
			Cout, Overflow: out std_logic
			
		);

END ENTITY;

ARCHITECTURE dataflow of adder_dataflow is

SIGNAL SUM:std_logic_vector(3 downto 0);
SIGNAL CARRY: std_logic_vector(4 downto 0);
CONSTANT n: INTEGER := 3;

BEGIN

L: for i in 0 to n GENERATE

CARRY(0)   <= Cin;
SUM(i)     <= A(i) XOR B(i) XOR CARRY(i);
CARRY(i+1) <= (A(i) AND B(i)) OR (CARRY(i) AND B(i)) OR (A(i) AND CARRY(i));

End GENERATE L;

S          <= SUM;
Cout       <= CARRY(4);
Overflow <= (not A(3) and not B(3) and SUM(3)) or (A(3) and B(3) and not SUM(3));
-- Onde A(3),B(3) e C(3) são os bits mais significativos que representam o bit de sinal

END dataflow;


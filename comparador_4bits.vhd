LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY comparador_4bits IS 

PORT (   COMP_AB: in std_logic_vector(7 downto 0);
		 COMP_OUT: out std_logic_vector(2 downto 0) -- 0 -> A>B, 1 -> A<B, e 2 -> A=B
		 );
END comparador_4bits;

Architecture struct of comparador_4bits IS

Component comparador IS

Port(		A, B: in std_logic;
			G, S, E: out std_logic);
			
End component;

SIGNAL A, B, smaller, greater, equal: std_logic_vector(3 downto 0);
SIGNAL P_0, P_1, P_2: std_logic;
SIGNAL s_0, s_1, s_2: std_logic;

BEGIN

A <= COMP_AB(3 downto 0); -- 'A' recebe os 4 primeiros inputs
B <= COMP_AB(7 downto 4); 
	    
L_0: for i in 0 to 3 GENERATE

comparador_i: comparador PORT MAP(A => A(i), B => B(i), G => greater(i), S => smaller(i), E => equal(i));
End GENERATE L_0;

-- O bit mais significativo é o de sinal, portanto, se 
-- A=1 e B=0 => A<B; A=0 e B=1 => A>B; A=1 e B=1 ou B=0 e A=0 => A=B
-- isso já que 1 representa um número negativo, e 0 positivo 

P_0 <= greater(1) OR (equal(1) AND greater(0));
P_1 <= greater(2) OR (equal(2) AND P_0);
P_2 <= (NOT A(3) AND B(3)) OR (equal(3) AND P_1); 

COMP_OUT(0) <= P_2; -- maior

COMP_OUT(2) <= equal(3) AND equal(2) AND equal(1) AND equal(0); -- igual

s_0 <= smaller(1) OR (equal(1) AND smaller(0));
s_1 <= smaller(2) OR (equal(2) AND s_0);
s_2 <= (A(3) AND NOT B(3)) OR (equal(3) AND s_1); 

COMP_OUT(1) <= s_2; -- menor

END struct;
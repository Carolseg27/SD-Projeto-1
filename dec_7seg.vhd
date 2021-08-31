LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- Converte de binário para display de 7 segmentos

ENTITY dec_7seg IS 

PORT (   DEC_IN: in std_logic_vector(3 downto 0);
         DISP1: out std_logic_vector(6 downto 0);
         DISP2: out std_logic_vector(6 downto 0)
     );

END dec_7seg;

Architecture struct of dec_7seg IS

signal A, B, C, D: std_logic;

BEGIN

A <= DEC_IN(3);
B <= DEC_IN(2);
C <= DEC_IN(1);
D <= DEC_IN(0);

-- o display funciona em low
-- Display 0
DISP1(0) <= not ((A and not B) or (C and not D) or (C and not A) or (not B and not D) or (B and D and not C));     -- a
DISP1(1) <= not ((A xnor B) or (not C and not D) or (A and not C) or (D and C and not A));                       -- b
DISP1(2) <= not (D or (not C) or (B xor A));                       -- c
DISP1(3) <= not ((not D and C) or (C and not B) or (not B and not D) or (B and not C and D));-- d
DISP1(4) <= not ((not D and C) or (not B and not D));    -- e
DISP1(5) <= not ((not D and not C) or (B and not C and not A) or (A and not B and C) or (not A and B and C and not D));-- f
DISP1(6) <= not ((C and not D) or (C xor B) or (A and not C and not D));  -- g

-- Display 1
DISP2(0) <= not ('0');                                                 -- a
DISP2(1) <= not ('0');                                                 -- b
DISP2(2) <= not ('0');                                                 -- c
DISP2(3) <= not ('0');                                                 -- d
DISP2(4) <= not ('0');                                                 -- e
DISP2(5) <= not ('0');                                                 -- f
DISP2(6) <= not (A);                                                   -- g
	
	
END struct;
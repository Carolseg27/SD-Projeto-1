library ieee;
use ieee.std_logic_1164.all;

entity ALU is

port(

  V_SW: in std_logic_vector(10 downto 0); -- A de 0 a 3, B de 4 a 7, sel de 8 a 10
  G_LEDG: out std_logic_vector(7 downto 0); -- De 0 a 3 é o resultado, o 4 é o Cout, de 5 a 7 compara, 5 maior, 6 menor e 7 igual
  G_HEX0: out std_logic_vector(6 downto 0); -- Displays, em conjuntos de 2, para A, B e Resultado 
  G_HEX1: out std_logic_vector(6 downto 0);
  G_HEX4: out std_logic_vector(6 downto 0);
  G_HEX5: out std_logic_vector(6 downto 0);
  G_HEX6: out std_logic_vector(6 downto 0);
  G_HEX7: out std_logic_vector(6 downto 0);
  G_LEDR: out std_logic_vector(2 downto 0) --
  
  );
  
end ALU;

architecture alu_8op of ALU is 

signal tempA, tempB, A, B, result: std_logic_vector(3 downto 0);
signal sel, comp_leds: std_logic_vector(2 downto 0);
signal Cout, Cin, sel_0, sel_1, sel_2, comp: std_logic;

component adder_dataflow is -- declarando o módulo somador 

port ( 	A,B: in std_logic_vector(3 downto 0);
		Cin: in std_logic;
		S: out std_logic_vector(3 downto 0);
		Cout, Overflow: out std_logic
		);
end component;

component comparador_4bits is -- declarando o módulo comparador

port (   
        COMP_AB: in std_logic_vector(7 downto 0);
        COMP_OUT: out std_logic_vector(2 downto 0) -- 0 -> A>B, 1 -> A<B, e 2 -> A=B
     );
	 
end component;

component dec_7seg is -- declarando displays

port (   DEC_IN: in std_logic_vector(3 downto 0);
         DISP1: out std_logic_vector(6 downto 0);
         DISP2: out std_logic_vector(6 downto 0)
     );
end component;

	begin
	
	    A   <= V_SW(3 downto 0); -- 'A' recebe os 4 primeiros inputs
	    B   <= V_SW(7 downto 4);  
	    sel <= V_SW(10 downto 8); 
	    -- O seletor recebe os 3 últimos inputs, e seleciona as operações a serem feitas pela ALU
	    
	    --Seletor:
	    -- 000 = Soma
	    -- 001 = Subtração A-B
	    -- 010 = Complemento de 2 para A
	    -- 011 = Incremento de A
	    -- 100 = XOR
	    -- 101 = COMPARADOR
	    -- 110 = COMPARADOR
	    -- 111 = COMPARADOR
	    
	    sel_0 <= sel(0);
	    sel_1 <= sel(1);
	    sel_2 <= sel(2);
	    
	    -- Controle do Carry_in
	    Cin <= (NOT sel_2) AND (sel_0 OR sel_1);
	
	   --Controle de A e B na entrada do somador
	    gen: for I in 0 to 3 generate
	        -- "000", "001", "010", "011", "100"
	        -- Valores de A e B para o somador durante comparação é zero
	        -- Operação de A xor B é realizada em tempA e passada diretamente para o somador. B = 0 neste caso
	        tempA(I) <= ((A(I) AND sel_0 and not sel_2) or  (not sel_1 and not sel_2 and A(I)) 
	        or (not sel_0 and not sel_1 and sel_2 and(A(I) xor B(I))) or (not sel_0 and sel_1 and not sel_2 and not A(I))); 
	        tempB(I) <= (B(I) XOR sel_0) AND ((NOT sel_1) AND (NOT sel_2));
	        
	    end generate gen;
	    
	   -- Controle dos LEDS de comparação
	   -- O comparador recebe diretamente os inputs.
	   -- Os leds do comparador só são ligados quando a comparação é a operação escolhida
	   comp <= sel_2 and (sel_0 or sel_1);
		
adder_dataflow_port: adder_dataflow PORT MAP (
        A => tempA,
        B => tempB,
        Cin => Cin,
        S=> result,
        Cout => Cout,
        Overflow => G_LEDR(0)  -- Flag de Overflow
    );

-- Comparador recebe diretamente os inputs dos botoes
comparador_4bits_port: comparador_4bits PORT MAP (
        COMP_AB => V_SW(7 downto 0),  -- Comparador recebe as entradas A e B
        COMP_OUT => comp_leds  -- Saida do Comparador (Direta -> A > B, Meio -> A < B, Esquerda -> Igual)
    );

-- Ativa LEDS de comparação quando esta é a operação escolhida (101, 110 e 111 para o seletor)
gen_comp: for I in 0 to 2 generate
    G_LEDG(I+5) <= comp_leds(I) and comp;

end generate gen_comp;
    
-- Decodificadores para os displays
decodificador_A: dec_7seg PORT MAP (
        DEC_IN => V_SW(3 downto 0), 
        DISP1 => G_HEX6,
        DISP2 => G_HEX7
    );
    
decodificador_B: dec_7seg PORT MAP (
        DEC_IN => V_SW(7 downto 4), 
        DISP1 => G_HEX4,
        DISP2 => G_HEX5
    );

decodificador_Z: dec_7seg PORT MAP (
        DEC_IN => result, 
        DISP1 => G_HEX0,
        DISP2 => G_HEX1
    );
    
G_LEDG(3 downto 0) <= result;-- As 4 primeiras saídas recebem o resultado final
G_LEDG(4) <= Cout;           -- quinta saída recebe o Cout

G_LEDR(1) <= not result(3) and not result(2) and not result(1) and not result(0); -- Flag de zero
G_LEDR(2) <= result(3);

end alu_8op;
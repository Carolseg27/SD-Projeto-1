LIBRARY ieee  ; 
LIBRARY std  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_textio.all  ; 
USE ieee.std_logic_unsigned.all  ; 
USE std.textio.all  ; 
ENTITY tb8  IS 
END ; 
 
ARCHITECTURE tb8_arch OF tb8 IS
  SIGNAL A_in   :  std_logic_vector (3 downto 0)  ; 
  SIGNAL B_in   :  std_logic_vector (3 downto 0)  ; 
  SIGNAL Zero_flag   :  STD_LOGIC  ; 
  SIGNAL Carry_out_flag   :  STD_LOGIC  ; 
  SIGNAL G_HEX0   :  std_logic_vector (6 downto 0)  ; 
  SIGNAL Negative_flag   :  STD_LOGIC  ; 
  SIGNAL Comp_out   :  std_logic_vector (2 downto 0)  ;
  SIGNAL G_HEX1   :  std_logic_vector (6 downto 0)  ; 
  SIGNAL G_HEX2   :  std_logic_vector (6 downto 0)  ; 
  SIGNAL G_LEDR   :  std_logic_vector (2 downto 0)  ; 
  SIGNAL G_HEX3   :  std_logic_vector (6 downto 0)  ; 
  SIGNAL V_SW   :  std_logic_vector (10 downto 0)  ; 
  SIGNAL G_HEX4   :  std_logic_vector (6 downto 0)  ; 
  SIGNAL G_HEX5   :  std_logic_vector (6 downto 0)  ; 
  SIGNAL Res_out   :  std_logic_vector (3 downto 0)  ; 
  SIGNAL sel_in   :  std_logic_vector (2 downto 0)  ; 
  SIGNAL G_LEDG   :  std_logic_vector (7 downto 0)  ; 
  SIGNAL Overflow_flag   :  STD_LOGIC  ; 
  COMPONENT ALU  
    PORT ( 
      B_in  : out std_logic_vector (3 downto 0) ; 
		Comp_out  : out std_logic_vector (2 downto 0) ; 
      Zero_flag  : out STD_LOGIC ; 
      Carry_out_flag  : out STD_LOGIC ; 
      G_HEX0  : out std_logic_vector (6 downto 0) ; 
      Negative_flag  : out STD_LOGIC ; 
      G_HEX1  : out std_logic_vector (6 downto 0) ; 
      G_HEX2  : out std_logic_vector (6 downto 0) ; 
      G_LEDR  : out std_logic_vector (2 downto 0) ; 
      G_HEX3  : out std_logic_vector (6 downto 0) ; 
      V_SW  : in std_logic_vector (10 downto 0) ; 
      G_HEX4  : out std_logic_vector (6 downto 0) ; 
      A_in  : out std_logic_vector (3 downto 0) ; 
      G_HEX5  : out std_logic_vector (6 downto 0) ; 
      Res_out  : out std_logic_vector (3 downto 0) ; 
      sel_in  : out std_logic_vector (2 downto 0) ; 
      G_LEDG  : out std_logic_vector (7 downto 0) ; 
      Overflow_flag  : out STD_LOGIC ); 
  END COMPONENT ; 
BEGIN
  DUT  : ALU  
    PORT MAP ( 
      B_in   => B_in  ,
		Comp_out   => Comp_out  ,
      Zero_flag   => Zero_flag  ,
      Carry_out_flag   => Carry_out_flag  ,
      G_HEX0   => G_HEX0  ,
      Negative_flag   => Negative_flag  ,
      G_HEX1   => G_HEX1  ,
      G_HEX2   => G_HEX2  ,
      G_LEDR   => G_LEDR  ,
      G_HEX3   => G_HEX3  ,
      V_SW   => V_SW  ,
      G_HEX4   => G_HEX4  ,
      A_in   => A_in  ,
      G_HEX5   => G_HEX5  ,
      Res_out   => Res_out  ,
      sel_in   => sel_in  ,
      G_LEDG   => G_LEDG  ,
      Overflow_flag   => Overflow_flag   ) ; 



-- "Counter Pattern"(Range-Up) : step = 1 Range(00000000000-11111111111)
-- Start Time = 0 ns, End Time = 2048 ns, Period = 1 ns
  Process
	variable VARv_sw  : std_logic_vector(10 downto 0);
	Begin
	VARv_sw  := "00000000000" ;
	for repeatLength in 1 to 2048
	loop
	    v_sw  <= VARv_sw  ;
	   wait for 1 ns ;
	   VARv_sw  := VARv_sw  + 1 ;
	end loop;
-- 2048 ns, repeat pattern in loop.
	wait;
 End Process;
END;

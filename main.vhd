library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- This is a the main top level module of the project
ENTITY main IS 
    PORT(CLK100MHZ						: in STD_LOGIC;
		SW 								: in STD_LOGIC_VECTOR(7 downto 0);
		BTNC, BTNU, BTND, BTNR, BTNL 	: in STD_LOGIC;
		reset                           : in STD_LOGIC;
		CA, CB, CC, CD, CE, CF, CG      : out STD_LOGIC;
		LED 							: out STD_LOGIC_VECTOR(7 downto 0));
END main;

ARCHITECTURE BEHAVIOUR OF main is

    component seg7 is
        Port (bcd : in STD_LOGIC_VECTOR (3 downto 0);
               CA : out STD_LOGIC;
               CB : out STD_LOGIC;
               CC : out STD_LOGIC;
               CD : out STD_LOGIC;
               CE : out STD_LOGIC;
               CF : out STD_LOGIC;
               CG : out STD_LOGIC;
               Anode : out STD_LOGIC_VECTOR(7 downto 0));
    end component;
    
    component ALU_8_bit is
        port (buttonU, buttonD, buttonL, buttonR : in std_logic;
                clk     : in std_logic;
                A, B     : in std_logic_vector(7 downto 0);
                result     : out std_logic_vector(7 downto 0));
	end component;

	component FSM is 
        port(A, B                 : in STD_LOGIC_VECTOR(7 downto 0);
            buttonC               : in STD_LOGIC;
            reset, clk            : in STD_LOGIC;
            operandA, operandB    : out STD_LOGIC_VECTOR(7 downto 0));
	end component;
	
	component operandA is
	   	port(D 		: in std_logic_vector(7 downto 0);
            Clk, En : in std_logic;
            Q         : out std_logic_vector(7 downto 0));
    end component;
    
    component operandB is
        port(D         : in std_logic_vector(7 downto 0);
            Clk, En : in std_logic;
            Q         : out std_logic_vector(7 downto 0));
    end component;
    
    component operandG is
        port(D         : in std_logic_vector(7 downto 0);
            Clk, En : in std_logic;
            Q         : out std_logic_vector(7 downto 0));
    end component;
    
    component BIN2BCD is
          port (BINARY    : in std_logic_vector(7 downto 0);  -- range 0 to 255
                BCD       : out std_logic_vector(11 downto 0));
    end component;
	
	signal regA_in_wire : STD_LOGIC_VECTOR(7 downto 0);
	signal regB_in_wire : STD_LOGIC_VECTOR(7 downto 0);
    signal regA_out_wire : STD_LOGIC_VECTOR(7 downto 0);
    signal regB_out_wire : STD_LOGIC_VECTOR(7 downto 0);
	signal regG_in_wire : STD_LOGIC_VECTOR(7 downto 0);
	signal regG_out_wire : STD_LOGIC_VECTOR(7 downto 0);
	signal bin_to_bcd_wire : STD_LOGIC_VECTOR(11 downto 0);
	signal anode : STD_LOGIC_VECTOR(7 downto 0);

	BEGIN
		
		U1: FSM
			port map (A => SW, B => SW, buttonC => BTNC ,reset => reset, clk => CLK100MHZ, operandA => regA_in_wire, operandB => regB_in_wire);
        U2: ALU_8_bit
            port map (buttonU => BTNU, buttonD => BTND, buttonL => BTNL, buttonR => BTNR, clk => CLK100MHZ,  A => regA_out_wire, B => regB_out_wire, result => regG_in_wire);
        U3: operandA
            port map(D => regA_in_wire, Clk => CLK100MHZ, En => '0', Q => regA_out_wire);
        U4: operandB
            port map(D => regB_in_wire, Clk => CLK100MHZ, En => '0', Q => regB_out_wire);
        U5: operandG
            port map(D => regG_in_wire, Clk => CLK100MHZ, En => '0', Q => regG_out_wire);
        U6: BIN2BCD
            port map(BINARY =>  regG_out_wire, BCD => bin_to_bcd_wire);
        U7: seg7
            port map(bcd => bin_to_bcd_wire(3 downto 0), CA => CA, CB => CB, CC => CC, CD => CD, CE => CE, CF => CF, CG => CG);
        U8: seg7
            port map(bcd => bin_to_bcd_wire(7 downto 4));
        U9: seg7
            port map(bcd => bin_to_bcd_wire(11 downto 8));
            
        LED <= regG_in_wire;

END BEHAVIOUR;
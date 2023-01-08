LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- VHDL project: VHDL code for single-cycle MIPS Processor
-- VHDL testbench code for single-cycle MIPS Processor
ENTITY tb_MIPS_VHDL IS
END tb_MIPS_VHDL;

ARCHITECTURE behavior OF tb_MIPS_VHDL IS
  -- Component Declaration for the single-cycle MIPS Processor in VHDL
  COMPONENT MIPS_VHDL
    PORT (
      clk : IN STD_LOGIC;
      reset : IN STD_LOGIC;
      pc_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      alu_result : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
  END COMPONENT;

  --Inputs
  SIGNAL clk : STD_LOGIC := '0';
  SIGNAL reset : STD_LOGIC := '0';
  --Outputs
  SIGNAL pc_out : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL alu_result : STD_LOGIC_VECTOR(15 DOWNTO 0);
  -- Clock period definitions
  CONSTANT clk_period : TIME := 10 ns;

BEGIN
  -- Instantiate the for the single-cycle MIPS Processor in VHDL
  uut : MIPS_VHDL PORT MAP(
    clk => clk,
    reset => reset,
    pc_out => pc_out,
    alu_result => alu_result
  );

  -- Clock process definitions
  clk_process : PROCESS
  BEGIN
    clk <= '0';
    WAIT FOR clk_period/2;
    clk <= '1';
    WAIT FOR clk_period/2;
  END PROCESS;

  
  -- Stimulus process
  stim_proc : PROCESS
  BEGIN
    reset <= '1';
    WAIT FOR clk_period * 10;
    reset <= '0';
    -- insert stimulus here 
    WAIT;
  END PROCESS;

END;
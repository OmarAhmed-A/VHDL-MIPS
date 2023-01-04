LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- VHDL project: VHDL code for single-cycle MIPS Processor
-- VHDL testbench code for single-cycle MIPS Processor
ENTITY tb_MIPS_VHDL IS
END tb_MIPS_VHDL;
 
ARCHITECTURE behavior OF tb_MIPS_VHDL IS 
    -- Component Declaration for the single-cycle MIPS Processor in VHDL
    COMPONENT MIPS_VHDL
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         pc_out : OUT  std_logic_vector(15 downto 0);
         alu_result : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   --Outputs
   signal pc_out : std_logic_vector(15 downto 0);
   signal alu_result : std_logic_vector(15 downto 0);
   -- Clock period definitions
   constant clk_period : time := 10 ns;
BEGIN
 -- Instantiate the for the single-cycle MIPS Processor in VHDL
   uut: MIPS_VHDL PORT MAP (
          clk => clk,
          reset => reset,
          pc_out => pc_out,
          alu_result => alu_result
        );

   -- Clock process definitions
   clk_process :process
   begin
  clk <= '0';
  wait for clk_period/2;
  clk <= '1';
  wait for clk_period/2;
   end process;
   -- Stimulus process
   stim_proc: process
   begin  
      reset <= '1';
      wait for clk_period*10;
  reset <= '0';
      -- insert stimulus here 
      wait;
   end process;

END;
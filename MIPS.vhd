LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.std_logic_signed.ALL;
LIBRARY work;

-- VHDL project: VHDL code for single-cycle MIPS Processor
ENTITY MIPS_VHDL IS
  PORT (
    clk, reset : IN STD_LOGIC;
    pc_out, alu_result : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
END MIPS_VHDL;

ARCHITECTURE Behavioral OF MIPS_VHDL IS
  SIGNAL pc_current : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL pc_next, pc2 : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL instr : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL reg_dst, mem_to_reg, alu_op : STD_LOGIC_VECTOR(1 DOWNTO 0);
  SIGNAL jump, branch, mem_read, mem_write, alu_src, reg_write : STD_LOGIC;
  SIGNAL reg_write_dest : STD_LOGIC_VECTOR(2 DOWNTO 0);
  SIGNAL reg_write_data : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL reg_read_addr_1 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  SIGNAL reg_read_data_1 : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL reg_read_addr_2 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  SIGNAL reg_read_data_2 : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL sign_ext_im, read_data2, zero_ext_im, imm_ext : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL JRControl : STD_LOGIC;
  SIGNAL ALU_Control : STD_LOGIC_VECTOR(2 DOWNTO 0);
  SIGNAL ALU_out : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL zero_flag : STD_LOGIC;
  SIGNAL im_shift_1, PC_j, PC_beq, PC_4beq, PC_4beqj, PC_jr : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL beq_control : STD_LOGIC;
  SIGNAL jump_shift_1 : STD_LOGIC_VECTOR(14 DOWNTO 0);
  SIGNAL mem_read_data : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL no_sign_ext : STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL sign_or_zero : STD_LOGIC;
  SIGNAL tmp1 : STD_LOGIC_VECTOR(8 DOWNTO 0);
BEGIN
  -- Program counter
  PROCESS (clk, reset)
  BEGIN
    IF (reset = '1') THEN
      pc_current <= x"0000";
    ELSIF (rising_edge(clk)) THEN
      pc_current <= pc_next;
    END IF;
  END PROCESS;

  
  -- PC + 2 
  pc2 <= pc_current + x"0002";
  -- PC beq add
  PC_beq <= (pc2 - no_sign_ext) WHEN im_shift_1(15) = '1' ELSE
    (pc2 + im_shift_1);
  -- beq control
  beq_control <= branch AND zero_flag;
  -- PC_beq
  PC_4beq <= PC_beq WHEN beq_control = '1' ELSE
    pc2;
  -- PC_j
  PC_j <= pc2(15) & jump_shift_1;
  -- PC_4beqj
  PC_4beqj <= PC_j WHEN jump = '1' ELSE
    PC_4beq;
  -- PC_jr
  PC_jr <= reg_read_data_1;
  -- PC_next
  pc_next <= PC_jr WHEN (JRControl = '1') ELSE
    PC_4beqj;


  -- jump shift left 1
  jump_shift_1 <= instr(13 DOWNTO 0) & '0';


  -- sign extend
  tmp1 <= (OTHERS => instr(6));
  sign_ext_im <= tmp1 & instr(6 DOWNTO 0);
  zero_ext_im <= "000000000" & instr(6 DOWNTO 0);
  imm_ext <= sign_ext_im WHEN sign_or_zero = '1' ELSE
    zero_ext_im;


  -- JR control unit
  JRControl <= '1' WHEN ((alu_op = "00") AND (instr(3 DOWNTO 0) = "1000")) ELSE
    '0';

  -- multiplexer alu_src
  read_data2 <= imm_ext WHEN alu_src = '1' ELSE
    reg_read_data_2;


  -- immediate shift 1
  im_shift_1 <= imm_ext(14 DOWNTO 0) & '0';
  no_sign_ext <= (NOT im_shift_1) + x"0001";


  -- instruction memory
  Instruction_Memory : ENTITY work.Instruction_Memory_VHDL
    PORT MAP
    (
      pc => pc_current,
      instruction => instr
    );

  -- control unit
  control : ENTITY work.control_unit_VHDL
    PORT MAP
    (
      reset => reset,
      opcode => instr(15 DOWNTO 13),
      reg_dst => reg_dst,
      mem_to_reg => mem_to_reg,
      alu_op => alu_op,
      jump => jump,
      branch => branch,
      mem_read => mem_read,
      mem_write => mem_write,
      alu_src => alu_src,
      reg_write => reg_write,
      sign_or_zero => sign_or_zero
    );

  -- register file 
  register_file : ENTITY work.register_file_VHDL
    PORT MAP
    (
      clk => clk,
      rst => reset,
      reg_write_en => reg_write,
      reg_write_dest => reg_write_dest,
      reg_write_data => reg_write_data,
      reg_read_addr_1 => reg_read_addr_1,
      reg_read_data_1 => reg_read_data_1,
      reg_read_addr_2 => reg_read_addr_2,
      reg_read_data_2 => reg_read_data_2
    );
  -- ALU control unit
  ALUControl : ENTITY work.ALU_Control_VHDL PORT MAP
    (
    ALUOp => alu_op,
    ALU_Funct => instr(2 DOWNTO 0),
    ALU_Control => ALU_Control
    );
  -- ALU unit
  alu : ENTITY work.ALU_VHDL PORT MAP
    (
    a => reg_read_data_1,
    b => read_data2,
    alu_control => ALU_Control,
    alu_result => ALU_out,
    zero => zero_flag
    );
  -- data memory
  data_memory : ENTITY work.Data_Memory_VHDL PORT MAP
    (
    clk => clk,
    mem_access_addr => ALU_out,
    mem_write_data => reg_read_data_2,
    mem_write_en => mem_write,
    mem_read => mem_read,
    mem_read_data => mem_read_data
    );

  -- write back (the final output stage of the pipeline)
  reg_write_data <= pc2 WHEN (mem_to_reg = "10") ELSE
    mem_read_data WHEN (mem_to_reg = "01") ELSE
    ALU_out;


  -- output
  pc_out <= pc_current;
  alu_result <= ALU_out;

  -- The reg_write_data signal is being assigned 
  -- a value based on the value of the mem_to_reg signal.
  -- If mem_to_reg is equal to "10", then reg_write_data is assigned the value of pc2.
  -- If mem_to_reg is equal to "01", then reg_write_data is assigned the value of mem_read_data.
  -- Otherwise, reg_write_data is assigned the value of ALU_out.

  -- The pc_out and alu_result signals are then assigned the values of pc_current and ALU_out, respectively.
  -- This allows the current value of the program counter and the result of the ALU to be output from the processor.

END Behavioral;
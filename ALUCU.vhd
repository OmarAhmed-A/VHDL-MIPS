library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- VHDL code for ALU Control Unit of the MIPS Processor
entity ALU_Control_VHDL is
port(
  ALU_Control: out std_logic_vector(2 downto 0);
  ALUOp : in std_logic_vector(1 downto 0);
  ALU_Funct : in std_logic_vector(2 downto 0)
);
end ALU_Control_VHDL;

architecture Behavioral of ALU_Control_VHDL is
begin
process(ALUOp,ALU_Funct)
begin
case ALUOp is
when "00" => 
 ALU_Control <= ALU_Funct(2 downto 0);
when "01" => 
 ALU_Control <= "001";
when "10" => 
 ALU_Control <= "100";
when "11" => 
 ALU_Control <= "000";
when others => ALU_Control <= "000";
end case;
end process;
end Behavioral;
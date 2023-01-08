LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
-- VHDL code for the register file of the MIPS Processor
ENTITY register_file_VHDL IS
  PORT (
    clk, rst : IN STD_LOGIC;
    reg_write_en : IN STD_LOGIC;
    reg_write_dest : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    reg_write_data : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    reg_read_addr_1 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    reg_read_data_1 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    reg_read_addr_2 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    reg_read_data_2 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
END register_file_VHDL;

ARCHITECTURE Behavioral OF register_file_VHDL IS
  TYPE reg_type IS ARRAY (0 TO 7) OF STD_LOGIC_VECTOR (15 DOWNTO 0);
  SIGNAL reg_array : reg_type;
BEGIN
  PROCESS (clk, rst)
  BEGIN
    IF (rst = '1') THEN
      reg_array(0) <= x"0001";
      reg_array(1) <= x"0002";
      reg_array(2) <= x"0003";
      reg_array(3) <= x"0004";
      reg_array(4) <= x"0005";
      reg_array(5) <= x"0006";
      reg_array(6) <= x"0007";
      reg_array(7) <= x"0008";
    ELSIF (rising_edge(clk)) THEN
      IF (reg_write_en = '1') THEN
        reg_array(to_integer(unsigned(reg_write_dest))) <= reg_write_data;
      END IF;
    END IF;
  END PROCESS;

  reg_read_data_1 <= x"0000" WHEN reg_read_addr_1 = "000" ELSE
    reg_array(to_integer(unsigned(reg_read_addr_1)));
  reg_read_data_2 <= x"0000" WHEN reg_read_addr_2 = "000" ELSE
    reg_array(to_integer(unsigned(reg_read_addr_2)));

END Behavioral;
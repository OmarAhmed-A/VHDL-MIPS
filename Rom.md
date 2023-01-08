# Here is a description of each instruction in the ROM

"1000000110000000": This is a "lw" (load word) instruction, which loads a word (16-bit value) from memory into a register. The instruction has the following format: "lw \$rd, offset(\$rs)". The \$rd field specifies the destination register, the \$rs field specifies the source register, and the offset field specifies the offset from the address stored in the source register.

"0010110010001011": This is a "sltiu" (set on less than immediate unsigned) instruction, which sets a register to 1 if the value in the source register is less than an immediate value, or to 0 if the value in the source register is greater than or equal to the immediate value. The instruction has the following format: "sltiu \$rt, \$rs, immediate". The \$rt field specifies the destination register, the \$rs field specifies the source register, and the immediate field specifies the immediate value.

"1100010000000011": This is a "beq" (branch if equal) instruction, which branches to a specified address if the values in two registers are equal, or continues execution at the next instruction if the values are not equal. The instruction has the following format: "beq \$rs, \$rt, offset". The \$rs and \$rt fields specify the registers to compare, and the offset field specifies the offset from the current address to the target address.

"0001000111000000": This is an "add" instruction, which adds the values in two registers and stores the result in a destination register. The instruction has the following format: "add \$rd, \$rs, \$rt". The \$rd field specifies the destination register, and the \$rs and \$rt

"1110110110000001": This is an "addi" (add immediate) instruction, which adds an immediate value to the value in a source register and stores the result in a destination register. The instruction has the following format: "addi \$rt, \$rs, immediate". The \$rt field specifies the destination register, the \$rs field specifies the source register, and the immediate field specifies the immediate value.

"1100000001111011": This is a "beq" (branch if equal) instruction, similar to the one described above. It branches to a specified address if the values in two registers are equal, or continues execution at the next instruction if the values are not equal.

# What are the magic signals for the MIPS processor?

`jump_shift_1`: This signal stores the lower 14 bits of the "instr" signal concatenated with a 0 bit. The "instr" signal stores the current instruction being executed.

`tmp1`: This signal stores a 9-bit value that is used to sign extend the lower 7 bits of the "instr" signal. The value is set to all 1's if the most significant bit of the "instr" signal is 1, or all 0's if the most significant bit is 0.

`sign_ext_im`: This signal stores a 16-bit value that is created by sign extending the lower 7 bits of the "instr" signal. The sign extension is performed by concatenating the "tmp1" signal with the lower 7 bits of the "instr" signal.

`zero_ext_im`: This signal stores a 16-bit value that is created by zero extending the lower 7 bits of the "instr" signal. The zero extension is performed by concatenating 9 0 bits with the lower 7 bits of the "instr" signal.

`imm_ext`: This signal stores either the sign extended or zero extended version of the lower 7 bits of the "instr" signal, depending on the value of the "sign_or_zero" signal. If "sign_or_zero" is 1, "imm_ext" is set to the value of "sign_ext_im". If "sign_or_zero" is 0, "imm_ext" is set to the value of "zero_ext_im".

`JRControl`: This signal is used to control the execution of a "jump register" (jr) instruction. It is set to 1 if the "alu_op" signal is 00 and the lower 4 bits of the "instr" signal are 1000, indicating that a jr instruction is being executed. Otherwise, it is set to 0.

`read_data2`: This signal is used as one of the inputs to the ALU (arithmetic and logic unit). If the "alu_src" signal is 1, "read_data2" is set to the value of "imm_ext", which is the sign or zero extended version of the lower 7 bits of the "instr" signal. If "alu_src" is 0, "read_data2" is set to the value of "reg_read_data_2", which is the value of a register specified in the instruction.

`im_shift_1`: This signal stores the lower 15 bits of the "imm_ext" signal concatenated with a 0 bit.

`no_sign_ext`: This signal stores a 16-bit value that is created by inverting the "im_shift_1" signal and adding 1. This value is used to calculate the value of the PC_beq signal in some cases.

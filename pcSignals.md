# Program counter signals

`pc2`: This signal stores the value of the program counter plus 2, which is used as the next value of the program counter in some situations.

`PC_beq`: This signal stores the value that the program counter should have if a "branch if equal" (beq) instruction is being executed and the branch condition is true. This value is calculated by subtracting the "no_sign_ext" signal from the pc2 signal if the most significant bit of the "im_shift_1" signal is 1, or by adding the "im_shift_1" signal to the pc2 signal if the most significant bit of the "im_shift_1" signal is 0.

`beq_control`: This signal is used to control the execution of a "branch if equal" (beq) instruction. It is set to 1 if the "branch" signal is 1 and the "zero_flag" signal is 1, indicating that the branch condition is true and the beq instruction should be executed. Otherwise, it is set to 0.

`PC_4beq`: This signal stores the value that the program counter should have if a "branch if equal" (beq) instruction is being executed. If the "beq_control" signal is 1, indicating that the beq instruction should be executed, this signal is set to the value stored in the PC_beq signal. Otherwise, it is set to the value stored in the pc2 signal.

`PC_j`: This signal stores the value that the program counter should have if a "jump" instruction is being executed. This value is calculated by concatenating the most significant bit of the pc2 signal with the "jump_shift_1" signal.

`PC_4beqj`: This signal stores the value that the program counter should have if a "jump" instruction is being executed, or if a "branch if equal" (beq) instruction is being executed and the branch condition is true. If the "jump" signal is 1, indicating that a jump instruction is being executed, this signal is set to the value stored in the PC_j signal. Otherwise, it is set to the value stored in the PC_4beq signal.

`PC_jr`: This signal stores the value that the program counter should have if a "jump register" (jr) instruction is being executed. This value is taken from the "reg_read_data_1" signal, which stores the value of a register specified in the jr instruction.

`pc_next`: This signal stores the next value of the program counter. If the "JRControl" signal is 1, indicating that a "jump register" (jr) instruction is being executed, this signal is set to the value stored in the PC_jr signal. Otherwise, it is set to the value stored in the PC_4beqj signal.

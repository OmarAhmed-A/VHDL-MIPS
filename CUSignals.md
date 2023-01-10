# Control Unit signals

| Activity          | Signal    | Purpose                                                                                    |
|-------------------|-----------|------------------------------------------------------------------------------------------|
| PC Update         | Branch    | Combined with a condition test boolean to enable loading the branch target address into the PC. |
|                   | Jump      | Enables loading the jump target address into the PC (only appears in Figure 4.24 in Patterson and Hennessey). |
| Source Operand Fetch | ALUSrc | Selects the second source operand for the ALU (rt or sign-extended immediate field in Patterson and Hennessey). |
| ALU Operation     | ALUOp     | Either specifies the ALU operation to be performed or specifies that the operation should be determined from the function bits. |
| Memory Access     | MemRead   | Enables a memory read for load instructions. |
|                   | MemWrite  | Enables a memory write for store instructions. |
| Register Write    | RegWrite  | Enables a write to one of the registers. |
|                   | RegDst    | Determines how the destination register is specified (rt or rd in Patterson and Hennessey). |
|                   | MemtoReg  | Determines where the value to be written comes from (ALU result or memory in Patterson and Hennessey). |

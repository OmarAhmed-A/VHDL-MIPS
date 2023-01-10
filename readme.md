# MIPS Processor in VHDL

This repository contains the VHDL code for a MIPS processor, including the following components:

- Program counter (PC)
- Instruction memory
- Control unit
- Register file
- Arithmetic and Logic Unit (ALU)
- Data memory

this project was done as part of the Digital system design course at the AAST. The project was done in VHDL and was simulated using GHDL.

## Contributors

- Omar Ahmed Elsayed
- Ammar Abdelhamid Amin
- Youssef Mohamed Fahmy
- Ahmed Osama
- Hassan mikawii
- Omar Mohamed Anwar

## How to Use

To use the MIPS processor, you will need a VHDL simulator such as [GHDL](https://ghdl.readthedocs.io/en/latest/). You can then compile and simulate the processor by following these steps:

1. Clone this repository to your local machine: `git clone https://github.com/[USERNAME]/mips-processor-vhdl.git`
2. Change directory into the repository: `cd mips-processor-vhdl`
3. run make: `make` or `make all` to compile and simulate the processor  
   or
   `ghdl -a --ieee=synopsys -fexplicit *.vhd`
   then `ghdl -e --ieee=synopsys -fexplicit main_processor`
   then `ghdl -r --ieee=synopsys -fexplicit main_processor --vcd=main_processor.vcd`
   then `gtkwave main_processor.vcd` to compile and simulate the processor

## Components

The MIPS processor includes the following components:

### Program Counter (PC)

The PC is responsible for storing the address of the next instruction to be executed. It is updated every clock cycle, either by incrementing its value by 2 (to skip over the fixed-size instruction word) or by jumping to a new address specified by the instruction. Signals are used to control the operation of the PC. (See [pcSignals.md](pcSignals.md) for more information.

### Instruction Memory

The instruction memory stores the [instructions](Rom.md) of the program being executed. It has a single input (the PC) and a single output (the instruction).

### Control Unit

The control unit decodes the instruction and generates the [control signals](CUSignals.md) needed to execute it. The control signals are used to control the operation of the other components of the processor.

### Register File

The register file stores the values of the processor's 8 general-purpose registers. It has two input addresses (used to specify the registers to be read) and two data outputs

## ALU

This module performs arithmetic and logical operations on two input values and outputs the result. The operation to be performed is determined by the control signals from the Control Unit.

## Data Memory

This module stores the data for the processor. It has a read port and a write port, allowing a memory location to be read or written to in a single clock cycle.

## Main Processor

This module brings together all the above modules to form a complete MIPS processor. It is a single clock-cycle processor, meaning that it executes one instruction per clock cycle. Some signals in the begining of the file that may not be clear are documented [here](mgicSignalsMips.md).

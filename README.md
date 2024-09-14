# RISC-V 32I Base Processor Implementation
This implementation includes only 38 instructions including no operation(NOP) and except all system instructions

## Overview
This repository contains a Verilog implementation of a RISC-V 32I base processor. The design adheres to the RISC-V 32-bit integer (RV32I) specification and includes essential components such as the ALU, register file, instruction decoder, and control unit.

## Features
- **RISC-V 32I ISA**: Supports all standard integer instructions defined by the RISC-V 32I instruction set architecture.
- **Arithmetic and Logic Operations**: Addition, subtraction, logical AND, OR, XOR, shifts (logical and arithmetic), and comparisons.
- **Register File**: 32 general-purpose registers with read and write capabilities.
- **Instruction Decoding**: Decodes RISC-V instructions and generates appropriate control signals.
- **Memory Access**: Implements basic load and store operations for interacting with memory.

## Components
- **ALU**: Performs arithmetic and logic operations.
- **Register File**: Manages 32 registers for storing intermediate values.
- **Instruction Decoder**: Interprets RISC-V instructions and generates control signals.
- **Control Unit**: Directs the operation of the ALU, register file, and memory based on the decoded instructions.




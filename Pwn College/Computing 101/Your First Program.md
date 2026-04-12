# Computing 101 - 'Your First Program'

---

### Lecture 1 - Computer Architecture

- A CPU reads and executes binary instructions

- Low level languages (C, C++, Rust) are turned into binary instructions at runtime

- Higher level languages like Java and Python use an interpreter, which is a program that executes binary instructions based on the code written

- A higher level language can also use a Just-In-Time (JIT) compiler, which compiles the instructions into binary at runtime

- Most CPUs use the Von Neumann architecture, with a Control Unit to intepret and execute instructions, an Arithmetic Logic Unit which does maths, comparisons, logic, etc, Registers which store values, and Cache which hold small bits of memory for quick access

- Modern CPUs generally have multiple cores all with this architecture, along with an additional shared cache all cores can access

- The CPU communicates with Memory and Storage (Disk) to access information which is loaded into cache and the registers

---

### Lecture 2 - Assembly Crash Course

- Assembly is a text representation of the binary instructions the CPU uses

- Assembly is (generally) equivalent to binary instructions - that is, one instruction in assembly is one binary instruction, unlike programming languages where each instruction corresponds to multiple, possibly huge amounts, of binary instructions

- Each assembly instruction is made up an operation, what the instruction is doing, and possibly operands, what data the instruction is using for its operation

- Assembly uses data that is passed to it in instructions, data stored in the registers (or cache), and data stored in memory

- Each instruction regardless of assembly language follows the pattern `operation [operand1] [operand2] [operand3] ...` 

- 

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

- Each assembly instruction is made up an operation (what the instruction is doing), and possibly operands (what data the instruction is using for its operation)

- Assembly uses data that is passed to it in instructions, data stored in the registers (or cache), and data stored in memory

- Each instruction regardless of assembly language follows the pattern `operation [operand1] [operand2] [operand3] ...` 

- By far the most common assembly languages are x86 (used on PCs, servers, and some networking devices) and ARM (used on all phones, some laptops, and some networking devices), but others include MIPS (older, CTF popular), PowerPC (more niche), RISC-V (embedded devices, growing popularity), or PTX (NVIDIA CUDA GPU pseudo-assembly, very niche)

- x86 has two main families (differ by generation, dialect, extensions, but each family largely the same): Intel and AT&T - Intel is by far more common and popular, and was the original

- ARM has 3 main families: AArch32 - the legacy original, AArch64 - a redesign and the modern go-to, and Thumb - a compressed instruction set of AArch32 for low memory usage

---

### Lecture 3 - Registers

- Registers are very fast but very expensive temporary data stores

- Together, registers within a CPU core make up what is called the "register file"

- Data is either returned from instructions into the registers or taken from memory, into cache, and then into the registers for immediate processing

- General purpose registers can be given data to store as required, whereas non-general-purpose registers are specialized and generally more restricted in their usage, such as the instruction pointer or stack pointer

- In amd64, there are 16 general purpose registers: rax, rcx, rdx, rbx, rsp, rbp, rsi, rdi, r8, r9, r10, r11, r12, r13, r14, and r15

- arm instead has 15: r0 through r14

- The instruction pointer which points to the next instruction, is rip in amd64, or r15 in arm

- The register size is typically the same size as the word width of the architecture, for example an amd64 register is 64-bits

- A register can be accessed in its entirety or partially: for amd64, rax is the entire 64 bits, eax is the lower 32 bits, ax the lowest 16 bits, and within ax there is al (the lower byte) and ah (the upper byte) - although only rax, rcx, rdx and rbx allow this upper byte access

- The instruction `mov` is used to set register values - it can set an immediate value (raw data itself, such as `mov rax, 1337` (dec) or `mov rbx, 0x539` (hex))

- You can set *part* of a register and leave the other part - for example `mov ah, 0x5` and then `mov al, 0x39` gives you `rax` with value `0x0000000000000539`

- *However*, for 32-bit references such as `eax`, the whole register will be zeroed first:
  
  - If you do `mov rax, 0xffffffffffffffff` then `mov ax, 0x539` you will get `rax` with value `0xffffffffffff0539`
  
  - But if instead you do `mov rax, 0xffffffffffffffff` then `mov eax, 0x539` you will get `rax` with value `0x0000000000000539` - `rax` is set to `0x0000000000000000` and *then* `0x0000000000000539`
  
  - This only applies to 32-bit references (and obviously 64-bit references): 16-bit and 8-bit references only alter their specified bits and no more

- f

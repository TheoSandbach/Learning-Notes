# Computing 101 - Control Flow

---

### Lecture 1 - Control Flow

+ x86_64 is a *variable width instruction set architecture* - instructions are not a set width, with some instructions only taking one byte to encode, some three bytes, etc
+ The binary code of a program being executed lives in memory in a sequential order
+ The CPU will continue to move through the program in order, step by step, unless it is told to move elsewhere via a control flow instruction
+ One example of such an instruction is `jmp`, which tells the CPU to skip a number of bytes in memory to 'jump' somewhere else in the set of instructions
+ `jmp` can move forwards or backwards depending on the byte it has as an argument: this byte is signed and so any value over `0x7f` is negative, allowing for `jmp` to move forwards or backwards by up to 127 bytes
+ `jmp -2` simply skips back to the start of the `jmp` instruction, creating an infinite loop: this instruction is `eb fe` in hex

---

### Notes from Challenges

- 

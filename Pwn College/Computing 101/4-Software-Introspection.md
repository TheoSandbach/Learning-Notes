# Computing 101 - Software Introspection

---

### Lecture 1 - Data

- ASCII has evolved into UTF-8 which encodes almost all text on the web
  
  - The first 128 characters in UTF-8 are ASCII, with the leading bit signifying whether this is an ASCII character (`0x00` - `0x7f`) or an extended character (`0x80` onwards)
  
  - Extended UTF-8 characters can be huge, as UTF-8 characters are variable length and can be encoded in up to 4 bytes, allowing (within the complex encoding rules) for roughly 1.1 million characters to be encoded (but only around 150,000 encodings are used)
  
  - `0x00` through `0x1f` are *control characters* - things like newline, tab, etc

- There is no requirement for bytes to be 8 bits, and for some systems bytes can be anything from 6 or 7 bits to 31 or 36 bytes (again, not limits - can be higher or lower), the 8-bit byte is simply historical

- *Words* are groupings of 8-bit bytes, with some quirky labelling due to historic confusion - in x86 the terms are such:
  
  - A *Word* (**Word**) is 2 bytes, or 16 bits
  
  - A *Double Word* (**Dword**) is 4 bytes, or 32 bits
  
  - A *Quad Word* (**Qword**) is 8 bytes, or 64 bits
  
  - *But*, in ARM architecture this is all halved - 2 bytes is a Half Word, 4 bytes a Word, and 8 bytes a Double Word

- Binary numbers are usually expressed with `0b` preceeding, such as `0b10011011`

- 64-bit architecture, like x86-64, can reason with 64 bits at a time - numbers between 0 and 18 quintillion (`0xffffffffffffffff`)

- If you add 1 to this maximum you get an integer overflow - the value loops back to `0x0`, and the computer's carry bit is set to 1

- To express negative numbers, we use sign bits:
  
  - The first bit is the sign bit, that says whether a number is positive or negative: so `0b01101010` is positive and `0b11101010` is negative (first bit 0 is positive, first bit 1 is negative)

- To figure out the negative of a number (in 8 bits), subtract the positive binary representation of that number from 255/-1 (`0xff`) and add 1 to the result: so -15 becomes `0b11111111` (255) - `0b00001111` (15) + `0b00000001` (1) = `0b11110001` (-15)

- The leftmost of a binary number, the largest number, is called the highest bit or byte, or the *most significant* bit / byte

- Similarly the rightmost bit or byte is called the lowest bit / byte, or the *least significant* bit / byte

---

### Notes from Challenges

- The linux tool `objdump` is used to disassemble the executable parts of a binary file into readable assembly code
  
  - The option `-d` is used to disassemble with `objdump` (`objdump -d`)
  
  - By default, `objdump` outputs in AT&T syntax, to instead output in Intel syntax, the option `-M intel` is used
  
  - Each line shows the location the instruction has in memory when the program is run, the binary of the instruction and its arguments in hex, and then the plaintext of the instruction and its arguments in the requested syntax
  
  - It is important to remember that data is stored in memory in little endian order, so `0x539` is stored as `39` `05`

- Another important tool is `strace`, which when given a program, will reports every system call triggered by the program, all parameters that were passed to that system call, and what data that system call returned
  
  - All parameters for the system call are given in brackets following the name of the system call, so for system call 60 (exit) with parameter 42, we get `exit(42)`
  
  - The first system call listed is always `execve`, which is not actually triggered by the program itself, but is how the program is started

- The system call `alarm` has syscall code 37, and uses its parameter as the number of seconds the OS counts for until it closes the program

- GDB (GNU Debugger) is a commonly used Linux debugger, used for inspecting and finding bugs within programs

- Starting GDB is as simple as `gdb [program]`, and quitting is done by typing `q` or `quit` into the GDB command prompt

- When running GDB, `starti` is used to execute the program from the first instruction, so the raw assembly can be viewed

- After the program has been started, `disassemble` is used to actually show the raw assembly

- The instruction `stepi` (or `si` for short) can be used to step through the program one line at a time, executing one instruction then waiting

- `print` can be used to view values, such as registers - the prefix `$` is used to signify a register value, for example `print $rdi` outputs the value of the register `rdi`
  
  - Immediate values do not require the prefix `$`, instead they can just be written as-is: `print 0x7d24`

- To view the contents of memory directly, the instruction `x` is used, for example to view the memory location that `rsp` is pointing to, the instruction is `x $rsp`
  
  - This outputs in hex by default, to view in decimal, a forward slash and "d" is appended after `x`: so  `x/d`
  
  - To view the contents of a memory address as holding an address (for example the values in the stack after argument count, which are addresses for the argument values) the suffix `/a` is used
  
  - To view the contents of a memory address as a string, `/s` is used

- If instead of `starti`, the command `run` is used, then GDB will execute the program without stopping, until it reaches a program breakpoint, such as the assembly instruction `int3`
  
  - Note that when a program with an `int3` instruction is executed outside of GDB, it will *also* stop executing at this instruction, so all such instructions must be removed for the program to execute fully

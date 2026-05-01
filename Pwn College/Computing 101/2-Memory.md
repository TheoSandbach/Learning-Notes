# Computing 101 - Memory

---

### Lecture 1 - Memory

- Registers are expensive and we can only fit a small number of them within the CPU
- So we need Memory to store data we don't need as immediately
- Data is taken from memory, through the data bus, into the cache, and from the cache to the registers for processing
- Memory receives data from and sends data to the registers (CPU), disk, network and the GPU
- Memory addresses are numbered linearly, with each address a hex number that references one byte (8 bits) within memory
- Memory addresses span from `0x10000` (65,536 or 2^16, addresses start here for security reasons) to `0x7fffffffffff` (2^47 - 1, and another 2^47 bytes beyond this are used by the kernel) - almost 128 TB of addresses
- Clearly the RAM of almost any computer isn't this large, but these addresses are still used by VRAM (Virtual memory)
- A program or process starts with an alloted amount of memory (Dynamically Allocated Memory), but can ask for more from the OS if needed (Dynamically Mapped Memory)
- The stack is a location in memory that can be used for multiple things, such as temporary value storage
- We can use the command `push` to push an immediate value (*must* be 32-bit or 8-bit) or a register value (full 64-bit register reference) onto the top of the stack, for example `push 0xb0bacafe` or `push rax`
- We can then use `pop` to pop the top value off the stack into a register - `pop rax` will take whatever value was most recently `push`ed to stack, remove it from the stack and set `rax` to that value (technically the value isn't 'removed', the stack pointer is just moved to ignore it)
- `push` and `pop` can take 32-bit (64-bit instructions too long to be desirable) or 8-bit (performance) immediate value arguments, such as `0x83` or `0xf36e0ac4`, or 64-bit (standard) or 16-bit (legacy, avoid using as can mess up stack pointer) register references, such as `rax` or `bx`
- For example if we `push 0xc001ca75` and `push 0xb0bacafe` in that order, then we do `pop rax` and `pop rbx`, then `rax` has value `0xb0bacafe` (the top value was popped first) and `rbx` has value `0xc001ca75`(this was *pushed* first, so it was at the *bottom* of the stack and so *popped* second)
- The stack location is pointed to by the register `rsp`, and is usually very 'high up' in memory (high address number) because it grows *backwards* - pushing decreases `rsp` as the stack grows, and popping increases `rsp` as the stack shrinks
- Addresses in memory can be accessed directly using square brackets - `mov rbx, [rax]` doesn't copy the value of `rax` to `rbx`, instead it copies the value at the *memory address* that the value in `rax` is *pointing* to
- So `mov rax, 0x133337` `mov rbx, [rax]` copies the value at memory address `0x133337` into `rbx`
- Similarly, `mov rax, 0x133337` `mov [rax], rbx` stores the value stored in `rbx` to the memory address pointed to by the value stored in `rax`
- This means doing `push rax` is equivalent to `sub rsp, 8` `mov [rsp], rax`
- As each memory location points to one byte, then writing a 64-bit value to memory (8 bytes) at say memory location `0x133337` will write over addresses `0x133337` through `0x13333f` (even though stack moves backwards with more values, it still writes forwards - don't get these mixed up)
- We can use partials to write to and read from memory - for example we could write the value at `ah` to memory address `[rbx]`, or read from memory address `[rax]` to the partial register `ebx`
- Data is stored in modern systems in *little endian* - the least significant byte first: if we do `mov rbx, 0xc001ca75` `mov rax, 0x133337` `mov [rax], rbx`, then we are storing the value `0xc001ca75` at memory addresses `0x0133337` through `0x13333f`, but this is stored as such: `0x133337: 0x75`, `0x133338: 0xca`, ... `0x13333f: 0x00`
  - The bytes themselves are not rearranged, but the order of the bytes is
  - The reason little endian is used is because it makes arithmetic processes with data much easier
- Partial register references work in the same way - doing `mov bl, [rax]` after the above will still set `bl` as `0x75`, just as if we copied the value from another register
- You can do limited calculations to reference a memory address, but only of the form `reg + reg * (2 or 4 or 8) + value`, for example `mov rbx, [rsp+rax*8+4]`
- The instruction `lea` (Load Effective Address) can be used to save the resulting memory pointer of these calculations - so `lea rax, [rsp+rbx*8+2]` saves the value *of* `rsp+rbx*8+2` to register `rax`, **not** the value *at* memory address `rsp+rbx*8+2`
- The instruction pointer register `rip` cannot be read or written to itself, but the address it holds can, with commands like `lea` and `mov` - for example, `lea rax, [rip+8]`, `mov rax, [rip]`, or `mov [rip], rax`
- You generally cannot interact with memory that stores code, but memory that holds data around the code (such as in modern ELF executables) *can* be interacted with
- You can write immediate values to memory, but the size must be declared, for example `mov DWORD PTR [rax], 0x1337` (or in other assemblers, just `mov DWORD [rax], 0x1337`) (`0x1337` is not 32 bits, so it is padded with 0s into `0x00001337`)
  - BYTE is 1 byte, 8 bits
  - WORD is 2 bytes, 16 bits
  - DWORD is 4 bytes, 32 bits
  - QWORD is 8 bytes, 64 bits
  - There are further sizes, but they are much less commonly used or needed

---

### Notes from Challenges

- *Dereferencing* is the name given to using a register's stored value as a memory address, so if we do `mov rbx, [rax]` we are dereferencing the pointer `rax`

- Register values can be overwitten based on their existing values - for example we can do `mov rax, [rax]` to overwrite the value stored in `rax` with the value stored at the memory address the previous value of rax was pointing to

- An *offset* is how many bytes after a memory address pointer we access, so for `mov rax, [rbx+8]` there is an offset of 8 from the address pointed to by `rbx`

- A common security issue explored on pwn college can arise when data values and address values are mixed up in the registers

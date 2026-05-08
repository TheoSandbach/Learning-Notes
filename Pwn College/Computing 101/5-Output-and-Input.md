# Computing 101 - Output and Input

---

### Lecture 1 - System Calls

- System calls ask the OS to perform a specific function

- A system call is made by setting the value of `rax` to the code of the desired system call, and then executing the instruction `syscall`

- System calls can take a number of arguments depending on which call is being made
  
  - These arguments are supplied by setting the values of other general purpose registers, in a very specific and unintuitive order
  
  - The specific order for these is:
    
    - `rdi` - argument 1
    
    - `rsi` - argument 2
    
    - `rdx` - argument 3
    
    - `r10` - argument 4
    
    - `r8` - argument 5
    
    - `r9` - argument 6
  
  - If a particular system call only takes 2 arguments for example, it will only consider the values of the registers `rdi` and `rsi`, ignoring the others

- The return value of the system call is provided as the value of `rax`: after the system call, the value of `rax` is the return value of the system call invoked

- There are over 300 different system calls in Linux, an ordered table of these can be found at: [Linux System Call Table for x86_64 (Ryan A Chapman)]([Linux System Call Table for x86 64 &middot; Ryan A. Chapman](https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/)) 

- String arguments in memory are a contiguous series of bytes (each byte being a character code), followed by a zero byte `0x00` to terminate the string

- Using single quotes `''` in assembly around a character (for example `'f'`) will give the ASCII character code of that character as an argument (so `mov rax, 'f'` sets the value of `rax` as the ASCII character code of the lowercase letter "f", not just to "f" itself)

- Some examples of system calls are system call `60`, which is `exit`, `37` which is `alarm` , `0` which is `read` and `1` which is `write`

---

### Notes from Challenges

- As stated before, the `write` system call has system call code `1`
  
  - This call has 3 arguments that tell it where to write to, and what to write: 
    
    - File Descriptor (as `rdi`)
    
    - Memory address to start writing from (as `rsi`)
    
    - The number of characters (bytes) to write (as `rdx`)
  
  - File descriptor has 3 possible values: `0`, `1` or `2`
    
    - `0` is the file descriptor for standard input - the channel through which a process takes input
    
    - `1` is the file descriptor for standard output - the channel through which a process outputs data
    
    - `2` is the file descriptor for standard error - the channel through which processes output the details of errors
    
    - The `write` call uses file descriptor 1 or 2 typically
  
  - So to `write` the first argument passed to a program out to the terminal, we would set `rax` to `1` for `write`, `rdi` to `1` for `stdout`, set `rsi` to `[rsp+16]` (The third value in stack is the pointer to the location in memory where the first argument lives, not including the program name itself as an argument), and `rdx` to whatever the length of the argument is (for example, 2), finally `syscall`

- The `read` system call has code `0` and is almost identical to `write`
  
  - The `read` call has the same 3 arguments as `write`: File descriptor as `rdi`, memory address to read to as `rsi`, and number of characters to read as `rdx`
  
  - So to `read` 64 bytes of data from `stdin` to the top of the stack, we would set `rdi` to `0` for `stdin`, `rsi` to `rsp` to read into the stack, `rdx` to 64 to read 64 bytes of data, and `rax` to `0` for `read`, finally `syscall`

- The `open` system call has code `2` and takes 2 arguments: a pointer to a string of the filename (such as "/flag") and the mode to open the file in
  
  - The modes the file can be opened in are:
    
    - `0` - read only
    
    - `1` - write only
    
    - `2` - read and write
  
  - For the first argument, we could use the location of an argument passed to the program in memory, such as `[rsp+16]` for the first argument, or we could write a string to memory and point the instuction to that string
  
  - If `open` fails, it returns `-1` (the value of `rax` after the `syscall`)

- A string in assembly is a sequence of bytes, each byte an ASCII code, followed by a zero byte
  
  - Enclosing a character with single quotes (`'`) in assembly means use the ASCII code of the character, so `'f'` is equivalent to `0x66` (the ASCII code of `f` in hex)
  
  - The zero byte at the end is required so that instructions reading the string know where the string ends
  
  - So to load the string "hi" into memory at the location of `rsp`, we would do `mov BYTE PTR [rsp], 'h'`, `mov BYTE PTR [rsp+1], 'i'`, `mov BYTE PTR [rsp+2], 0`

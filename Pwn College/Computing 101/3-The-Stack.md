# Computing 101 - The Stack

---

### Notes from Challenges

- The Stack is a region of allocated memory used by a process that the process can use to store and load data as needed

- The data the stack pointer `rsp` points to when the program starts is the number of arguments the current process took (including the command to run the process itself) - so `./program arg1 arg2` would have 3 as the value at the memory address pointed to by the value in `rsp`

- Consecutive values in the stack are *usually* 8 bytes (64 bits) long, so the offset for `rsp` should usually be multiples of 8 (but not always)

- The data in the stack following the number of arguments are pointers to each argument stored in memory: so `[rsp+8]` points to the memory address of the first argument (the program name), `[rsp+16]` to the second argument, and so on

- The `pop` command does 2 things: it reads the value at `[rsp]` into the register supplied as the operand (so `pop rax` stores the value at `[rsp]` into `rax`), and then adds 8 to `rsp`, advancing the stack pointer to the next value in the stack

- This *does not* delete the value at the top of the stack, it simply adds 8 to the stack *pointer*, so as far as the stack is concerned, that value no longer exists - but it *is* still there, and can still be used by interacting with that memory address

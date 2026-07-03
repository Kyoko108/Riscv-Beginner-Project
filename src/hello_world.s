# =============================================================
# hello_world.s
#
# The classic. Prints "Hello, RISC-V World!" to the console
# using RARS's environment call (ecall) system, which mimics
# common syscall conventions:
#
#   a7 = 4   -> print string   (address in a0)
#   a7 = 1   -> print integer  (value in a0)
#   a7 = 10  -> exit program
#
# Run this one in RARS (Run > Assemble, then Run > Go) and
# check the "Run I/O" console tab for the output.
# =============================================================

.data
hello_msg: .asciz "Hello, RISC-V World!\n"

.text
.globl _start

_start:
    la   a0, hello_msg    # a0 = address of the string to print
    li   a7, 4              # a7 = 4 means "print string" syscall
    ecall                    # perform the syscall

    li   a7, 10               # a7 = 10 means "exit"
    ecall

## Exercises
## 1. Print your own name after the greeting (second ecall, second string).
## 2. Print an integer too: put a number in a0 and use a7 = 1.
## 3. Combine this with 03_fibonacci.s: print "fib(10) = " followed
##    by the actual computed number.

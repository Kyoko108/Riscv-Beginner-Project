# =============================================================
# 04_string_len.s
#
# Goal: byte-level memory access and null-terminated strings.
# Computes strlen() of a C-style string.
# =============================================================

.data
msg: .asciz "Hello, RISC-V!"    # .asciz auto-adds a null terminator

.text
.globl _start

_start:
    la   t0, msg          # t0 = pointer to the start of the string
    li   t1, 0            # t1 = length counter, starts at 0

count_loop:
    lb   t2, 0(t0)         # load ONE BYTE at address t0 into t2
    beqz t2, count_done    # if byte == 0 (null terminator), we're done
    addi t0, t0, 1          # move pointer forward one byte
    addi t1, t1, 1          # length++
    j    count_loop

count_done:
    # t1 now holds the string length (14, for "Hello, RISC-V!")
    mv   a0, t1              # move result into a0 for inspection

    li   a7, 10               # exit
    ecall

## Exercises
## 1. Change msg to your own string and verify the computed length.
## 2. Write a version that also counts how many characters are
##    vowels (a, e, i, o, u).
## 3. Try writing a loop that reverses the string in place.

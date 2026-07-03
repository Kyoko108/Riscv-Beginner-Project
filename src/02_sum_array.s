# =============================================================
# 02_sum_array.s
#
# Goal: learn loops and memory access (lw/sw) by summing an
# array of 32-bit integers stored in the .data section.
# =============================================================

.data
array:      .word 3, 1, 4, 1, 5, 9, 2, 6      # our test data
array_len:  .word 8                            # number of elements

.text
.globl _start

_start:
    la   t0, array         # t0 = base address of array
    lw   t1, array_len     # t1 = number of elements (8)
    li   t2, 0             # t2 = running sum, starts at 0
    li   t3, 0             # t3 = loop index i, starts at 0

loop:
    beq  t3, t1, done       # if i == len, exit loop
    slli t4, t3, 2          # t4 = i * 4  (word offset, since each int is 4 bytes)
    add  t5, t0, t4          # t5 = address of array[i]
    lw   t6, 0(t5)           # t6 = array[i]
    add  t2, t2, t6          # sum += array[i]
    addi t3, t3, 1           # i++
    j    loop

done:
    # t2 now holds the sum: 3+1+4+1+5+9+2+6 = 31
    mv   a0, t2              # move result into a0 so it's easy to inspect

    li   a7, 10              # exit
    ecall

## Exercises
## 1. Change the array values and confirm the sum is correct.
## 2. Modify this program to find the MAX value instead of the sum.
## 3. Add a second loop that multiplies every element by 2 in place
##    (hint: use `sw` to write back into the array).

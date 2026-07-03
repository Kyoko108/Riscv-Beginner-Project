# =============================================================
# 01_hello_regs.s
#
# Goal: get comfortable with RISC-V registers and basic
# arithmetic instructions. No memory, no functions — just
# moving numbers between registers.
#
# Run in RARS: open this file, click Assemble, click Run,
# then watch the register values change in the "Registers" tab.
# =============================================================

.text
.globl _start

_start:
    li   t0, 10          # t0 = 10           (li = "load immediate")
    li   t1, 32           # t1 = 32
    add  t2, t0, t1       # t2 = t0 + t1  -> 42
    sub  t3, t1, t0       # t3 = t1 - t0  -> 22
    mul  t4, t0, t1       # t4 = t0 * t1  -> 320  (needs the M extension; RARS supports it)
    slli t5, t0, 2        # t5 = t0 << 2  -> 40   (shift left logical immediate)
    andi t6, t1, 0xF      # t6 = t1 & 0xF -> 0

    # At this point, step through with the debugger (or just
    # look at the registers after running) and confirm:
    #   t2 = 42, t3 = 22, t4 = 320, t5 = 40, t6 = 0

    # Exit cleanly (RARS environment call, code 10 = exit)
    li   a7, 10
    ecall

## Exercises
## 1. Add a new register t5 that computes (t0 * t1) - t2.
## 2. Try `slti` to compare t0 and t1 and store 1/0 in a register.
## 3. Predict the value of t6 before running — were you right?

# =============================================================
# 03_fibonacci.s
#
# Goal: learn function calls, the stack, and recursion by
# computing fib(n) recursively.
#
#   fib(0) = 0
#   fib(1) = 1
#   fib(n) = fib(n-1) + fib(n-2)
#
# Calling convention reminder (RISC-V):
#   a0-a7   = argument / return registers
#   ra      = return address (set by `jal`/`call`)
#   sp      = stack pointer
#   s0-s11  = saved registers (callee must preserve these)
# =============================================================

.text
.globl _start

_start:
    li   a0, 10           # compute fib(10)
    call fib              # result comes back in a0
    mv   s1, a0           # save result somewhere safe (s1) so we can inspect it

    li   a7, 10           # exit
    ecall

# ------------------------------------------------------------
# fib(n): a0 = n on entry, a0 = fib(n) on return
# ------------------------------------------------------------
fib:
    # Base cases: if n < 2, return n as-is.
    li   t0, 2
    blt  a0, t0, fib_base

    # --- Recursive case ---
    # We need to call fib twice, so we must save:
    #   ra (our own return address)
    #   a0 (our own n), because the recursive calls will clobber it
    # on the stack before making any calls.
    addi sp, sp, -16       # allocate 16 bytes of stack space
    sw   ra, 12(sp)        # save return address
    sw   a0, 8(sp)         # save n

    addi a0, a0, -1        # a0 = n - 1
    call fib                # a0 = fib(n-1)
    sw   a0, 4(sp)          # stash fib(n-1) on the stack

    lw   a0, 8(sp)          # restore original n
    addi a0, a0, -2         # a0 = n - 2
    call fib                 # a0 = fib(n-2)

    lw   t1, 4(sp)           # t1 = fib(n-1)
    add  a0, a0, t1          # a0 = fib(n-2) + fib(n-1)

    lw   ra, 12(sp)          # restore return address
    addi sp, sp, 16          # deallocate stack space
    ret

fib_base:
    ret                      # a0 already holds n (which is 0 or 1)

## Exercises
## 1. Change n in _start and verify fib(n) by hand for small n.
## 2. Rewrite fib as an ITERATIVE loop (no recursion, no stack use)
##    — much faster and a great way to see the tradeoff.
## 3. Add a counter (in a saved register) that counts how many
##    times fib() is called for a given n.

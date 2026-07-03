# RISC-V Beginner Project

A small, hands-on project for learning RISC-V assembly. It contains a handful
of self-contained `.s` programs, from "hello registers" to a Fibonacci
calculator, plus instructions for running them with free simulators — no
physical RISC-V hardware needed.

## What's inside

| File | What it teaches |
|---|---|
| `src/01_hello_regs.s`   | Loading immediates, basic arithmetic, registers |
| `src/02_sum_array.s`    | Loops, memory access (`lw`/`sw`), pointers |
| `src/03_fibonacci.s`    | Function calls, the stack, recursion |
| `src/04_string_len.s`   | Byte access, null-terminated strings |
| `src/hello_world.s`     | Environment calls (ecall) / syscalls under RARS |

Each file has heavy comments explaining every instruction.

## Prerequisites

You need **one** of these tools (both are free):

### Option A — RARS (recommended for total beginners)
A GUI simulator, single `.jar` file, no toolchain install needed.
1. Download `rars.jar` from https://github.com/TheThirdOne/rars/releases
2. Run it: `java -jar rars.jar`
3. Open any file in `src/`, click **Assemble**, then **Run**.

### Option B — Real RISC-V GNU toolchain + `spike`/QEMU
For a more "real" experience:
```bash
# Ubuntu/Debian
sudo apt install gcc-riscv64-unknown-elf qemu-system-misc

# Assemble & link
riscv64-unknown-elf-as -march=rv32i -mabi=ilp32 -o out.o src/02_sum_array.s
riscv64-unknown-elf-ld -m elf32lriscv -o out.elf out.o

# Run under QEMU (bare metal) or use spike + pk
```
See `docs/toolchain_setup.md` for a full walkthrough.

## Suggested learning order

1. `01_hello_regs.s` – get comfortable with registers and `li`/`add`/`sub`
2. `02_sum_array.s` – loops and memory
3. `04_string_len.s` – bytes and strings
4. `03_fibonacci.s` – functions, the stack, recursion
5. `hello_world.s` – printing text via `ecall` (RARS environment calls)

## Exercises

Each program file ends with a `## Exercises` comment block suggesting
modifications to try yourself (e.g. "change this to compute the product
instead of the sum").

## License

MIT — do whatever you like with this, it's for learning.

# Setting up a Real RISC-V Toolchain (Optional)

RARS (see main README) is enough to do everything in this repo. This doc is
for people who want to go a step further and use the actual GNU toolchain +
an emulator, closer to how real embedded RISC-V development works.

## 1. Install the cross-compiler / assembler

**Ubuntu / Debian:**
```bash
sudo apt update
sudo apt install gcc-riscv64-unknown-elf qemu-system-misc
```

**macOS (Homebrew):**
```bash
brew tap riscv-software-src/riscv
brew install riscv-tools
```

**From source** (if your distro doesn't package it):
https://github.com/riscv-collab/riscv-gnu-toolchain

## 2. Assemble a file

```bash
riscv64-unknown-elf-as -march=rv32i -mabi=ilp32 \
    -o build/02_sum_array.o src/02_sum_array.s
```

## 3. Link it into an ELF binary

```bash
riscv64-unknown-elf-ld -m elf32lriscv \
    -o build/02_sum_array.elf build/02_sum_array.o
```

## 4. Run it

### With `spike` (the official RISC-V ISA simulator)
```bash
spike --isa=rv32i pk build/02_sum_array.elf
```
(`pk` is the "proxy kernel" that lets spike run simple user-mode programs
and handle syscalls like `ecall`.)

### With QEMU (bare-metal style)
QEMU's `qemu-system-riscv32` boots a whole machine, so bare `_start` programs
that call `ecall` for I/O (like ours) need a minimal runtime/linker script to
run outside of RARS. This is a bigger step — if you want to go this route,
a good next read is the "Writing a bootloader for RISC-V" style tutorials,
since it starts touching memory-mapped I/O rather than the simplified
"OS syscall" style ecalls used in this repo.

## Recommendation

Stick with RARS while you're learning the instruction set itself (this repo's
whole point). Move to the GNU toolchain + spike/QEMU once you want to explore
how a real bare-metal program boots, sets up its own stack, and talks to
hardware — that's a good "next project" after this one.

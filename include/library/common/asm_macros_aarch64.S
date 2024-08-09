/*
 * Copyright (c) 2013-2020, ARM Limited and Contributors. All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */
#ifndef ASM_MACROS_AARCH64__S
#define ASM_MACROS_AARCH64__S

    /*
     * Declare the exception vector table, enforcing it is aligned on a
     * 2KB boundary, as required by the ARMv8 architecture.
     * Use zero bytes as the fill value to be stored in the padding bytes
     * so that it inserts illegal AArch64 instructions. This increases
     * security, robustness and potentially facilitates debugging.
     */
    .macro vector_base  label, section_name=.vectors
    .section \section_name, "ax"
    .align 11, 0
    \label:
    .endm

    /*
     * Create an entry in the exception vector table, enforcing it is
     * aligned on a 128-byte boundary, as required by the ARMv8 architecture.
     * Use zero bytes as the fill value to be stored in the padding bytes
     * so that it inserts illegal AArch64 instructions. This increases
     * security, robustness and potentially facilitates debugging.
     */
    .macro vector_entry  label, section_name=.vectors
    .cfi_sections .debug_frame
    .section \section_name, "ax"
    .align 7, 0
    .type \label, %function
    .cfi_startproc
    \label:
    .endm

    /*
     * Add the bytes until fill the full exception vector, whose size is always
     * 32 instructions. If there are more than 32 instructions in the
     * exception vector then an error is emitted.
     */
    .macro end_vector_entry label
    .cfi_endproc
    .fill    \label + (32 * 4) - .
    .endm

    /*
     * Helper macro to generate the best mov/movk combinations according
     * the value to be moved. The 16 bits from '_shift' are tested and
     * if not zero, they are moved into '_reg' without affecting
     * other bits.
     */
    .macro _mov_imm16 _reg, _val, _shift
        .if (\_val >> \_shift) & 0xffff
            .if (\_val & (1 << \_shift - 1))
                movk    \_reg, (\_val >> \_shift) & 0xffff, LSL \_shift
            .else
                mov    \_reg, \_val & (0xffff << \_shift)
            .endif
        .endif
    .endm

    /*
     * Helper macro to load arbitrary values into 32 or 64-bit registers
     * which generates the best mov/movk combinations. Many base addresses
     * are 64KB aligned the macro will eliminate updating bits 15:0 in
     * that case
     */
    .macro mov_imm _reg, _val
        .if (\_val) == 0
            mov    \_reg, #0
        .else
            _mov_imm16  \_reg, (\_val), 0
            _mov_imm16  \_reg, (\_val), 16
            _mov_imm16  \_reg, (\_val), 32
            _mov_imm16  \_reg, (\_val), 48
        .endif
    .endm

    /*
     * Macro to mark instances where we're jumping to a function and don't
     * expect a return. To provide the function being jumped to with
     * additional information, we use 'bl' instruction to jump rather than
     * 'b'.
         *
     * Debuggers infer the location of a call from where LR points to, which
     * is usually the instruction after 'bl'. If this macro expansion
     * happens to be the last location in a function, that'll cause the LR
     * to point a location beyond the function, thereby misleading debugger
     * back trace. We therefore insert a 'nop' after the function call for
     * debug builds, unless 'skip_nop' parameter is non-zero.
     */
    .macro no_ret _func:req, skip_nop=0
    bl    \_func
#if DEBUG
    .ifeq \skip_nop
    nop
    .endif
#endif
    .endm

    /*
     * Helper macro to read system register value into x0
     */
    .macro read reg:req
#if ENABLE_BTI
    bti    j
#endif
    mrs    x0, \reg
    ret
    .endm

    /*
     * Helper macro to write value from x1 to system register
     */
    .macro write reg:req
#if ENABLE_BTI
    bti    j
#endif
    msr    \reg, x1
    ret
    .endm

#endif /* ASM_MACROS_AARCH64__S */

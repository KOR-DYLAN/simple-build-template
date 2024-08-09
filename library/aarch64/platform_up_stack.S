/*
 * Copyright (c) 2014-2019, ARM Limited and Contributors. All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */

#include <library/common/asm_macros_common.S>
#include <platform.h>


    .local  platform_normal_stacks
    .weak   plat_set_my_stack
    .weak   plat_get_my_stack

    /*
     * This macro calculates the base address of a UP stack using the
     * name of the stack storage and the size of the stack
     * Out: X0 = physical address of stack base
     */
    .macro get_up_stack _name, _size
    adrp    x0, (\_name + \_size)
    add     x0, x0, :lo12:(\_name + \_size)
    .endm    

    /* -----------------------------------------------------
     * uintptr_t plat_get_my_stack ()
     *
     * For cold-boot BL images, only the primary CPU needs a
     * stack. This function returns the stack pointer for a
     * stack allocated in device memory.
     * -----------------------------------------------------
     */
func plat_get_my_stack
    get_up_stack platform_normal_stacks, PLATFORM_STACK_SIZE
    ret
endfunc plat_get_my_stack

    /* -----------------------------------------------------
     * void plat_set_my_stack ()
     *
     * For cold-boot BL images, only the primary CPU needs a
     * stack. This function sets the stack pointer to a stack
     * allocated in normal memory.
     * -----------------------------------------------------
     */
func plat_set_my_stack
    get_up_stack platform_normal_stacks, PLATFORM_STACK_SIZE
    mov sp, x0
    ret
endfunc plat_set_my_stack

    /* -----------------------------------------------------
     * Single cpu stack in normal memory.
     * Used for C code during boot, PLATFORM_STACK_SIZE bytes
     * are allocated
     * -----------------------------------------------------
     */
declare_stack platform_normal_stacks, tzfw_normal_stacks, \
        PLATFORM_STACK_SIZE, 1, CACHE_WRITEBACK_GRANULE

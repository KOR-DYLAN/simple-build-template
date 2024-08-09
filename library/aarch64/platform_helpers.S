/*
 * Copyright (c) 2013-2019, ARM Limited and Contributors. All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */

#include <library/common/asm_macros_common.S>

    .weak    plat_panic_handler

    /* -----------------------------------------------------
     * void plat_panic_handler(void) __dead2;
     * Endless loop by default.
     * -----------------------------------------------------
     */
func plat_panic_handler
    wfi
    b plat_panic_handler
endfunc plat_panic_handler

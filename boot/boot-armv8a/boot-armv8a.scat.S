/*
 * Copyright (c) 2019, ARM Limited and Contributors. All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */
#define PLATFORM_LINKER_FORMAT  "elf64-littleaarch64"
#define PLATFORM_LINKER_ARCH    aarch64
#define PLATFORM_IMAGE_BASE     0x40000000
#define PLATFORM_IMAGE_LIMIT    0x40040000
#define PAGE_SIZE               0x1000
#define STRUCT_ALIGN            8
#define DATA_ALIGN              1
#define BSS_ALIGN               16


LR_START PLATFORM_IMAGE_BASE
{
    __IMAGE_START__ +0 FIXED EMPTY 0
    {
        /* placeholder */
    }

    /* PLATFORM_IMAGE_BASE address must be aligned on a page boundary. */
    ScatterAssert((ImageBase(__IMAGE_START__) AND 0xFFF) == 0)
}

LR_TEXT PLATFORM_IMAGE_BASE
{
    __TEXT__ +0 FIXED
    {
        *(:gdef:image_entrypoint, +FIRST)
        *(.text*)
        *(.vectors)
        .ANY1(+RO-CODE)
    }

    __TEXT_EPILOGUE__ AlignExpr(+0, PAGE_SIZE) FIXED EMPTY 0
    {
        /* section delimiter */
    }
}

LR_RO_DATA +0
{
    __RODATA__ AlignExpr(ImageLimit(LR_TEXT), 0) FIXED
    {
        *(.rodata*)
        .ANY2(+RO-DATA)
    }

    __RODATA_EPILOGUE__ AlignExpr(+0, PAGE_SIZE) FIXED EMPTY 0
    {
        /* section delimiter */
    }
}

LR_RW_DATA +0
{
    __DATA__ AlignExpr(+0, 16) FIXED
    {
        *(.data*)
        *(.constdata)
        *(locale$$data)
    }
}

LR_RELA +0
{
    /*
     * .rela.dyn needs to come after .data for the read-elf utility to parse this section correctly.
     * Ensure 8-byte alignment so that the fields of RELA data structure are aligned.
     */
    __RELA__ AlignExpr(ImageLimit(LR_RW_DATA), STRUCT_ALIGN) FIXED
    {
        *(.rela.dyn)
    }
}

LR_STACKS +0
{
    __STACKS__ AlignExpr(+0, 64) FIXED
    {
        *(tzfw_normal_stacks)
    }
}

LR_BSS +0
{
    __BSS__ AlignExpr(ImageLimit(LR_STACKS), 256) FIXED
    {
        *(.bss*)
        *(COMDAT)
    }
}

LR_END +0
{
    __IMAGE_END__ +0 FIXED EMPTY 0
    {
        /* placeholder */
    }

    /* IMAGE has exceeded its limit. */
    ScatterAssert(ImageLimit(__IMAGE_END__) <= PLATFORM_IMAGE_LIMIT)
}

/*
 * Copyright (c) 2013-2022, Arm Limited and Contributors. All rights reserved.
 * Copyright (c) 2020-2022, NVIDIA Corporation. All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */
#ifndef XPSR__H
#define XPSR__H

#include <library/common/bitops.h>

/* CPSR/SPSR definitions */
#define DAIF_FIQ_BIT                (U(1) << 0)
#define DAIF_IRQ_BIT                (U(1) << 1)
#define DAIF_ABT_BIT                (U(1) << 2)
#define DAIF_DBG_BIT                (U(1) << 3)
#define SPSR_DAIF_SHIFT             U(6)
#define SPSR_DAIF_MASK              U(0xf)

#define SPSR_AIF_SHIFT              U(6)
#define SPSR_AIF_MASK               U(0x7)

#define SPSR_E_SHIFT                U(9)
#define SPSR_E_MASK                 U(0x1)
#define SPSR_E_LITTLE               U(0x0)
#define SPSR_E_BIG                  U(0x1)

#define SPSR_T_SHIFT                U(5)
#define SPSR_T_MASK                 U(0x1)
#define SPSR_T_ARM                  U(0x0)
#define SPSR_T_THUMB                U(0x1)

#define SPSR_M_SHIFT                U(4)
#define SPSR_M_MASK                 U(0x1)
#define SPSR_M_AARCH64              U(0x0)
#define SPSR_M_AARCH32              U(0x1)
#define SPSR_M_EL2H                 U(0x9)

#define SPSR_EL_SHIFT               U(2)
#define SPSR_EL_WIDTH               U(2)

#define SPSR_SSBS_SHIFT_AARCH64     U(12)
#define SPSR_SSBS_BIT_AARCH64       (ULL(1) << SPSR_SSBS_SHIFT_AARCH64)
#define SPSR_SSBS_SHIFT_AARCH32     U(23)
#define SPSR_SSBS_BIT_AARCH32       (ULL(1) << SPSR_SSBS_SHIFT_AARCH32)

#define SPSR_PAN_BIT                BIT_64(22)

#define SPSR_DIT_BIT                BIT(24)

#define SPSR_TCO_BIT_AARCH64        BIT_64(25)

#define DISABLE_ALL_EXCEPTIONS      (DAIF_FIQ_BIT | DAIF_IRQ_BIT | DAIF_ABT_BIT | DAIF_DBG_BIT)

#define DISABLE_INTERRUPTS          (DAIF_FIQ_BIT | DAIF_IRQ_BIT)

#endif  /* !XPSR__H */

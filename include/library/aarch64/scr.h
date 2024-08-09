/*
 * Copyright (c) 2013-2022, Arm Limited and Contributors. All rights reserved.
 * Copyright (c) 2020-2022, NVIDIA Corporation. All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */
#ifndef SCR__H
#define SCR__H

#include <library/common/common_utils.h>

/* SCR definitions */
#define SCR_RES1_BITS           ((U(1) << 4) | (U(1) << 5))
#define SCR_NSE_SHIFT           U(62)
#define SCR_NSE_BIT             (ULL(1) << SCR_NSE_SHIFT)
#define SCR_GPF_BIT             (UL(1) << 48)
#define SCR_TWEDEL_SHIFT        U(30)
#define SCR_TWEDEL_MASK         ULL(0xf)
#define SCR_TRNDR_BIT           (UL(1) << 40)
#define SCR_HXEn_BIT            (UL(1) << 38)
#define SCR_ENTP2_SHIFT         U(41)
#define SCR_ENTP2_BIT           (UL(1) << SCR_ENTP2_SHIFT)
#define SCR_AMVOFFEN_SHIFT      U(35)
#define SCR_AMVOFFEN_BIT        (UL(1) << SCR_AMVOFFEN_SHIFT)
#define SCR_TWEDEn_BIT          (UL(1) << 29)
#define SCR_ECVEN_BIT           (UL(1) << 28)
#define SCR_FGTEN_BIT           (UL(1) << 27)
#define SCR_ATA_BIT             (UL(1) << 26)
#define SCR_EnSCXT_BIT          (UL(1) << 25)
#define SCR_FIEN_BIT            (UL(1) << 21)
#define SCR_EEL2_BIT            (UL(1) << 18)
#define SCR_API_BIT             (UL(1) << 17)
#define SCR_APK_BIT             (UL(1) << 16)
#define SCR_TERR_BIT            (UL(1) << 15)
#define SCR_TWE_BIT             (UL(1) << 13)
#define SCR_TWI_BIT             (UL(1) << 12)
#define SCR_ST_BIT              (UL(1) << 11)
#define SCR_RW_BIT              (UL(1) << 10)
#define SCR_SIF_BIT             (UL(1) << 9)
#define SCR_HCE_BIT             (UL(1) << 8)
#define SCR_SMD_BIT             (UL(1) << 7)
#define SCR_EA_BIT              (UL(1) << 3)
#define SCR_FIQ_BIT             (UL(1) << 2)
#define SCR_IRQ_BIT             (UL(1) << 1)
#define SCR_NS_BIT              (UL(1) << 0)
#define SCR_VALID_BIT_MASK      U(0x24000002F8F)
#define SCR_RESET_VAL           SCR_RES1_BITS

#endif  /* !SCR__H */

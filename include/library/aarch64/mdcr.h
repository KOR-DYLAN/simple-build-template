/*
 * Copyright (c) 2013-2022, Arm Limited and Contributors. All rights reserved.
 * Copyright (c) 2020-2022, NVIDIA Corporation. All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */
#ifndef MDCR__H
#define MDCR__H

#include <library/common/common_utils.h>

/* MDCR_EL3 definitions */
#define MDCR_EnPMSN_BIT         (ULL(1) << 36)
#define MDCR_MPMX_BIT           (ULL(1) << 35)
#define MDCR_MCCD_BIT           (ULL(1) << 34)
#define MDCR_SBRBE_SHIFT        U(32)
#define MDCR_SBRBE_MASK         ULL(0x3)
#define MDCR_NSTB(x)            ((x) << 24)
#define MDCR_NSTB_EL1           ULL(0x3)
#define MDCR_NSTBE              (ULL(1) << 26)
#define MDCR_MTPME_BIT          (ULL(1) << 28)
#define MDCR_TDCC_BIT           (ULL(1) << 27)
#define MDCR_SCCD_BIT           (ULL(1) << 23)
#define MDCR_EPMAD_BIT          (ULL(1) << 21)
#define MDCR_EDAD_BIT           (ULL(1) << 20)
#define MDCR_TTRF_BIT           (ULL(1) << 19)
#define MDCR_STE_BIT            (ULL(1) << 18)
#define MDCR_SPME_BIT           (ULL(1) << 17)
#define MDCR_SDD_BIT            (ULL(1) << 16)
#define MDCR_SPD32(x)           ((x) << 14)
#define MDCR_SPD32_LEGACY       ULL(0x0)
#define MDCR_SPD32_DISABLE      ULL(0x2)
#define MDCR_SPD32_ENABLE       ULL(0x3)
#define MDCR_NSPB(x)            ((x) << 12)
#define MDCR_NSPB_EL1           ULL(0x3)
#define MDCR_TDOSA_BIT          (ULL(1) << 10)
#define MDCR_TDA_BIT            (ULL(1) << 9)
#define MDCR_TPM_BIT            (ULL(1) << 6)
#define MDCR_EL3_RESET_VAL      ULL(0x0)

/* MDCR_EL2 definitions */
#define MDCR_EL2_MTPME          (U(1) << 28)
#define MDCR_EL2_HLP            (U(1) << 26)
#define MDCR_EL2_E2TB(x)        ((x) << 24)
#define MDCR_EL2_E2TB_EL1       U(0x3)
#define MDCR_EL2_HCCD           (U(1) << 23)
#define MDCR_EL2_TTRF           (U(1) << 19)
#define MDCR_EL2_HPMD           (U(1) << 17)
#define MDCR_EL2_TPMS           (U(1) << 14)
#define MDCR_EL2_E2PB(x)        ((x) << 12)
#define MDCR_EL2_E2PB_EL1       U(0x3)
#define MDCR_EL2_TDRA_BIT       (U(1) << 11)
#define MDCR_EL2_TDOSA_BIT      (U(1) << 10)
#define MDCR_EL2_TDA_BIT        (U(1) << 9)
#define MDCR_EL2_TDE_BIT        (U(1) << 8)
#define MDCR_EL2_HPME_BIT       (U(1) << 7)
#define MDCR_EL2_TPM_BIT        (U(1) << 6)
#define MDCR_EL2_TPMCR_BIT      (U(1) << 5)
#define MDCR_EL2_RESET_VAL      U(0x0)

#endif  /* !MDCR__H */

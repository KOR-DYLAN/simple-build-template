/*
 * Copyright (c) 2013-2022, Arm Limited and Contributors. All rights reserved.
 * Copyright (c) 2020-2022, NVIDIA Corporation. All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */
#ifndef SCTLR__H
#define SCTLR__H

#include <library/common/common_utils.h>

/* SCTLR definitions */
#define SCTLR_EL2_RES1          ((U(1) << 29) | (U(1) << 28) | (U(1) << 23) | (U(1) << 22) | (U(1) << 18) | (U(1) << 16) | (U(1) << 11) | (U(1) << 5) | (U(1) << 4))
#define SCTLR_EL1_RES1          ((UL(1) << 29) | (UL(1) << 28) | (UL(1) << 23) | (UL(1) << 22) | (UL(1) << 20) | (UL(1) << 11))
#define SCTLR_EL3_RES1          ((U(1) << 29) | (U(1) << 28) | (U(1) << 23) | (U(1) << 22) | (U(1) << 18) | (U(1) << 16) | (U(1) << 11) | (U(1) << 5) | (U(1) << 4))

#define SCTLR_M_BIT             (ULL(1) << 0)
#define SCTLR_A_BIT             (ULL(1) << 1)
#define SCTLR_C_BIT             (ULL(1) << 2)
#define SCTLR_SA_BIT            (ULL(1) << 3)
#define SCTLR_SA0_BIT           (ULL(1) << 4)
#define SCTLR_CP15BEN_BIT       (ULL(1) << 5)
#define SCTLR_nAA_BIT           (ULL(1) << 6)
#define SCTLR_ITD_BIT           (ULL(1) << 7)
#define SCTLR_SED_BIT           (ULL(1) << 8)
#define SCTLR_UMA_BIT           (ULL(1) << 9)
#define SCTLR_EnRCTX_BIT        (ULL(1) << 10)
#define SCTLR_EOS_BIT           (ULL(1) << 11)
#define SCTLR_I_BIT             (ULL(1) << 12)
#define SCTLR_EnDB_BIT          (ULL(1) << 13)
#define SCTLR_DZE_BIT           (ULL(1) << 14)
#define SCTLR_UCT_BIT           (ULL(1) << 15)
#define SCTLR_NTWI_BIT          (ULL(1) << 16)
#define SCTLR_NTWE_BIT          (ULL(1) << 18)
#define SCTLR_WXN_BIT           (ULL(1) << 19)
#define SCTLR_TSCXT_BIT         (ULL(1) << 20)
#define SCTLR_IESB_BIT          (ULL(1) << 21)
#define SCTLR_EIS_BIT           (ULL(1) << 22)
#define SCTLR_SPAN_BIT          (ULL(1) << 23)
#define SCTLR_E0E_BIT           (ULL(1) << 24)
#define SCTLR_EE_BIT            (ULL(1) << 25)
#define SCTLR_UCI_BIT           (ULL(1) << 26)
#define SCTLR_EnDA_BIT          (ULL(1) << 27)
#define SCTLR_nTLSMD_BIT        (ULL(1) << 28)
#define SCTLR_LSMAOE_BIT        (ULL(1) << 29)
#define SCTLR_EnIB_BIT          (ULL(1) << 30)
#define SCTLR_EnIA_BIT          (ULL(1) << 31)
#define SCTLR_BT0_BIT           (ULL(1) << 35)
#define SCTLR_BT1_BIT           (ULL(1) << 36)
#define SCTLR_BT_BIT            (ULL(1) << 36)
#define SCTLR_ITFSB_BIT         (ULL(1) << 37)
#define SCTLR_TCF0_SHIFT        U(38)
#define SCTLR_TCF0_MASK         ULL(3)
#define SCTLR_ENTP2_BIT         (ULL(1) << 60)

/* Tag Check Faults in EL0 have no effect on the PE */
#define SCTLR_TCF0_NO_EFFECT    U(0)
/* Tag Check Faults in EL0 cause a synchronous exception */
#define SCTLR_TCF0_SYNC         U(1)
/* Tag Check Faults in EL0 are asynchronously accumulated */
#define SCTLR_TCF0_ASYNC        U(2)
/*
 * Tag Check Faults in EL0 cause a synchronous exception on reads,
 * and are asynchronously accumulated on writes
 */
#define SCTLR_TCF0_SYNCR_ASYNCW U(3)

#define SCTLR_TCF_SHIFT         U(40)
#define SCTLR_TCF_MASK          ULL(3)

/* Tag Check Faults in EL1 have no effect on the PE */
#define SCTLR_TCF_NO_EFFECT     U(0)
/* Tag Check Faults in EL1 cause a synchronous exception */
#define SCTLR_TCF_SYNC          U(1)
/* Tag Check Faults in EL1 are asynchronously accumulated */
#define SCTLR_TCF_ASYNC         U(2)
/*
 * Tag Check Faults in EL1 cause a synchronous exception on reads,
 * and are asynchronously accumulated on writes
 */
#define SCTLR_TCF_SYNCR_ASYNCW  U(3)

#define SCTLR_ATA0_BIT          (ULL(1) << 42)
#define SCTLR_ATA_BIT           (ULL(1) << 43)
#define SCTLR_DSSBS_SHIFT       U(44)
#define SCTLR_DSSBS_BIT         (ULL(1) << SCTLR_DSSBS_SHIFT)
#define SCTLR_TWEDEn_BIT        (ULL(1) << 45)
#define SCTLR_TWEDEL_SHIFT      U(46)
#define SCTLR_TWEDEL_MASK       ULL(0xf)
#define SCTLR_EnASR_BIT         (ULL(1) << 54)
#define SCTLR_EnAS0_BIT         (ULL(1) << 55)
#define SCTLR_EnALS_BIT         (ULL(1) << 56)
#define SCTLR_EPAN_BIT          (ULL(1) << 57)
#define SCTLR_RESET_VAL         SCTLR_EL3_RES1

#endif  /* !SCTLR__H */

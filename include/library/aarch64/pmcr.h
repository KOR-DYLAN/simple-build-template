/*
 * Copyright (c) 2013-2022, Arm Limited and Contributors. All rights reserved.
 * Copyright (c) 2020-2022, NVIDIA Corporation. All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */
#ifndef PMCR__H
#define PMCR__H

#include <library/common/common_utils.h>

/* PMCR_EL0 definitions */
#define PMCR_EL0_RESET_VAL      U(0x0)
#define PMCR_EL0_N_SHIFT        U(11)
#define PMCR_EL0_N_MASK         U(0x1f)
#define PMCR_EL0_N_BITS         (PMCR_EL0_N_MASK << PMCR_EL0_N_SHIFT)
#define PMCR_EL0_LP_BIT         (U(1) << 7)
#define PMCR_EL0_LC_BIT         (U(1) << 6)
#define PMCR_EL0_DP_BIT         (U(1) << 5)
#define PMCR_EL0_X_BIT          (U(1) << 4)
#define PMCR_EL0_D_BIT          (U(1) << 3)
#define PMCR_EL0_C_BIT          (U(1) << 2)
#define PMCR_EL0_P_BIT          (U(1) << 1)
#define PMCR_EL0_E_BIT          (U(1) << 0)

#endif  /* !PMCR__H */

/*
 * Copyright (c) 2013-2022, Arm Limited and Contributors. All rights reserved.
 * Copyright (c) 2020-2022, NVIDIA Corporation. All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */
#ifndef ID_AA64DFR__H
#define ID_AA64DFR__H

#include <library/common/common_utils.h>

/* ID_AA64DFR0_EL1.TraceVer definitions */
#define ID_AA64DFR0_TRACEVER_SHIFT          U(4)
#define ID_AA64DFR0_TRACEVER_MASK           ULL(0xf)
#define ID_AA64DFR0_TRACEVER_SUPPORTED      ULL(1)
#define ID_AA64DFR0_TRACEVER_LENGTH         U(4)
#define ID_AA64DFR0_TRACEFILT_SHIFT         U(40)
#define ID_AA64DFR0_TRACEFILT_MASK          U(0xf)
#define ID_AA64DFR0_TRACEFILT_SUPPORTED     U(1)
#define ID_AA64DFR0_TRACEFILT_LENGTH        U(4)

/* ID_AA64DFR0_EL1.PMS definitions (for ARMv8.2+) */
#define ID_AA64DFR0_PMS_SHIFT               U(32)
#define ID_AA64DFR0_PMS_MASK                ULL(0xf)
#define ID_AA64DFR0_SPE_SUPPORTED           ULL(0x1)
#define ID_AA64DFR0_SPE_NOT_SUPPORTED       ULL(0x0)

/* ID_AA64DFR0_EL1.TraceBuffer definitions */
#define ID_AA64DFR0_TRACEBUFFER_SHIFT       U(44)
#define ID_AA64DFR0_TRACEBUFFER_MASK        ULL(0xf)
#define ID_AA64DFR0_TRACEBUFFER_SUPPORTED   ULL(1)

/* ID_AA64DFR0_EL1.MTPMU definitions (for ARMv8.6+) */
#define ID_AA64DFR0_MTPMU_SHIFT             U(48)
#define ID_AA64DFR0_MTPMU_MASK              ULL(0xf)
#define ID_AA64DFR0_MTPMU_SUPPORTED         ULL(1)

/* ID_AA64DFR0_EL1.BRBE definitions */
#define ID_AA64DFR0_BRBE_SHIFT              U(52)
#define ID_AA64DFR0_BRBE_MASK               ULL(0xf)
#define ID_AA64DFR0_BRBE_SUPPORTED          ULL(1)

#endif  /* !ID_AA64DFR__H */

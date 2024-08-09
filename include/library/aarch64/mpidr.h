/*
 * Copyright (c) 2013-2022, Arm Limited and Contributors. All rights reserved.
 * Copyright (c) 2020-2022, NVIDIA Corporation. All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */
#ifndef MPIDR__H
#define MPIDR__H

#include <library/common/common_utils.h>

#define MPIDR_MT_MASK               (ULL(1) << 24)
#define MPIDR_CPU_MASK              MPIDR_AFFLVL_MASK
#define MPIDR_CLUSTER_MASK          (MPIDR_AFFLVL_MASK << MPIDR_AFFINITY_BITS)
#define MPIDR_AFFINITY_BITS         U(8)
#define MPIDR_AFFLVL_MASK           ULL(0xff)
#define MPIDR_AFF0_SHIFT            U(0)
#define MPIDR_AFF1_SHIFT            U(8)
#define MPIDR_AFF2_SHIFT            U(16)
#define MPIDR_AFF3_SHIFT            U(32)
#define MPIDR_AFF_SHIFT(_n)         MPIDR_AFF##_n##_SHIFT
#define MPIDR_AFFINITY_MASK         ULL(0xff00ffffff)
#define MPIDR_AFFLVL_SHIFT          U(3)
#define MPIDR_AFFLVL0               ULL(0x0)
#define MPIDR_AFFLVL1               ULL(0x1)
#define MPIDR_AFFLVL2               ULL(0x2)
#define MPIDR_AFFLVL3               ULL(0x3)
#define MPIDR_AFFLVL(_n)            MPIDR_AFFLVL##_n
#define MPIDR_AFFLVL0_VAL(mpidr)    (((mpidr) >> MPIDR_AFF0_SHIFT) & MPIDR_AFFLVL_MASK)
#define MPIDR_AFFLVL1_VAL(mpidr)    (((mpidr) >> MPIDR_AFF1_SHIFT) & MPIDR_AFFLVL_MASK)
#define MPIDR_AFFLVL2_VAL(mpidr)    (((mpidr) >> MPIDR_AFF2_SHIFT) & MPIDR_AFFLVL_MASK)
#define MPIDR_AFFLVL3_VAL(mpidr)    (((mpidr) >> MPIDR_AFF3_SHIFT) & MPIDR_AFFLVL_MASK)

/*
 * The MPIDR_MAX_AFFLVL count starts from 0. Take care to
 * add one while using this macro to define array sizes.
 * TODO: Support only the first 3 affinity levels for now.
 */
#define MPIDR_MAX_AFFLVL            U(2)

#define MPID_MASK                   (MPIDR_MT_MASK | (MPIDR_AFFLVL_MASK << MPIDR_AFF3_SHIFT) | (MPIDR_AFFLVL_MASK << MPIDR_AFF2_SHIFT) | (MPIDR_AFFLVL_MASK << MPIDR_AFF1_SHIFT) | (MPIDR_AFFLVL_MASK << MPIDR_AFF0_SHIFT))
#define MPIDR_AFF_ID(mpid, n)       (((mpid) >> MPIDR_AFF_SHIFT(n)) & MPIDR_AFFLVL_MASK)

/*
 * An invalid MPID. This value can be used by functions that return an MPID to
 * indicate an error.
 */
#define INVALID_MPID                U(0xFFFFFFFF)

#endif  /* !MPIDR__H */

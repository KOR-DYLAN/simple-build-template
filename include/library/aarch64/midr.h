/*
 * Copyright (c) 2013-2022, Arm Limited and Contributors. All rights reserved.
 * Copyright (c) 2020-2022, NVIDIA Corporation. All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */
#ifndef MIDR__H
#define MIDR__H

#include <library/common/common_utils.h>

#define MIDR_IMPL_MASK      U(0xff)
#define MIDR_IMPL_SHIFT     U(0x18)
#define MIDR_VAR_SHIFT      U(20)
#define MIDR_VAR_BITS       U(4)
#define MIDR_VAR_MASK       U(0xf)
#define MIDR_REV_SHIFT      U(0)
#define MIDR_REV_BITS       U(4)
#define MIDR_REV_MASK       U(0xf)
#define MIDR_PN_MASK        U(0xfff)
#define MIDR_PN_SHIFT       U(0x4)

#endif  /* !MIDR__H */

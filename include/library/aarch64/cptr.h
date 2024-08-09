/*
 * Copyright (c) 2013-2022, Arm Limited and Contributors. All rights reserved.
 * Copyright (c) 2020-2022, NVIDIA Corporation. All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */
#ifndef CPTR__H
#define CPTR__H

#include <library/common/common_utils.h>

/* CPTR_EL3 definitions */
#define TCPAC_BIT           (U(1) << 31)
#define TAM_SHIFT           U(30)
#define TAM_BIT             (U(1) << TAM_SHIFT)
#define TTA_BIT             (U(1) << 20)
#define ESM_BIT             (U(1) << 12)
#define TFP_BIT             (U(1) << 10)
#define CPTR_EZ_BIT         (U(1) << 8)
#define CPTR_EL3_RESET_VAL  ((TCPAC_BIT | TAM_BIT | TTA_BIT | TFP_BIT) & ~(CPTR_EZ_BIT | ESM_BIT))

#endif  /* !CPTR__H */

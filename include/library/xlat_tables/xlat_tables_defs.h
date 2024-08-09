#ifndef XLAT_TABLES_DEFS__H
#define XLAT_TABLES_DEFS__H

#include <library/common/bitops.h>

/* Miscellaneous MMU related constants */
#define NUM_2MB_IN_GB       (U(1) << 9)
#define NUM_4K_IN_2MB       (U(1) << 9)
#define NUM_GB_IN_4GB       (U(1) << 2)

#define TWO_MB_SHIFT        U(21)
#define ONE_GB_SHIFT        U(30)
#define FOUR_KB_SHIFT       U(12)

#define ONE_GB_INDEX(x)     ((x) >> ONE_GB_SHIFT)
#define TWO_MB_INDEX(x)     ((x) >> TWO_MB_SHIFT)
#define FOUR_KB_INDEX(x)    ((x) >> FOUR_KB_SHIFT)

#define PAGE_SIZE_4KB       U(4096)
#define PAGE_SIZE_16KB      U(16384)
#define PAGE_SIZE_64KB      U(65536)

/*
 * The ARMv8-A architecture allows translation granule sizes of 4KB, 16KB or
 * 64KB. However, only 4KB are supported at the moment.
 */
#define PAGE_SIZE_SHIFT     FOUR_KB_SHIFT
#define PAGE_SIZE           (UL(1) << PAGE_SIZE_SHIFT)
#define PAGE_SIZE_MASK      (PAGE_SIZE - UL(1))

#endif  /* !XLAT_TABLES_DEFS__H */

#ifndef PLATFORM__H
#define PLATFORM__H

#include <library/common/common_utils.h>

/*******************************************************************************
 * HW Memory Map
 ******************************************************************************/
/*
 * Partition memory into secure ROM, non-secure DRAM, secure "SRAM",
 * and secure DRAM.
 */
#define SEC_ROM_BASE                0x00000000
#define SEC_ROM_SIZE                0x00020000

#define NS_DRAM0_BASE               ULL(0x40000000)
#define NS_DRAM0_SIZE               ULL(0xc0000000)

#define SEC_SRAM_BASE               0x0e000000
#define SEC_SRAM_SIZE               0x00100000

#define SEC_DRAM_BASE               0x0e100000
#define SEC_DRAM_SIZE               0x00f00000

#define SECURE_GPIO_BASE            0x090b0000
#define SECURE_GPIO_SIZE            0x00001000

#define QEMU_FLASH0_BASE            0x00000000
#define QEMU_FLASH0_SIZE            0x04000000
#define QEMU_FLASH1_BASE            0x04000000
#define QEMU_FLASH1_SIZE            0x04000000

/*
 * PL011 related constants
 */
#define UART0_BASE                  0x09000000
#define UART1_BASE                  0x09040000

/*
 * GIC related constants
 */
#define GICD_BASE                   0x8000000
#define GICC_BASE                   0x8010000
#define GICR_BASE                   0x80A0000

#define QEMU_IRQ_SEC_SGI_0          8
#define QEMU_IRQ_SEC_SGI_1          9
#define QEMU_IRQ_SEC_SGI_2          10
#define QEMU_IRQ_SEC_SGI_3          11
#define QEMU_IRQ_SEC_SGI_4          12
#define QEMU_IRQ_SEC_SGI_5          13
#define QEMU_IRQ_SEC_SGI_6          14
#define QEMU_IRQ_SEC_SGI_7          15

/******************************************************************************
 * On a GICv2 system, the Group 1 secure interrupts are treated as Group 0
 * interrupts.
 *****************************************************************************/
#define PLATFORM_G1S_PROPS(grp) \
    INTR_PROP_DESC(QEMU_IRQ_SEC_SGI_0, GIC_HIGHEST_SEC_PRIORITY, grp, GIC_INTR_CFG_EDGE), \
    INTR_PROP_DESC(QEMU_IRQ_SEC_SGI_1, GIC_HIGHEST_SEC_PRIORITY, grp, GIC_INTR_CFG_EDGE), \
    INTR_PROP_DESC(QEMU_IRQ_SEC_SGI_2, GIC_HIGHEST_SEC_PRIORITY, grp, GIC_INTR_CFG_EDGE), \
    INTR_PROP_DESC(QEMU_IRQ_SEC_SGI_3, GIC_HIGHEST_SEC_PRIORITY, grp, GIC_INTR_CFG_EDGE), \
    INTR_PROP_DESC(QEMU_IRQ_SEC_SGI_4, GIC_HIGHEST_SEC_PRIORITY, grp, GIC_INTR_CFG_EDGE), \
    INTR_PROP_DESC(QEMU_IRQ_SEC_SGI_5, GIC_HIGHEST_SEC_PRIORITY, grp, GIC_INTR_CFG_EDGE), \
    INTR_PROP_DESC(QEMU_IRQ_SEC_SGI_6, GIC_HIGHEST_SEC_PRIORITY, grp, GIC_INTR_CFG_EDGE), \
    INTR_PROP_DESC(QEMU_IRQ_SEC_SGI_7, GIC_HIGHEST_SEC_PRIORITY, grp, GIC_INTR_CFG_EDGE)

#define PLATFORM_G0_PROPS(grp)

/*
 * System counter
 */
#define SYS_COUNTER_FREQ_IN_TICKS   ((1000 * 1000 * 1000) / 16)

/*
 * Maximum size of Event Log buffer used in Measured Boot Event Log driver
 */
#define PLAT_EVENT_LOG_MAX_SIZE     UL(0x400)


/*******************************************************************************
 * Generic platform constants
 ******************************************************************************/
#define PLATFORM_CORE_COUNT         U(4)    /* Quad Core */
#define PLATFORM_STACK_SIZE         0x4000  /* 16KB */

/*******************************************************************************
 * BL2 specific defines.
 ******************************************************************************/
#define BL2_BASE                    (0x40000000)
#define BL2_LIMIT                   (0x40040000)

/*******************************************************************************
 * Some data must be aligned on the biggest cache line size in the platform.
 * This is known only to the platform as it might have a combination of integrated and external caches.
 ******************************************************************************/
#define CACHE_WRITEBACK_SHIFT       6
#define CACHE_WRITEBACK_GRANULE     (1 << CACHE_WRITEBACK_SHIFT)


#endif  /* !PLATFORM__H */

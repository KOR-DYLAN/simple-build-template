#
# Copyright (c) 2014-2023, Arm Limited and Contributors. All rights reserved.
# Copyright (c) 2020-2022, NVIDIA Corporation. All rights reserved.
#
# SPDX-License-Identifier: BSD-3-Clause
#
include script/util.mk

# Flag to disable the cache non-temporal hint.
# It is enabled by default.
A53_DISABLE_NON_TEMPORAL_HINT		?=1
CPU_FLAG_LIST += A53_DISABLE_NON_TEMPORAL_HINT

# Flag to apply erratum 855472 workaround during reset.
# This erratum applies only to revision r0p0 of the Cortex A35 cpu.
CPU_FLAG_LIST += ERRATA_A35_855472

# Flag to apply erratum 819472 workaround during reset.
# This erratum applies only to revision <= r0p1 of the Cortex A53 cpu.
CPU_FLAG_LIST += ERRATA_A53_819472

# Flag to apply erratum 824069 workaround during reset.
# This erratum applies only to revision <= r0p2 of the Cortex A53 cpu.
CPU_FLAG_LIST += ERRATA_A53_824069

# Flag to apply erratum 826319 workaround during reset.
# This erratum applies only to revision <= r0p2 of the Cortex A53 cpu.
CPU_FLAG_LIST += ERRATA_A53_826319

# Flag to apply erratum 827319 workaround during reset.
# This erratum applies only to revision <= r0p2 of the Cortex A53 cpu.
CPU_FLAG_LIST += ERRATA_A53_827319

# Flag to apply erratum 835769 workaround at compile and link time.
# This erratum applies to revision <= r0p4 of the Cortex A53 cpu. 
# Enabling this workaround can lead the linker to create "*.stub" sections.
CPU_FLAG_LIST += ERRATA_A53_835769

# Flag to apply erratum 836870 workaround during reset.
# This erratum applies only to revision <= r0p3 of the Cortex A53 cpu.
# From r0p4 and onwards, this erratum workaround is enabled by default in hardware.
CPU_FLAG_LIST += ERRATA_A53_836870

# Flag to apply erratum 843419 workaround at link time.
# This erratum applies to revision <= r0p4 of the Cortex A53 cpu.
# Enabling this workaround could lead the linker to emit "*.stub" sections which are 4kB aligned.
CPU_FLAG_LIST += ERRATA_A53_843419

# Flag to apply errata 855873 during reset. 
# This errata applies to all revisions of the Cortex A53 CPU, but this firmware workaround only works for revisions r0p3 and higher.
# Earlier revisions are taken care  of by the rich OS.
CPU_FLAG_LIST += ERRATA_A53_855873

# Flag to apply erratum 1530924 workaround during reset. 
# This erratum applies to all revisions of Cortex A53 cpu.
CPU_FLAG_LIST += ERRATA_A53_1530924

# process all flags
$(eval $(call default_zeros, $(CPU_FLAG_LIST)))
$(eval $(call add_defines, $(CPU_FLAG_LIST)))

# Errata build flags
ifneq ($(ERRATA_A53_843419),0)
    CPU_LDFLAGS	+= --fix-cortex-a53-843419
endif

ifneq ($(ERRATA_A53_835769),0)
    CPU_CFLAGS	+= -mfix-cortex-a53-835769
    CPU_LDFLAGS	+= --fix-cortex-a53-835769
endif

ifneq ($(filter 1,$(ERRATA_A53_1530924)),)
    ERRATA_SPECULATIVE_AT	:= 1
else
    ERRATA_SPECULATIVE_AT	:= 0
endif
$(eval $(call add_define, ERRATA_SPECULATIVE_AT))

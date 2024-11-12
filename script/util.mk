#
# Copyright (c) 2015-2022, Arm Limited and Contributors. All rights reserved.
#
# SPDX-License-Identifier: BSD-3-Clause
#

# Convenience function for setting a variable to 0 if not previously set
# $(eval $(call default_zero,FOO))
define default_zero
	$(eval $(1) ?= 0)
endef

# Convenience function for setting a list of variables to 0 if not previously set
# $(eval $(call default_zeros,FOO BAR))
define default_zeros
	$(foreach var,$1,$(eval $(call default_zero,$(var))))
endef

# Convenience function for adding build definitions
# $(eval $(call add_define,FOO)) will have:
# -DFOO if $(FOO) is empty; -DFOO=$(FOO) otherwise
define add_define
    DEFINES			+=	-D$(1)$(if $(value $(1)),=$(value $(1)),)
endef

# Convenience function for addding multiple build definitions
# $(eval $(call add_defines,FOO BOO))
define add_defines
    $(foreach def,$1,$(eval $(call add_define,$(def))))
endef

# Convenience function for adding build definitions
# $(eval $(call add_define_val,FOO,BAR)) will have:
# -DFOO=BAR
define add_define_val
    DEFINES			+=	-D$(1)=$(2)
endef

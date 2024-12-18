# Set Basic Env
ifeq ($(CONFIG_BAREMETAL),y)
    LINKER_SCRIPT	:=y
    EXE_EXT			:=elf
else
    ifeq ($(OS),Windows_NT)
        EXE_EXT		:=exe
    else
        EXE_EXT		:=elf
    endif
endif

# Set Toolchain
AS      :=$(CROSS_COMPILE)gcc
CC      :=$(CROSS_COMPILE)gcc
AR      :=$(CROSS_COMPILE)ar
LD      :=$(CROSS_COMPILE)gcc
CPP     :=$(CROSS_COMPILE)cpp
OBJCOPY :=$(CROSS_COMPILE)objcopy
OBJDUMP :=$(CROSS_COMPILE)objdump

# Common ASM/C Compiler Options
cflags-$(CONFIG_BAREMETAL)		+=-fno-common
cflags-$(CONFIG_BAREMETAL)		+=-ffunction-sections
cflags-$(CONFIG_BAREMETAL)		+=-fdata-sections

# Do not use jump tables for switch statements even where it would be more efficient than other code generation strategies.
cflags-$(CONFIG_NO_JUMP_TABLES)		+=-fno-jump-tables

# the built-in function function is disabled.
cflags-$(CONFIG_NO_BUILTIN)			+=-fno-builtin

# no floating-point or Advanced SIMD registers
cflags-$(CONFIG_GENERAL_REGS_ONLY)	+=-mgeneral-regs-only

# Indicates that the compiler should not assume that unaligned memory references are handled by the system.
cflags-$(CONFIG_STRICT_ALIGN)		+=-mstrict-align

# Baremetal Environment
cflags-$(CONFIG_BAREMETAL)		+=-ffreestanding
ldflags-$(CONFIG_BAREMETAL)		+=-z noexecstack
ldflags-$(CONFIG_BAREMETAL)		+=-Wl,--fatal-warnings
ldflags-$(CONFIG_BAREMETAL)		+=-Wl,--gc-sections
ldflags-$(CONFIG_BAREMETAL)		+=-Wl,--sort-section=alignment
ldflags-$(CONFIG_BAREMETAL)		+=-Wl,-z,common-page-size=4096
ldflags-$(CONFIG_BAREMETAL)		+=-Wl,-z,max-page-size=4096
ldflags-$(CONFIG_BAREMETAL)		+=-Wl,--build-id=none

# Determine the language standard.
ifneq ($(CONFIG_STD),)
    CFLAGS	+=-std=$(CONFIG_STD)
else
    CFLAGS	+=-std=gnu99
endif

# Specifies the architecture version and architectural extensions to use for this function.
ifneq ($(CONFIG_SYSTEM_ARCH),)
    CFLAGS  +=-march=$(CONFIG_SYSTEM_ARCH)
endif

# Specifies the core for which to tune the performance of this function.
ifneq ($(CONFIG_SYSTEM_CORE),)
    CFLAGS  +=-mtune=$(CONFIG_SYSTEM_CORE)
endif

# Build options according to build type
ifeq ($(BUILD_TYPE),debug)
    override CONFIG_ENABLE_ASSERTIONS=y
    CFLAGS	+=-O0 -g -DDEBUG=1
    LDFLAGS	+=-O0
else ifeq ($(BUILD_TYPE),release)
    CFLAGS	+=-O2 -DDEBUG=0
    LDFLAGS	+=-O2
else
    $(error Unknown BUILD_TYPE...)
endif

# Platform
ifneq ($(CONFIG_PLATFORM),)
    CFLAGS		+=-Iplatform/$(CONFIG_PLATFORM)
    CPPFLAGS	+=-Iplatform/$(CONFIG_PLATFORM)
endif

include script/Makefile.stack_protector

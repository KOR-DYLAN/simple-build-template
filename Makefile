# Common Environments
TOPDIR			:=$(patsubst %/,%,$(dir $(abspath $(firstword $(MAKEFILE_LIST)))))
SOURCE_DIR		:=$(TOPDIR)
BUILD_BASE		?=build
OUTPUT_BASE		?=output
MAKEFLAGS 		+=--no-print-directory
V				?=0
ifneq ($(V),1)
    Q:=@
endif
# debug | release
BUILD_TYPE		:=debug

# Target Directory Lists
DIR_LISTS		+=driver
DIR_LISTS		+=library
DIR_LISTS		+=platform
DIR_LISTS		+=boot
DIR_LISTS		+=app

ifeq ($(OS),Windows_NT)
    EXE_EXT	:=exe
else
    EXE_EXT	:=elf
endif

# include .config
-include $(SOURCE_DIR)/.config
CROSS_COMPILE	:=$(CONFIG_CROSS_COMPILE)

# export gloabal variable
export TOPDIR
export SOURCE_DIR
export BUILD_BASE
export OUTPUT_BASE
export BUILD_TYPE
export Q
export CROSS_COMPILE
export EXE_EXT

# Targets
all: build

%_defconfig:
	@echo "[CP]       'config/$@' to '$(SOURCE_DIR)/.config'"
	@mkdir -p $(BUILD_BASE)
	@cp config/$@ $(SOURCE_DIR)/.config

phony+=build
build:
ifeq (,$(wildcard $(SOURCE_DIR)/.config))
	$(error can not found '$(SOURCE_DIR)/.config'...)
endif
	@rm -f $(BUILD_BASE)/link_lists.mk
	$(Q)$(foreach it, $(DIR_LISTS), $(MAKE) -f script/Makefile.build WORKING_DIR=$(it) IS_ENTRY=FALSE;)

phony+=clean
clean:
	rm -rf $(BUILD_BASE)
	rm -rf $(OUTPUT_BASE)

phony+=gen_compiledb
gen_compiledb:
ifeq (,$(wildcard $(SOURCE_DIR)/.config))
	$(error can not found '$(SOURCE_DIR)/.config'...)
endif
	@echo "generating 'compile_commands.json'..."
	@$(MAKE) --always-make --dry-run | grep -wE 'gcc|g\+\+|armclang' | grep -w '\-c' | jq -nR '[inputs|{directory:".", command:., file: (match("[^ ]+\\.(s|S|c|cpp)\\b").string)}]' > $(BUILD_BASE)/compile_commands.json
	@echo "done!"

phony+=run
run: build
	$(CONFIG_QEMU) -M $(CONFIG_QEMU_MACHINE),virtualization=$(CONFIG_QEMU_VIRTUALIZATION),secure=$(CONFIG_QEMU_SECURE) -cpu $(CONFIG_QEMU_CPU) -smp $(CONFIG_QEMU_SMP) -m $(CONFIG_QEMU_RAM) -kernel $(OUTPUT_BASE)/image.elf $(CONFIG_QEMU_FLAGS)

phony+=debug
debug: build
	$(CONFIG_QEMU) -M $(CONFIG_QEMU_MACHINE),virtualization=$(CONFIG_QEMU_VIRTUALIZATION),secure=$(CONFIG_QEMU_SECURE) -cpu $(CONFIG_QEMU_CPU) -smp $(CONFIG_QEMU_SMP) -m $(CONFIG_QEMU_RAM) -kernel $(OUTPUT_BASE)/image.elf $(CONFIG_QEMU_FLAGS) -S -s

.PHONY: $(phony)

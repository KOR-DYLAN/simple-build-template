# Common Environments
TOPDIR			:=$(dir $(abspath $(firstword $(MAKEFILE_LIST))))
SOURCE_DIR		:=$(TOPDIR)
BUILD_BASE		?=build
OUTPUT_BASE		?=output
MAKEFLAGS 		+=--no-print-directory
V				?=0

# debug | release
BUILD_TYPE		:=debug

# Target Directory Lists
DIR_LISTS	+=driver
DIR_LISTS	+=library
DIR_LISTS	+=platform
DIR_LISTS	+=boot
DIR_LISTS	+=app

# include .config
-include $(BUILD_BASE)/.config

# Targets
all: build

%_defconfig:
	@echo "[CP]       'config/$@' to '$(BUILD_BASE)/.config'"
	@mkdir -p $(BUILD_BASE)
	@cp config/$@ $(BUILD_BASE)/.config

phony+=build
build:
	@if [ ! -f  $(BUILD_BASE)/.config ]; then \
		echo "can not found '$(BUILD_BASE)/.config'..."; \
		exit 1; \
	fi
	@rm -f $(BUILD_BASE)/link_lists.mk
	@for it in $(DIR_LISTS) ; do \
		$(MAKE) -f script/Makefile.build BUILD_TYPE=$(BUILD_TYPE) V=$(V) CROSS_COMPILE=$(CONFIG_CROSS_COMPILE) BUILD_BASE=$(BUILD_BASE) OUTPUT_BASE=$(OUTPUT_BASE) WORKING_DIR=$$it ; \
	done

phony+=clean
clean:
	rm -rf $(BUILD_BASE)
	rm -rf $(OUTPUT_BASE)

phony+=gen_compiledb
gen_compiledb:
	@if [ ! -f  $(BUILD_BASE)/.config ]; then \
		echo "can not found '$(BUILD_BASE)/.config'..."; \
		exit 1; \
	fi
	@echo "generating 'compile_commands.json'..."
	@$(MAKE) --always-make --dry-run | grep -wE 'gcc|g\+\+|armclang' | grep -w '\-c' | jq -nR '[inputs|{directory:".", command:., file: match(" [^ ]+$$").string[1:]}]' > $(BUILD_BASE)/compile_commands.json
	@echo "done!"

phony+=run
run: build
	$(CONFIG_QEMU) -M $(CONFIG_QEMU_MACHINE),virtualization=$(CONFIG_QEMU_VIRTUALIZATION),secure=$(CONFIG_QEMU_SECURE) -cpu $(CONFIG_QEMU_CPU) -smp $(CONFIG_QEMU_SMP) -m $(CONFIG_QEMU_RAM) -kernel $(OUTPUT_BASE)/image.elf $(CONFIG_QEMU_FLAGS)

phony+=debug
debug: build
	$(CONFIG_QEMU) -M $(CONFIG_QEMU_MACHINE),virtualization=$(CONFIG_QEMU_VIRTUALIZATION),secure=$(CONFIG_QEMU_SECURE) -cpu $(CONFIG_QEMU_CPU) -smp $(CONFIG_QEMU_SMP) -m $(CONFIG_QEMU_RAM) -kernel $(OUTPUT_BASE)/image.elf $(CONFIG_QEMU_FLAGS) -S -s

.PHONY: $(phony)

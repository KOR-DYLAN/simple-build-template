# Common Environments
TOPDIR			:=$(dir $(abspath $(firstword $(MAKEFILE_LIST))))
SOURCE_DIR		:=$(TOPDIR)
BUILD_BASE		?=build
OUTPUT_BASE		?=output
MAKEFLAGS 		+=--no-print-directory
CROSS_COMPILE	?=aarch64-none-linux-gnu-
V				?=0

# debug | release
BUILD_TYPE		:=debug

# Targets
all: build

%_defconfig:
	@mkdir -p $(BUILD_BASE)
	@cp config/$@ $(BUILD_BASE)/.config

phony+=build
build:
	@rm -f $(BUILD_BASE)/link_lists.mk
	@$(MAKE) -f script/Makefile.build BUILD_TYPE=$(BUILD_TYPE) V=$(V) CROSS_COMPILE=$(CROSS_COMPILE) BUILD_BASE=$(BUILD_BASE) OUTPUT_BASE=$(OUTPUT_BASE) WORKING_DIR=driver
	@$(MAKE) -f script/Makefile.build BUILD_TYPE=$(BUILD_TYPE) V=$(V) CROSS_COMPILE=$(CROSS_COMPILE) BUILD_BASE=$(BUILD_BASE) OUTPUT_BASE=$(OUTPUT_BASE) WORKING_DIR=library
	@$(MAKE) -f script/Makefile.build BUILD_TYPE=$(BUILD_TYPE) V=$(V) CROSS_COMPILE=$(CROSS_COMPILE) BUILD_BASE=$(BUILD_BASE) OUTPUT_BASE=$(OUTPUT_BASE) WORKING_DIR=platform
	@$(MAKE) -f script/Makefile.build BUILD_TYPE=$(BUILD_TYPE) V=$(V) CROSS_COMPILE=$(CROSS_COMPILE) BUILD_BASE=$(BUILD_BASE) OUTPUT_BASE=$(OUTPUT_BASE) WORKING_DIR=boot

phony+=clean
clean:
	rm -rf $(BUILD_BASE)
	rm -rf $(OUTPUT_BASE)

phony+=gen_compiledb
gen_compiledb:
	@echo "generating 'compile_commands.json'..."
	@$(MAKE) --always-make --dry-run | grep -wE 'gcc|g\+\+|armclang' | grep -w '\-c' | jq -nR '[inputs|{directory:".", command:., file: match(" [^ ]+$$").string[1:]}]' > $(BUILD_BASE)/compile_commands.json
	@echo "done!"

.PHONY: $(phony)

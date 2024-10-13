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
    NATIVE_SOURCE_DIR:=$(shell cygpath -m $(SOURCE_DIR))
else
    EXE_EXT	:=elf
    NATIVE_SOURCE_DIR:=$(SOURCE_DIR)
endif

# include .config
-include $(SOURCE_DIR)/.config
CROSS_COMPILE	:=$(CONFIG_CROSS_COMPILE)-
ifeq ($(CONFIG_TOOLCHAIN),llvm)
    TOOLCHAIN	:=$(CONFIG_TOOLCHAIN)
    ifneq ($(CONFIG_CROSS_COMPILE),)
        SYSROOT		:=$(shell $(CONFIG_CROSS_COMPILE)-gcc -print-sysroot)
        MULTIDIR	:=$(shell $(CONFIG_CROSS_COMPILE)-gcc -print-multi-directory)
        BUILTINS	:=$(shell $(CONFIG_CROSS_COMPILE)-gcc -print-libgcc-file-name)
        COMPILER_SPECIFIC_CFLAGS	:=--target=$(CONFIG_CROSS_COMPILE) --sysroot=$(SYSROOT)
        COMPILER_SPECIFIC_LDFLAGS	:=-L$(SYSROOT)/lib/$(MULTIDIR)
    endif
else
    TOOLCHAIN	:=gnu
endif

# export gloabal variable
export TOPDIR
export SOURCE_DIR
export BUILD_BASE
export OUTPUT_BASE
export BUILD_TYPE
export Q
export CROSS_COMPILE
export EXE_EXT
export TOOLCHAIN
export SYSROOT
export MULTIDIR
export BUILTINS
export COMPILER_SPECIFIC_CFLAGS
export COMPILER_SPECIFIC_LDFLAGS

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
	@$(MAKE) --always-make --dry-run | grep -wE 'gcc|g\+\+|clang|armclang' | grep -w '\-c' | jq -nR '[inputs|{directory:"$(NATIVE_SOURCE_DIR)", command:., file: (match("[^ ]+\\.(s|S|c|cpp)\\b").string)}]' > $(BUILD_BASE)/compile_commands.json
	@echo "done!"

phony+=run
run: build
	./output/image.$(EXE_EXT)

.PHONY: $(phony)

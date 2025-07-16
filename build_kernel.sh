#!/usr/bin/env bash
# Device: Xiaomi Gale (arm64)

# Toolchain directory (cloned by CI)
TC_DIR="$(pwd)/proton-clang"
export PATH="$TC_DIR/bin:$PATH"

# Build metadata
export KBUILD_BUILD_USER="Aquamarine"
export KBUILD_BUILD_HOST="kagiyanagi"
export CONFIG_NO_ERROR_ON_MISMATCH=y
export CONFIG_DEBUG_SECTION_MISMATCH=y

# Default defconfig (change if needed)
DEFCONFIG="gale_defconfig"

# Create output directory and configure
mkdir -p out
make O=out ARCH=arm64 CC=clang $DEFCONFIG

make O=out -j$(nproc) ARCH=arm64 \
     CC=clang AR=llvm-ar NM=llvm-nm \
     OBJDUMP=llvm-objdump STRIP=llvm-strip \
     OBJCOPY=llvm-objcopy LD=ld.lld \
     CROSS_COMPILE=aarch64-linux-gnu- \
     CROSS_COMPILE_ARM32=arm-linux-gnueabi- | tee log.txt

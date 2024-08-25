#!/usr/bin/env bash


clangpath=/root/tc/linux-x86/clang-r536225
gccpath=$(pwd)/toolchains/aarch64-linux-android-4.9
path=$(pwd)

cd $path
git clone https://github.com/LineageOS/android_prebuilts_clang_kernel_linux-x86_clang-r416183b -b lineage-20.0 --depth=1 toolchains/clang-r416183b
git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9 -b android12-release --depth=1 toolchains/aarch64-linux-android-4.9
clear

make O=out ARCH=arm64 kimocoder_defconfig
PATH=$clangpath/bin:$gccpath/bin:${PATH} \
make -j$(nproc --all) O=out \
                      ARCH=arm64 \
                      CC=clang \
                      CLANG_TRIPLE=aarch64-linux-gnu- \
                      CROSS_COMPILE=aarch64-linux-android-

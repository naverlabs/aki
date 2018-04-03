#!/bin/bash

if [ -z "$1" ]; then
	echo "usage: install-aki-source-to-workspace.sh [workspace path]"
	exit
fi

workspace=$1
home=$PWD
source=$PWD/source

if [ ! -d "$workspace" ]; then
	echo path $workspace not exist.
	exit
fi

echo "[] Extract kernel source..."
cd $source
unzip SEC_Android_Independent_EVT0.0_E7270_BSP_KERNEL.tar.zip
tar xf exynos.tar
rm -f exynos.tar

echo "[] Apply patch to kernel source..."
cd exynos
patch -p1 < $source/aki-kernel.patch

echo "[] Extract u-boot source..."
cd $source
unzip SEC_Android_Independent_EVT0.0_E7270_BSP_u-boot.tar.zip
tar xf u-boot-samsung-201207.tar
rm -f u-boot-samsung-201207.tar

echo "[] Apply patch to u-boot source..."
cd u-boot-samsung-201207
patch -p1 < $source/aki-bootloader-u-boot.patch

echo "[] Apply patch to external/dnsmasq..."
cd $workspace
if [ -d external/dnsmasq ]; then
patch -p1 < $source/aki-platform-external-dnsmasq.patch
else
echo external/dnsmasq not exist. skip patching.
fi

echo "[] Install kernel and u-boot to workspace..."
cd $source
mv exynos $workspace/kernel
mv u-boot-samsung-201207 $workspace/u-boot-samsung

cd $home
echo "[] Done."

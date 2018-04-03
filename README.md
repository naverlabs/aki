# AKI Opensource 

# How to build

0. Setup build environment
   - please refer to https://source.android.com/source/initializing for the build environment
   - setup repo
     ```
     mkdir ~/bin
     PATH=~/bin:$PATH
     curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
     chmod a+x ~/bin/rep
     ```
  
1. Make workspace and get android open source from Google repository
   - android version: 7.0.0_r1
   ```
   mkdir workspace
   cd workspace
   export WORKSPACE=$PWD
   repo init -u https://android.googlesource.com/platform/manifest -b android-7.0.0_r1
   cd -
   ```

2. Download the kernel, u-boot and patches from AKI repository
   ```
   git clone https://github.com/naverlabs/aki.git aki-source
   ```

3. Install AKI Source to workspace
   ```
   cd aki-source
   ./install-aki-source-to-workspace.sh $WORKSPACE
   ```

4. Build
   - Set environment for cross compile
   ```
   export CROSS_COMPILE=${WORKSPACE}/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android-
   ```
   - Kernel
   ```
   cd $WORKSPACE/kernel
   export ARCH=arm64
   make distclean
   make jindory_defconfig
   make
   ```
   - U-boot
   ```
   cd $WORKSPACE/u-boot-samsung
   export ARCH=arm
   ./build.sh espresso7270_sip_aarch64
   ```
   - Android Platform
   ```
   cd $WORKSPACE
   source build/envsetup.sh
   lunch aosp_arm64-user
   make
   ```

# License
Please see NOTICE.html for the full open source license

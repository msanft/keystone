StarFive VisionFive 2 Hardware Deployment
===========================================

Building Keystone
----------------------------------------

Building for the VisionFive 2 is straight-forward.
First, clone the Keystone repository in the **manager instance**.

::

  git clone https://github.com/msanft/keystone
  cd keystone
  git checkout feat/vf2-hw-deployment

Follow :doc:`QEMU-Setup-Repository` to setup the repository.

After you setup the repository, you can run the following commands to build Keystone.

::

  mkdir <build directory>
  cd <build directory>
  cmake ..
  make
  make image

TODO: Actually add the CMake flag DSM_VISIONFIVE for building for VisionFive 2. For now, changes are hardcoded in the CMakeLists.txt

CMake with the flag ``-DSM_VISIONFIVE=y -Dinitramfs=y`` will automatically generate Makefiles to build
SiFive-compatible SM, and the Linux Kernel with the Buildroot image as an initramfs.
Once you have built the image, you will see ``sm.build/platform/generic/firmware/`` under your
build directory.

Separately, ``make image`` will also generate ``sm.build/platform/generic/firmware/fw_payload.bin`` under your build directory.
Save the path for later.

::

  export SM_PATH=$(realpath sm.build/platform/generic/firmware/fw_payload.bin)

Setting Up U-Boot
---------------------

Install the additional dependencies of U-Boot. (Assuming the RISC-V toolchain is in your path, e.g. via ``source source.sh`` when setting up Keystone) And clone the VisionFive 2 SDK repository.

::

  sudo apt-get install bc bison build-essential coccinelle \
    device-tree-compiler dfu-util efitools flex gdisk graphviz imagemagick \
    liblz4-tool libgnutls28-dev libguestfs-tools libncurses-dev \
    libpython3-dev libsdl2-dev libssl-dev lz4 lzma lzma-alone openssl \
    pkg-config python3 python3-asteval python3-coverage python3-filelock \
    python3-pkg-resources python3-pycryptodome python3-pyelftools \
    python3-pytest python3-pytest-xdist python3-sphinxcontrib.apidoc \
    python3-sphinx-rtd-theme python3-subunit python3-testtools \
    python3-virtualenv swig uuid-dev
  git clone https://github.com/starfive-tech/VisionFive2
  cd VisionFive2
  git checkout JH7110_VisionFive2_devel
  git submodule update --init --recursive

Change the VisionFive 2 U-Boot target in their Makefile to use ``OPENSBI=$(SM_PATH)``.

::

  make -j$(nproc)

Find the ``work/u-boot-spl.bin.normal.out`` file, which you need to flash your board with.

Setting up the VisionFive 2
---------------------

Setup Bootloader
################

https://github.com/starfive-tech/VisionFive2#appendix-iii-updating-spl-and-u-boot-binaries-under-u-boot

TODO: explain

Load Linux Image
################

https://github.com/starfive-tech/VisionFive2#2-running-the-other-dtb-with-the-imagegz-and-initramfscpiogz

TODO: explain

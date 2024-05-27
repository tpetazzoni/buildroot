Libre Computer Le Potato (AML-S905X-CC)

Intro
=====

Libre Computer "Le Potato" is a low cost SBC based around an Amlogic
s905x SoC (quad A53), 2GB DDR3, Mali-450:

https://libre.computer/products/aml-s905x-cc/

How to build it
===============

Configure Buildroot:

  $ make lepotato_defconfig

Then you can edit the build options using

  $ make menuconfig

Compile everything and build rootfs image:

  $ make

Note: you will need to have access to the network, since Buildroot
will download the packages' sources.

Result of the build
-------------------

After building, you should obtain this tree:

output/images/
+-- amlogic-boot-fip
+   +-- axg.inc
+   +--  build-fip.sh
+   +--  g12a.inc
+   +--  gxbb.inc
+   +--  gxl.inc
+   `-- lepotato
+       +-- acs.bin
+       +-- acs_tool.py
+       +-- aml_encrypt_gxl
+       +-- bl21.bin
+       +-- bl2.bin
+       +-- bl301.bin
+       +-- bl30.bin
+       +-- bl31.img
+       +-- blx_fix.sh
+       `-- Makefile
+-- boot.vfat
+-- extlinux
+   `-- extlinux.conf
+-- fip
+   +--  u-boot.bin
+   +--  u-boot.bin.sd.bin
+   +--  u-boot.bin.usb.bl2
+   `-- u-boot.bin.usb.tpl
+-- Image
+-- meson-gxl-s905x-libretech-cc.dtb
+-- rootfs.ext2
+-- rootfs.ext4 -> rootfs.ext2
+-- rootfs.tar
+-- sdcard.img
`-- u-boot.bin

The post-image script uses the files in the amlogic-boot-fip folder to sign
the bootloader image before integrating it into the sdcard image.

How to write the SD card or eMMC
================================

Once the build process is finished you will have an image called "sdcard.img"
in the output/images/ directory.

Copy the bootable "sdcard.img" onto an SD card or eMMC with "dd":

  $ sudo dd if=output/images/sdcard.img of=/dev/sdX

Insert the micro SDcard into your Le Potato and power it up. The console
is on the serial line, 115200 8N1.

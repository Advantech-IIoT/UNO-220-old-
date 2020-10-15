##################################
# folders                        #
##################################
currdir=$(shell pwd)
builddir=$(shell realpath -m $(currdir)/build)
compilerdir=$(shell realpath -m $(builddir)/compiler)
kerneldir=$(shell realpath -m $(builddir)/kernel)
kbuilddir=$(shell realpath -m $(builddir)/kbuild)
examplessrcdir=examples
examplesdir=$(shell realpath -m $(builddir)/examples)
configsdir=$(shell realpath -m $(currdir)/configs)
appdir=$(shell realpath -m $(examplesdir)/app)
drvdir=$(shell realpath -m $(examplesdir)/drv)
rootfs=$(shell realpath -m $(builddir)/rootfs)
##################################
# files                          #
##################################
kernel_defconfig=bcm2711_defconfig
kernel_config=$(configsdir)/kernel_config
##################################
# dumps                          #
##################################
# $(info currdir=$(currdir))
# $(info builddir=$(builddir))
# $(info compilerdir=$(compilerdir))
##################################
# urls                           #
##################################
rpicompilerurl=https://github.com/raspberrypi/tools.git 
rpikernelurl=https://github.com/raspberrypi/linux.git
##################################
# branches                       #
##################################
rpicompilerbranch=master
#rpikernelbranch=rpi-4.19.y
rpikernelbranch=raspberrypi-kernel_1.20190925-1
##################################
# hashes                         #
##################################
rpicompilergithash=4a33552
rpikernelhash=b85f76a
##################################
# envs                           #
##################################
export PATH:=$(compilerdir)/arm-bcm2708/arm-linux-gnueabihf/bin:$(PATH) 
export CROSS_COMPILE=arm-linux-gnueabihf-
export HOSTCC=gcc
export CC=$(CROSS_COMPILE)gcc
export ARCH=arm
export SHELL=/bin/bash


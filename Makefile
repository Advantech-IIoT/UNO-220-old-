##################################
# folders                        #
##################################
currdir=$(shell pwd)
builddir=$(shell realpath -m $(currdir)/build)
toolsdir=$(shell realpath -m $(builddir)/tools)
kerneldir=$(shell realpath -m $(builddir)/kernel)
kbuilddir=$(shell realpath -m $(builddir)/kbuild)
examplesdir=$(shell realpath -m $(currdir)/examples)
configsdir=$(shell realpath -m $(currdir)/configs)
appdir=$(shell realpath -m $(exampledir)/app)
drvdir=$(shell realpath -m $(exampledir)/drv)
rootfs=$(shell realpath -m $(builddir)/rootfs)
##################################
# files                          #
##################################
kernel_config=$(configsdir)/kernel_config
##################################
# dumps                          #
##################################
# $(info currdir=$(currdir))
# $(info builddir=$(builddir))
# $(info toolsdir=$(toolsdir))
##################################
# urls                           #
##################################
rpitoolsurl=https://github.com/raspberrypi/tools.git 
rpikernelurl=https://github.com/raspberrypi/linux.git
##################################
# branches                       #
##################################
rpitoolsbranch=master
#rpikernelbranch=rpi-4.19.y
rpikernelbranch=raspberrypi-kernel_1.20190925-1
##################################
# hashes                         #
##################################
rpitoolsgithash=4a33552
rpikernelhash=b85f76a
##################################
# envs                           #
##################################
export PATH:=$(toolsdir)/arm-bcm2708/arm-linux-gnueabihf/bin:$(PATH) 
export CROSS_COMPILE=arm-linux-gnueabihf-
export HOSTCC=gcc
export CC=$(CROSS_COMPILE)gcc
export ARCH=arm
export SHELL=/bin/bash

.PHONY: all test serialtest tools examples menuconfig clean modules check

all: examples

serialtest: $(builddir) $(builddir)/.fetch_tools $(builddir)/.fetch_serialtest $(builddir)/.build_serialtest

$(builddir)/.fetch_serialtest:
	@cp -a $(currdir)/serialtest $(builddir)
	@touch $@

$(builddir)/.build_serialtest:
	@make -C $(builddir)/serialtest

tools: $(builddir) $(builddir)/.fetch_tools 

examples: $(builddir) $(builddir)/.fetch_tools $(builddir)/.fetch_examples \
	$(builddir)/.build_app $(builddir)/.fetch_kernel \
	$(builddir)/.config_kernel $(builddir)/.prepare_drv \
	$(builddir)/.build_drv

modules: $(builddir) $(builddir)/.fetch_tools \
	$(builddir)/.fetch_kernel $(builddir)/.config_kernel \
	$(builddir)/.prepare_drv $(builddir)/.clone_modules \
	$(builddir)/.build_modules

$(builddir)/.clone_modules:
	@cp -a $(currdir)/modules $(builddir)
	@touch $@

$(builddir)/.build_modules: $(rootfs)
	@make -C $(kerneldir) O=$(kbuilddir) M=$(builddir)/modules/rtc
	@make -C $(kerneldir) O=$(kbuilddir) M=$(builddir)/modules/rtc modules_install INSTALL_MOD_PATH=$(rootfs)

$(builddir)/.prepare_drv:
	@make -C $(kerneldir) O=$(kbuilddir) modules_prepare
	@touch $@

$(builddir)/.build_drv: 
	@make -C $(kerneldir) O=$(kbuilddir) M=$(builddir)/examples/drv

$(builddir)/.fetch_kernel: 
	@git clone --depth=1 --branch $(rpikernelbranch) $(rpikernelurl) $(kerneldir)
	@touch $@

$(builddir)/.config_kernel:
	@mkdir -p $(kbuilddir)
	@cp -a $(kernel_config) $(kbuilddir)/.config
	@touch $@

$(builddir)/.fetch_tools: 
	@git clone --depth=1 --branch $(rpitoolsbranch) $(rpitoolsurl) $(toolsdir)
	@touch $@

$(builddir)/.fetch_examples: 
	@cp -a $(examplesdir) $(builddir)

$(builddir)/.build_app: 
	@$(CC) $(CFLAGS) -o $(builddir)/hello $(builddir)/examples/app/hello.c

menuconfig:
	@make -C $(kerneldir) O=$(kbuilddir) menuconfig TERM=vt100

clean: 
	@rm -rf $(builddir)

$(builddir) $(rootfs): 
	@mkdir -p $@

check: 
	@apt-get install -y bison flex


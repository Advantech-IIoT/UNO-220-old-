
$(builddir)/.prepare_kernel: $(builddir)/.fetch_kernel \
                             $(builddir)/.config_kernel \
                             $(builddir)/.modules_prepare_kernel

$(builddir)/.fetch_kernel: 
	@git clone --depth=1 --branch $(rpikernelbranch) $(rpikernelurl) $(kerneldir)
	@touch $@

$(builddir)/.config_kernel: 
	@make -C $(kerneldir) O=$(kbuilddir) ARCH=$(ARCH) $(kernel_defconfig)
	@touch $@

$(builddir)/.modules_prepare_kernel: 
	@make -C $(kerneldir) O=$(kbuilddir) ARCH=$(ARCH) modules_prepare
	@touch $@

$(builddir)/.zimage_kernel: 
	@make -C $(kerneldir) O=$(kbuilddir) ARCH=$(ARCH) zImage

.PHONY: menuconfig
menuconfig: $(builddir)/.prepare_kernel
	@make -C $(kerneldir) O=$(kbuilddir) ARCH=$(ARCH) menuconfig TERM=vt100


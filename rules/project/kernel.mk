
define kerneltemplate

$(builddir)/kernel/$(1)/.prepare_kernel: $(builddir)/kernel/$(1)/.fetch_kernel \
                                         $(builddir)/kernel/$(1)/.config_kernel \
                                         $(builddir)/kernel/$(1)/.modules_prepare_kernel

$(builddir)/kernel/$(1)/.fetch_kernel: 
	@git clone --depth=1 --branch $(kernel$(1)branch) $(kernelgiturl) $(builddir)/kernel/$(1)/src
	@touch $$@

$(builddir)/kernel/$(1)/.config_kernel: 
	@make -C $(builddir)/kernel/$(1)/src O=$(builddir)/kernel/$(1)/build ARCH=$(ARCH) $(kerneldefconfig)
	@touch $$@

$(builddir)/kernel/$(1)/.modules_prepare_kernel: 
	@make -C $(builddir)/kernel/$(1)/src O=$(builddir)/kernel/$(1)/build ARCH=$(ARCH) modules_prepare
	@touch $$@

$(builddir)/kernel/$(1)/.zimage_kernel: 
	@make -C $(builddir)/kernel/$(1)/src O=$(builddir)/kernel/$(1)/build ARCH=$(ARCH) zImage

endef

$(foreach v,$(allkernelversions),$(eval $(call kerneltemplate,$(v))))

.PHONY: menuconfig
menuconfig: $(builddir)/kernel/$(kernelversion)/.prepare_kernel
	@make -C $(kerneldir) O=$(kbuilddir) ARCH=$(ARCH) menuconfig TERM=vt100

.PHONY: prepare_kernel
prepare_kernel: $(builddir)/kernel/$(kernelversion)/.prepare_kernel

.PHONY: prepare_all_kernel
prepare_all_kernel: 
	@for v in $(allkernelversions); do \
	   make prepare_kernel kernelversion=$${v}; \
	 done


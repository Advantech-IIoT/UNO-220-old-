
define modulestemplate

$(builddir)/kernel/$(1)/.fetch_modules: 
	@cp -a $(currdir)/srcs/modules $(builddir)/kernel/$(1)
	@touch $$@

$(builddir)/kernel/$(1)/.build_modules_rtc: 
	@make -C $(builddir)/kernel/$(1)/src O=$(builddir)/kernel/$(1)/build M=$(builddir)/kernel/$(1)/modules/rtc

$(builddir)/kernel/$(1)/.install_modules_rtc: $(rootfs)
	@make -C $(builddir)/kernel/$(1)/src O=$(builddir)/kernel/$(1)/build M=$(builddir)/kernel/$(1)/modules/rtc modules_install INSTALL_MOD_PATH=$(rootfs)

$(builddir)/kernel/$(1)/.prepare_modules: $(builddir)/.prepare_compiler $(builddir)/kernel/$(1)/.prepare_kernel $(builddir)/kernel/$(1)/.fetch_modules 

$(builddir)/kernel/$(1)/.build_modules: $(builddir)/kernel/$(1)/.prepare_modules $(builddir)/kernel/$(1)/.build_modules_rtc

$(builddir)/kernel/$(1)/.install_modules: $(builddir)/kernel/$(1)/.install_modules_rtc

$(builddir)/kernel/$(1)/.depmod_modules: 
	@echo depmod -b $(rootfs) "$(1)" -A -a

endef

$(foreach v,$(allkernelversions),$(eval $(call modulestemplate,$(v))))

.PHONY: modules
modules: $(foreach v,$(allkernelversions), \
           $(builddir)/kernel/$(v)/.prepare_kernel \
           $(builddir)/kernel/$(v)/.build_modules \
           $(builddir)/kernel/$(v)/.install_modules \
           $(builddir)/kernel/$(v)/.depmod_modules \
           )
	@echo "Build $@ done!!"

.PHONY: modules_clean
modules_clean: 
	@rm -rf $(builddir)/kernel/$(kernelversion)/modules
	@rm -rf $(builddir)/kernel/$(kernelversion)/.fetch_modules

.PHONY: modules_install
modules_install: $(builddir)/kernel/$(kernelversion)/.install_modules

.PHONY: modules_install_rtc
modules_install_rtc: $(builddir)/kernel/$(kernelversion)/.install_modules_rtc


.PHONY: modules

$(builddir)/.fetch_modules: 
	@cp -a $(currdir)/modules $(builddir)
	@touch $@

$(builddir)/.build_modules_rtc: 
	@make -C $(kerneldir) O=$(kbuilddir) M=$(builddir)/modules/rtc

$(builddir)/.install_modules_rtc: $(rootfs)
	@make -C $(kerneldir) O=$(kbuilddir) M=$(builddir)/modules/rtc modules_install INSTALL_MOD_PATH=$(rootfs)

$(builddir)/.prepare_modules: $(builddir)/.prepare_compiler $(builddir)/.prepare_kernel $(builddir)/.fetch_modules 

$(builddir)/.build_modules: $(builddir)/.prepare_modules $(builddir)/.build_modules_rtc

$(builddir)/.install_modules: $(builddir)/.install_modules_rtc

.PHONY: modules
modules: $(builddir)/.build_modules $(builddir)/.install_modules
	@echo "Build $@ done!!"



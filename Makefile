currdir=$(shell pwd)

-include $(currdir)/macro.mk
-include $(currdir)/define.mk

.PHONY: all test clean install fetch mount \
	enable_i2c_config modules depmod \
	disable_console_cmdline enable_console_config \
	clone_files umount checksum host_tools

all: $(builddir) fetch mount \
	enable_i2c_config modules depmod \
	disable_console_cmdline enable_console_config \
	clone_files umount checksum host_tools

clone_files:
	@cp -afp $(currdir)/files/root/* $(rootfs) ; sync

depmod: 
	@$(call depmodrootfs)

enable_i2c_config:
	@$(call enablei2cconfig,$(builddir)/boot/config.txt)

disable_i2c_config:
	@$(call disablei2cconfig,$(builddir)/boot/config.txt)

enable_console_cmdline:
	@$(call enableconsolecmdline,$(builddir)/boot/cmdline.txt)

disable_console_cmdline:
	@$(call disableconsolecmdline,$(builddir)/boot/cmdline.txt)

enable_console_config:
	@$(call enableconsoleconfig,$(builddir)/boot/config.txt)

disable_console_config:
	@$(call disableconsoleconfig,$(builddir)/boot/config.txt)

mount: 
	@$(call mountboot)
	@$(call mountroot)

umount: 
	@$(call umountboot)
	@$(call umountroot)

mountsd:
	@mount $(sddev1) $(builddir)/boot
	@mount $(sddev2) $(builddir)/root

umountsd:
	@umount $(builddir)/boot
	@umount $(builddir)/root

fetch: $(builddir)/.fetch_img $(builddir)/.unpack_img

$(builddir)/.fetch_img: 
	@rm -rf $(zipimg)
	@$(call downloadfile,$(imgurl),$(zipimg))
	@touch $@

$(builddir)/.unpack_img:
	@cd $(builddir) && unzip $(zipimg)
	@touch $@

modules: $(builddir) $(builddir)/.build_modules

$(builddir)/.build_modules: $(rootfs)
	@make -C $(kerneldir) modules rootfs=$(rootfs)

clean:
	@rm -rf $(builddir)

$(builddir) $(rootfs): 
	@mkdir -p $@

install:

upload: 
	@./scripts/uploadimage.sh $(img)

checksum:
	@cd $(builddir) && md5sum $(imgname) > $(imgname).md5
	@cd $(builddir) && sha256sum $(imgname) > $(imgname).sha256
	@cd $(builddir) && sha1sum $(imgname) > $(imgname).sha1

host_tools:
	@cp -afp $(currdir)/files/host-x86_64/host_* $(builddir)
	@cp -afp $(currdir)/UNO-220_Release_Notes.txt $(builddir)


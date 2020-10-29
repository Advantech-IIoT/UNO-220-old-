
.PHONY: fetch_img
fetch_img: $(releasedir) $(releasedir)/.fetch_img $(releasedir)/.unpack_img

$(releasedir): 
	@mkdir -p $@

$(releasedir)/.fetch_img: $(zipimg)

$(zipimg): 
	@$(call downloadfile,$(imgurl),$(zipimg))

$(releasedir)/.unpack_img: $(img)

$(img): 
	@cd $(releasedir) && unzip $(zipimg)

.PHONY: clean_img
clean_img: 
	@cd $(releasedir) && rm -rf $(imgname)*

.PHONY: mount_img
mount_img: 
	@$(call mountrpiimg)

.PHONY: umount_img
umount_img: 
	@$(call umountrpiimg)

.PHONY: enable_i2c_config
enable_i2c_config:
	@$(call rpienablei2cconfig,$(mountdir)/boot/config.txt)

.PHONY: disable_i2c_config
disable_i2c_config:
	@$(call rpidisablei2cconfig,$(mountdir)/boot/config.txt)

.PHONY: enable_console_cmdline
enable_console_cmdline:
	@$(call rpienableconsolecmdline,$(mountdir)/boot/cmdline.txt)

.PHONY: disable_console_cmdline
disable_console_cmdline:
	@$(call rpidisableconsolecmdline,$(mountdir)/boot/cmdline.txt)

.PHONY: enable_console_config
enable_console_config:
	@$(call rpienableconsoleconfig,$(mountdir)/boot/config.txt)

.PHONY: disable_console_config
disable_console_config:
	@$(call rpidisableconsoleconfig,$(mountdir)/boot/config.txt)

.PHONY: enable_force_hdmi_hotplug
enable_force_hdmi_hotplug:
	@$(call rpienableforcehdmihotplug,$(mountdir)/boot/config.txt)

.PHONY: disable_force_hdmi_hotplug
disable_force_hdmi_hotplug: 
	@$(call rpidisableforcehdmihotplug,$(mountdir)/boot/config.txt)

.PHONY: enable_ssh_config
enable_ssh_config:
	@touch $(mountdir)/boot/ssh

.PHONY: checksum_img
checksum_img:
	@cd $(releasedir) && md5sum $(imgname) > $(imgname).md5
	@cd $(releasedir) && sha256sum $(imgname) > $(imgname).sha256
	@cd $(releasedir) && sha1sum $(imgname) > $(imgname).sha1

.PHONY: build_basic_img
build_basic_img: \
	clean_img \
	fetch_img \
	mount_img \
	enable_console_config \
	enable_console_cmdline \
	enable_i2c_config \
	enable_ssh_config \
	disable_force_hdmi_hotplug \
	umount_img 

.PHONY: build_dev_img
build_dev_img: \
	clean_img \
	fetch_img \
	mount_img \
	enable_console_config \
	enable_console_cmdline \
	enable_i2c_config \
	enable_ssh_config \
	disable_force_hdmi_hotplug \
	modules \
	rootclone \
	umount_img \
	checksum_img

.PHONY: build_img
build_img: \
	clean_img \
	fetch_img \
	mount_img \
	enable_console_config \
	disable_console_cmdline \
	enable_i2c_config \
	enable_ssh_config \
	enable_force_hdmi_hotplug \
	modules \
	rootclone \
	umount_img \
	checksum_img


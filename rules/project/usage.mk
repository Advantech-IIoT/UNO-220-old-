
define bar
$(shell printf "#%.0s" {1..47}; echo)
endef

define usage_str

##########################################
#                                        #
#        UNO-220 Image Builder           #
#                                        #
##########################################

Usage: 

  $ make fetch_img                   - fetch and unpack image        
  $ make build_dev_img               - build developing image (Enable: ssh, console and i2c; Install: uart/gpio testing tool, rtc udev script and etc. )       
  $ make build_basic_img             - build basic image (Enable: ssh, console and i2c. )
  $ make build_img                   - build UNO-220 image        
  $ make modules                     - build kernel modules in src/modules             
  $ make modules_clean               - clean built kernel modules in build folder
  $ make clean                       - clean build folder

Advanced usage: 

  $ make mount_img                   - mount image configs and rootfs paritition to build/boot and build/root
  $ make umount_img                  - umount build/boot and build/root
  $ make write_sd                    - write image to SD ccard           
  $ make rpidpkgrtc                  - build UNO-220 rtc Debrain package for pure Raspberry Pi image        
  $ make rpidpkggpio                 - build UNO-220 gpio Debrain package for pure Raspberry Pi image        
  $ make rpidpkguart                 - build UNO-220 uart Debrain package for pure Raspberry Pi image        

endef
export usage_str

usage help: 
	@echo "$${usage_str}" | more


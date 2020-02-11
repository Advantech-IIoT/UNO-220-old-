define downloadfile
  (curl -o $2 $1)
endef
define partitionstart
  ( fdisk -l $(1) | grep Device -A 10 | sed -e '1d' | sed -ne '$(2)p' | awk '{print $$2}' )
endef
define partitionend
  ( fdisk -l $(1) | grep Device -A 10 | sed -e '1d' | sed -ne '$(2)p' | awk '{print $$3}' )
endef
define partitionsectors
  ( fdisk -l $(1) | grep Device -A 10 | sed -e '1d' | sed -ne '$(2)p' | awk '{print $$4}' )
endef
# $(call mountimage,$(builddir)/boot,1)
# $(call mountimage,$(builddir)/root,2)
define mountimage
  ( \
    umount $(1) > /dev/null 2>&1; \
    mkdir -p $(1); \
    loopdev=$$(losetup -f); \
    offset=$$($(call partitionstart,$(img),$(2))); \
    sectors=$$($(call partitionsectors,$(img),$(2))); \
    losetup -o $$(($(sector)*$${offset})) --sizelimit $$(($(sector)*$${sectors})) -f $(img); \
    mount $$loopdev $(1); \
  )
endef
define umountimage
  ( \
    loopdev=/dev/$$(lsblk | grep $$(realpath -m $(1)) | awk '{print $$1}'); \
    umount $$loopdev; \
    losetup -d $$loopdev; \
  )
endef
define mountboot
  $(call mountimage,$(builddir)/boot,1)
endef
define mountroot
  $(call mountimage,$(builddir)/root,2)
endef
define umountboot
  $(call umountimage,$(builddir)/boot)
endef
define umountroot
  $(call umountimage,$(builddir)/root)
endef
define enablei2cconfig
  ( \
    sed -i -e '/dtparam=i2c_arm=on/s/^[\t #]*//' $1; \
  )
endef
define disablei2cconfig
  ( \
    sed -i -e '/dtparam=i2c_arm=on/s/^/#/' $1; \
  )
endef
define depmodrootfs
  ( \
    depmod -b $(rootfs) "$(kernelversion)" -A -a; \
  )
endef
define disableconsolecmdline
  ( sed -i -e "s/console=[^ ]*//g" -e "s/^ *//" $(1) )
endef
define enableconsolecmdline
  ( sed -i -e "s/console=[^ ]*//g" -e "s/^ *//" -e "s/^/console=serial0,115200 console=tty1 /g" -e "s/^ *//" $(1) )
endef
define disableconsoleconfig
  ( sed -i -e '/enable_uart=1/d' $(1) )
endef
define enableconsoleconfig
  ( sed -i -e '/enable_uart=1/d' -e '/\[all\]/aenable_uart=1' $(1) )
endef

define rpienablei2cconfig
  ( \
    sed -i -e '/dtparam=i2c_arm=on/s/^[\t #]*//' $1; \
  )
endef
define rpidisablei2cconfig
  ( \
    sed -i -e '/dtparam=i2c_arm=on/s/^/#/' $1; \
  )
endef
define rpidisableconsolecmdline
  ( sed -i -e "s/console=[^ ]*//g" -e "s/^ *//" $(1) )
endef
define rpienableconsolecmdline
  ( sed -i -e "s/console=[^ ]*//g" -e "s/^ *//" -e "s/^/console=serial0,115200 console=tty1 /g" -e "s/^ *//" $(1) )
endef
define rpidisableconsoleconfig
  ( sed -i -e '/enable_uart=1/d' $(1) )
endef
define rpienableconsoleconfig
  ( sed -i -e '/enable_uart=1/d' -e '/\[all\]/aenable_uart=1' $(1) )
endef
define rpidisableforcehdmihotplug
  ( sed -i -e 's/.*hdmi_force_hotplug=.*/#hdmi_force_hotplug=1/' $(1) )
endef
define rpienableforcehdmihotplug
  ( sed -i -e 's/.*hdmi_force_hotplug=.*/hdmi_force_hotplug=1/' $(1) )
endef

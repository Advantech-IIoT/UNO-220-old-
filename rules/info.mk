
define info_str

  $(shell printf "%-20s : \n" "compiler")
  $(shell printf "%-20s : %s\n" "  CROSS_COMPILE" "$(CROSS_COMPILE)" )
  $(shell printf "%-20s : %s\n" "  PATH" "$(compilerdir)/arm-bcm2708/arm-linux-gnueabihf/bin" )
  $(shell printf "%-20s : \n" "kernel")
  $(shell printf "%-20s : %s\n" "  kerneldir" "$(kerneldir)" )
  $(shell printf "%-20s : %s\n" "  kernel_defconfig" "$(kernel_defconfig)" )

endef
export info_str

.PHONY: info
info: 
	@echo "$${info_str}"

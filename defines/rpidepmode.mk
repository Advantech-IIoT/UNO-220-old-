define depmodrootfs
  ( \
    depmod -b $(rootfs) "$(kernelversion)" -A -a; \
  )
endef


.PHONY: test


define testcmd
  ( \
    umount $(1) > /dev/null 2>&1; \
    mkdir -p $(1); \
    mount -o loop,offset=$$($(call partitionoffset,$(img),$(2))),sizelimit=$$($(call partitionsize,$(img),$(2))) $(img) $(1); \
  )
endef

test: 
	@$(call testcmd,$(builddir)/boot,1)

test2: 
	@echo imgname=$(imgname)
	@echo imgurl=$(imgurl)
	@echo kernelversion=$(kernelversion)
	@echo kernelconfig=$(kernelconfig)
	@echo kerneldefconfig=$(kerneldefconfig)
	@echo kernelgiturl=$(kernelgiturl)
	@echo kernelbranch=$(kernelbranch)

test3: $(builddir)/.fetch_kernel

test4: prepare_kernel $(builddir)/.build_modules


test5: 	
	@echo "Please select disk? ($$($(call listrpidisk)))"
#	@$(call mountrpidisk)

test6: fetch_img mount_img

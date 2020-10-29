
define rpiimgsectorbytes
  [ -e $(1) ] && ( fdisk -l $(1) | grep "^Units" | sed -e 's/[^=]*= *\([1-9][0-9]*\).*/\1/' )
endef
define rpiimginfo
  [ -e $(1) ] && ( fdisk -l $(1) | awk '/Device/{hunt=1;next;} {if(hunt==1) print $$0; }' | sed -ne '$(2)p' )
endef
define rpiimgstart
  [ -e $(1) ] && ( $(call rpiimginfo,$(1),$(2)) | awk '{print $$2}' )
endef
define rpiimgend
  [ -e $(1) ] && ( $(call rpiimginfo,$(1),$(2)) | awk '{print $$3}' )
endef
define rpiimgsectors
  [ -e $(1) ] && ( $(call rpiimginfo,$(1),$(2)) | awk '{print $$4}' )
endef
define rpiimgoffset
  [ -e $(1) ] && ( echo $$(( $$($(call rpiimgstart,$(1),$(2))) * $$($(call rpiimgsectorbytes,$(1))) )) )
endef
define rpiimgsize
  [ -e $(1) ] && ( echo $$(( $$($(call rpiimgsectors,$(1),$(2))) * $$($(call rpiimgsectorbytes,$(1))) )) )
endef
define mountrpiimgsel
  ( \
    umount $(1) > /dev/null 2>&1; \
    mkdir -p $(1); \
    mount -o loop,offset=$$($(call rpiimgoffset,$(img),$(2))),sizelimit=$$($(call rpiimgsize,$(img),$(2))) $(img) $(1); \
  )
endef
define umountrpiimgsel
  ( \
    umount $(1); > /dev/null 2>&1; \
  )
endef
define mountrpiimg
  $(call mountrpiimgsel,$(mountdir)/boot,1); \
  $(call mountrpiimgsel,$(mountdir)/root,2)
endef
define umountrpiimg
  $(call umountrpiimgsel,$(mountdir)/boot); \
  $(call umountrpiimgsel,$(mountdir)/root)
endef
define mountboot
  $(call mountrpiimgsel,$(mountdir)/boot,1)
endef
define mountroot
  $(call mountrpiimgsel,$(mountdir)/root,2)
endef
define umountboot
  $(call umountrpiimgsel,$(mountdir)/boot)
endef
define umountroot
  $(call umountrpiimgsel,$(mountdir)/root)
endef


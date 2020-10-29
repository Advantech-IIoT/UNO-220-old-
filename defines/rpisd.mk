
define listrpisd
  lsblk -d | awk 'BEGIN{p=0;} /^NAME/{hunt=1;next;} $$6=="disk"&&hunt==1{if(p==1) printf ","; printf $$1;p=1;}'
endef

define mountrpisd
  echo "Please select disk mount? ($$($(call listrpisd)))"; \
  read -s disk; \
  echo "Disk '$$disk' is selected."; \
  echo "Are you sure to mount '$$disk'? (y/n)"; \
  read -s ans; \
  if [ "$$ans" == "y"  ] ; then \
    mount /dev/$${disk}1 $(builddir)/boot; \
    mount /dev/$${disk}2 $(builddir)/root; \
  else \
    echo "Bye..." ; \
  fi; 
endef

define umountrpisd
  umount $(builddir)/boot > /dev/null 2>&1; \
  umount $(builddir)/root > /dev/null 2>&1; 
endef

define writerpisd
  echo "Please select disk to write image? ($$($(call listrpisd)))"; \
  read -s disk; \
  echo "Disk '$$disk' is selected."; \
  echo "Are you sure to write image into '$$disk'? (y/n)"; \
  read -s ans; \
  if [ "$$ans" == "y"  ] ; then \
    dd if=$(img) of=/dev/$${disk} bs=10240 status=progress; \
  else \
    echo "Bye..." ; \
  fi; 
endef


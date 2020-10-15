
define debugcmd
  exec > >(tee -i -a $(builddir)/$(if $(2),log$(shell echo $(2) | sed -e 's/^.*\///'),log.$(shell date +"%F_%T"))); exec 2>&1; set -x; $(1)
endef


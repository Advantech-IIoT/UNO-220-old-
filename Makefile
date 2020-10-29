

ifdef _REALRUN

include macro.mk
# include rules/basic/*.mk
# include rules/project/*.mk
include defines/*.mk
include rules/*/*.mk

else
	
export _REALRUN=1
.DEFAULT_GOAL:=usage
_MAKEFILE=$(CURDIR)/$(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
_MAKEFLAGS=$(filter-out --,$(MAKEFLAGS))

.PHONY: build
%: 
	@time make -f $(_MAKEFILE) $@ $(filter-out --,$(_MAKEFLAGS))

endif


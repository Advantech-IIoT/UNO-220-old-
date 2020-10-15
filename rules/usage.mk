
define bar
$(shell printf "#%.0s" {1..47}; echo)
endef

define usage_str

##########################################
#                                        #
#           Raspberry PI 4               #
#    Kernel Image and Modues Builder     #
#                                        #
##########################################

Usage: 

  $ make                      - show this usage
  $ make compiler             - prepare toolchain compiler
  $ make examples             - compile examples code
  $ make modules              - compile kernel modules code
  $ make serialtest           - compile serialtest tool    
  $ make clean                - clean build

endef
export usage_str

usage help: 
	@echo "$${usage_str}" | more


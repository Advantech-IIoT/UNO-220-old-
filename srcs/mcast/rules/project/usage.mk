
define bar
$(shell printf "#%.0s" {1..47}; echo)
endef

define usage_str

##########################################
#                                        #
#          mcast server/client           #
#                                        #
##########################################

Usage: 

  $ make                             - show this usage
  $ make help                        - show this usage
  $ make fetch_img                   - fetch and unpack image        

endef
export usage_str

usage help: 
	@echo "$${usage_str}" | more


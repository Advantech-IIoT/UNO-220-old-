topdir=$(shell realpath -m $(shell pwd)/..)
currdir=$(shell realpath -m $(shell pwd))
include $(currdir)/env.mk
targets=test
targets+=recv
targets+=send
recv_srcs=recv.c 
recv_cflags=-Wall
#recv_cc=$(HOSTCC)
recv_cc=$(CC)
send_srcs=send.c 
send_cflags=-Wall -DDISPLAY_STRING
send_cc=$(CC)
test_srcs=main.c
test_cflags=-Wall -DDISPLAY_STRING
test_cc=$(CC)
vars=targets test_srcs test_cflags recv_srcs recv_cflags send_srcs send_cflags 
model=uno220uart
define stripvar
$(1):=$(strip $($(1)))
endef
$(foreach v,$(vars),$(eval $(call stripvar,$(v))))

define targetrule
$(1):
	@$($(1)_cc) $($(1)_cflags) -o uno220uart$(1) $($(1)_srcs)
	@$(HOSTCC) $($(1)_cflags) -o host_$(1) $($(1)_srcs)
endef

.PHONY: all clean
all: clean $(targets)

clean: 
	@rm -rf host_* uno220uart*

$(foreach t,$(targets),$(eval $(call targetrule,$(t))))


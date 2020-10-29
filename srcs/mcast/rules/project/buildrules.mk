
define buildrulesprepare
$(1)_objs=$(foreach s,$($(1)_sources),$(builddir)/$(1)/$(patsubst %.c,%.o,.$(1)_$(s)))
endef
define objruletemplate
$(builddir)/$(1)/$(patsubst %.c,%.o,.$(1)_$(2)): $(srcsdir)/$(2)
	@$(CC) $($(1)_cflags) -o $$@ $$<
endef
define buildrulestemplate
.PHONY: $(1)
$(1): $(builddir)/$(1) $(builddir)/$(1)/.prepare_$(1) $(builddir)/$(1)/.compile_source_$(1) $(builddir)/$(1)/.compile_$(1)

$(builddir)/$(1): 
	@mkdir -p $$@

$(builddir)/$(1)/.prepare_$(1): 
	@cp -a $(foreach s,$($(1)_sources),$(srcsdir)/$(s)) $(builddir)/$(1)
	@touch $$@


$(builddir)/$(1)/.compile_source_$(1): $($(1)_objs)
	@$(1)_objs=$($(1)_objs)

$(foreach s,$($(1)_sources),$(eval $(call objruletemplate,$(1),$(s))))

$(builddir)/$(1)/.compile_$(1): 
	@$(LD) $($(1)_ldflags) -o $(builddir)/$(1)/$($(1)_target) $($(1)_objs)

endef
$(eval $(call buildrulesprepare,mcastserver))
$(eval $(call buildrulestemplate,mcastserver))

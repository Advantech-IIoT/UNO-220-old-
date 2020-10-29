$(builddir)/.fetch_serialtest:
	@cp -a $(currdir)/srcs/serialtest $(builddir)
	@touch $@

$(builddir)/.prepare_serialtest: $(builddir)/.fetch_serialtest

$(builddir)/.build_serialtest: $(builddir)/.prepare_compiler $(builddir)/.prepare_serialtest $(builddir)/.compile_serialtest 

$(builddir)/.compile_serialtest: 
	@make -C $(builddir)/serialtest

.PHONY: serialtest
serialtest: $(builddir)/.build_serialtest

.PHONY: serialtest_clean
serialtest_clean: 
	@rm -rf $(builddir)/serialtest
	@rm -rf $(builddir)/.fetch_serialtest


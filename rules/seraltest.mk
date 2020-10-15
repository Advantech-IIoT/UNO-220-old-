$(builddir)/.fetch_serialtest:
	@cp -a $(currdir)/serialtest $(builddir)

$(builddir)/.prepare_serialtest: $(builddir)/.fetch_serialtest

$(builddir)/.build_serialtest: $(builddir)/.prepare_compiler $(builddir)/.prepare_serialtest $(builddir)/.compile_serialtest 

$(builddir)/.compile_serialtest: 
	@make -C $(builddir)/serialtest

serialtest: $(builddir)/.build_serialtest



$(builddir)/.fetch_compiler:
	@git clone --depth=1 --branch $(compilerbranch) $(compilerurl) $(compilerdir)
	@touch $@

$(builddir)/.prepare_compiler: $(builddir)/.fetch_compiler

.PHONY: compiler
compiler: $(builddir)/.prepare_compiler


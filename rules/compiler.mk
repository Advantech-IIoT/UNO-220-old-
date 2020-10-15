
$(builddir)/.fetch_compiler:
	@git clone --depth=1 --branch $(rpicompilerbranch) $(rpicompilerurl) $(compilerdir)
	@touch $@

$(builddir)/.prepare_compiler: $(builddir)/.fetch_compiler

.PHONY: compiler
compiler: $(builddir)/.prepare_compiler


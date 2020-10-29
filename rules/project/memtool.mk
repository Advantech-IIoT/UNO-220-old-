$(builddir)/.fetch_memtool:
	@cp -a $(currdir)/srcs/memtool $(builddir)
	@touch $@

$(builddir)/.prepare_memtool: $(builddir)/.fetch_memtool

$(builddir)/.build_memtool: $(builddir)/.prepare_compiler $(builddir)/.prepare_memtool $(builddir)/.compile_memtool 

$(builddir)/.compile_memtool: 
	@make -C $(builddir)/memtool

.PHONY: memtool
memtool: $(builddir)/.build_memtool
	@echo "Build $@ done!!"

.PHONY: memtool_clean
memtool_clean: 
	@rm -rf $(builddir)/memtool
	@rm -rf $(builddir)/.fetch_memtool


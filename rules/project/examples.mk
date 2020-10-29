
examplesdir=$(shell realpath -m $(builddir)/examples)
appdir=$(shell realpath -m $(examplesdir)/app)
drvdir=$(shell realpath -m $(examplesdir)/drv)

$(builddir)/.prepare_examples: $(builddir)/.fetch_examples 

$(builddir)/.fetch_examples:
	@tar -C $(currdir)/srcs -zcpvf - examples | tar -C $(builddir) -zxpvf -
	@touch $@

$(builddir)/.build_examples: $(builddir)/.prepare_compiler $(builddir)/.prepare_examples $(builddir)/.compile_examples_app

$(builddir)/.compile_examples_app:
	@$(CC) $(CFLAGS) -o $(appdir)/hello $(appdir)/hello.c

.PHONY: examples
examples: $(builddir)/.build_examples
	@echo "Build $@ done!!"

.PHONY: examples_clean
examples_clean: 
	@rm -rf $(builddir)/examples
	@rm -rf $(builddir)/.fetch_examples


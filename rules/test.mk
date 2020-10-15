
.PHONY: test
test: $(builddir)/.fetch_compiler \
	$(builddir)/.fetch_kernel \
	$(builddir)/.build_examples \
	$(builddir)/.build_modules


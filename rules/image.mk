
.PHONY: image
image: fetch $(builddir)/.build_image 

$(builddir)/.build_image: 
	@$(call log_n_run,cd $(builddir)/image && make,build_image)

$(builddir)/.clean_image: 
	@$(call log_n_run,cd $(builddir)/image && make clean,clean_image)


.PHONY: clean cleanall

clean: umount 
	@rm -rf $(img)

cleanall:
	@rm -rf $(builddir)


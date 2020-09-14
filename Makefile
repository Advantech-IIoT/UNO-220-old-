dirs=$(strip $(foreach d,$(shell find . -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sed -e '/^\./d'),$(shell basename $(d))))
all clean:
	@ for d in $(dirs); do \
            if [ -f "$${d}/Makefile" ] ; then \
	      echo "make $${d}..."; \
	      make -C $${d} $@; \
	    fi; \
          done


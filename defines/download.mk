define downloadfile
  (mkdir -p $(builddir)/download && curl -o $2 $1)
endef

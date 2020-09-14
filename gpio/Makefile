currdir=$(shell realpath $(shell pwd))
builddir=$(shell realpath -m $(currdir)/build)
name=uno220gpio
version=0.1
revision=1
arch=armhf
desc=Advantech UNO-220 (Raspberry PI 4) IO Card GPIO EXPANDER for TI TCA9554 
editor=Ralph Wang <ralph.wang@advantech.com.tw>
depends=sed (>=4.7-1)
packagedir=$(shell realpath -m $(builddir)/$(name))
debiandir=$(shell realpath -m $(packagedir)/DEBIAN)
debfile=$(builddir)/$(name).deb
SHELL=/bin/bash
export SHELL desc 

#$(info currdir=$(currdir))
#$(info builddir=$(builddir))

.PHONY: all clean test sample install uninstall purge

all: clean sample

sample: $(builddir)/.fetch_sample $(builddir)/.patch_sample $(builddir)/.build_sample 
	
$(builddir)/.fetch_sample: $(builddir)
	@cp -a sample $(builddir)
	@touch $@

$(builddir)/.patch_sample: $(builddir)
	@sed -i "s/__name__/$(name)/" $(builddir)/sample/DEBIAN/*
	@sed -i "s/__version__/$(version)/" $(builddir)/sample/DEBIAN/*
	@sed -i "s/__revision__/$(revision)/" $(builddir)/sample/DEBIAN/*
	@sed -i "s/__arch__/$(arch)/" $(builddir)/sample/DEBIAN/*
	@sed -i "s/__desc__/$(desc)/" $(builddir)/sample/DEBIAN/*
	@sed -i "s/__editor__/$(editor)/" $(builddir)/sample/DEBIAN/*
	@sed -i "s/__depends__/$(depends)/" $(builddir)/sample/DEBIAN/*
	@touch $@

$(builddir)/.build_sample: $(builddir)
	@dpkg --build $(builddir)/sample $(builddir)

$(builddir)/.install_sample: 
	@[ -f "$(builddir)/$(name)_$(version)-$(revision)_$(arch).deb" ] && dpkg --install $(builddir)/$(name)_$(version)-$(revision)_$(arch).deb

install: $(builddir)/.install_sample

uninstall: 
	@dpkg --remove $(name)

purge:
	@dpkg --purge $(name)

$(builddir) $(trydir):
	@mkdir -p $@

clean: 
	@dpkg --purge $(name) >/dev/null 2>&1
	@rm -rf $(builddir)


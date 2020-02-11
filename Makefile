currdir=$(realpath $(shell pwd))
builddir=$(currdir)/build
repourl=http://commondatastorage.googleapis.com/git-repo-downloads/repo
repogiturl=https://gerrit.googlesource.com/git-repo
repodir=$(builddir)/bin
repo=$(repodir)/repo
manifesturl=https://github.com/Advantech-IIoT/uno-220.git
manifest=default.xml
projectbranch=project/iocard
# $(info $(currdir))
SHELL=/bin/bash
.PHONY: all test clean repo

all: $(builddir)/.fetch_repo $(builddir)/.fetch_project

repo: $(builddir)/.fetch_repo

test:
#	@git clone $(repogiturl) $(repo) && cd $(repo) && git checkout v1.13.9.4
	@git clone --branch v1.13.9.4 $(repogiturl) $(repodir)

version:
	@$(repo) version

$(builddir)/.fetch_repo: $(builddir)
#	@mkdir -p $(repodir)
#	@curl -s $(repourl) -o $(repo)
	@git clone --branch v1.13.9.4 $(repogiturl) $(repodir) && rm -rf $(repodir)/.git
	@chmod a+x $(repo)
	@touch $@

$(builddir)/.fetch_project: $(builddir)
	cd $(builddir) && $(repo) init --depth=1 -u $(manifesturl) -m $(manifest) -b "$(projectbranch)" \
		&& $(repo) sync
	@touch $@

clean: 
	@rm -rf $(builddir)

$(builddir) $(manifestdir):
	@mkdir -p $@



define fetch_repo_cmd
  git clone --branch v1.13.9.4 $(repogiturl) $(repodir) && rm -rf $(repodir)/.git; \
  chmod a+x $(repo);
endef



define log_n_run
  (_log_n_time=$(builddir)/logs/$(2)-$$(date +"%F_%T").log; \
  _log=$(builddir)/logs/$(2).log; \
  mkdir -p $(builddir)/logs; \
  rm -rf $${_log_n_time}; \
  ln -sf $${_log_n_time} $${_log}; \
  exec > >(tee -i -a $${_log_n_time}); \
  exec 2>&1; \
  set -x; \
  $(1)) $(_S)
endef


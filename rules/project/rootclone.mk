
.PHONY: rootclone
rootclone: $(builddir)/.rootclone

$(builddir)/.rootclone: $(rootfs)
	@( tar -C $(rootclone) --numeric-owner -zcpvf - . | tar -C $(rootfs) -zxpvf - ) > /dev/null 2>&1

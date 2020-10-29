
.PHONY: mount_sd
mount_sd:
	@$(call mountrpisd)

.PHONY: umount_sd
umount_sd:
	@$(call umountrpisd)

.PHONY: write_sd
write_sd:
	@$(call writerpisd)


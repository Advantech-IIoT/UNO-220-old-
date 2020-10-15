
define printfcolor
  define printf$(1)
    printf $($(shell echo $1 | tr 'a-z' 'A-Z')); \
    printf $$1 $$2; \
    printf $(NC);
  endef
endef

define printferr 
  printf $(call _bgc,93,41,5); \
  printf " Error: "$1 $2; \
  printf " \n"; \
  printf $(NC);
endef

#colors=black boldgray red boldred green boldgreen orange \
#       yellow blue boldblue purple boldpurple cyan boldcyan \
#       white
colors=red yellow green blue cyan white

$(foreach c,$(colors),$(eval $(call printfcolor,$(c))))

.PHONY: printftest
printftest:
	@$(call printferr,"%-20s",$@"!!")


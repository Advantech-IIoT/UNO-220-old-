define xxbfsbfbsf

Black        0;30     Dark Gray     1;30
Red          0;31     Light Red     1;31
Green        0;32     Light Green   1;32
Brown/Orange 0;33     Yellow        1;33
Blue         0;34     Light Blue    1;34
Purple       0;35     Light Purple  1;35
Cyan         0;36     Light Cyan    1;36
Light Gray   0;37     White         1;37
And then use them like this in your script:

RED='\033[0;31m'
NC='\033[0m' # No Color
printf "I ${RED}love${NC} Stack Overflow\n"

endef


# color: $1: R, $2: G, $3: B
_c='\033[$(4);$(shell echo $$(( $(1)+2*$(2)+4*$(3)+30 )))m'
# background
_bgc='\033[$(3);$(1);$(2)m'
BLACK=$(call _bgc,30,49,0)
RED=$(call _bgc,31,49,0)
BOLDRED=$(call _bgc,31,49,1)
YELLOW=$(call _bgc,33,49,0)
BOLDYELLOW=$(call _bgc,33,49,1)
GREEN=$(call _bgc,32,49,0)
BOLDGREEN=$(call _bgc,32,49,1)
BLUE=$(call _bgc,34,49,0)
BOLDBLUE=$(call _bgc,34,49,1)
PURPLE=$(call _bgc,35,49,0)
BOLDPURPLE=$(call _bgc,35,49,1)
CYAN=$(call _bgc,36,49,0)
BOLDCYAN=$(call _bgc,36,49,1)
WHITE=$(call _bgc,37,49,0)
NC='\033[0m'

fg=$(shell echo 39 {30..37} {90..97})
bg=$(shell echo 49 {40..47} {100..107})

.PHONY: colortest
colortest:
#	@$(foreach c,$(colors),$(call printf$(c),"%s %s\n","prntf$$c" "test!!"))
	@i=0; \
	 for b in $(bg) ; do \
	   for f in $(fg) ; do \
	     printf '\033[1;'%03d';'%03d'm\\033[1;%03d;%03dm' $${f} $${b} $${f} $${b}; printf $(NC); \
	     i=$$(($${i}+1)); \
	     [ ! $$(($$i % 3)) -eq 0 ] && printf ' ' || printf '\n'; \
	   done \
         done ; printf '\nnc: \\033[0m;\n'; 



##################################
# folders                        #
##################################
topdir=$(shell realpath -m $(PWD)/..)
builddir?=$(shell realpath -m $(topdir)/build)
toolsdir=$(shell realpath -m $(builddir)/tools)
##################################
# envs                           #
##################################
export PATH:=$(toolsdir)/arm-bcm2708/arm-linux-gnueabihf/bin:$(PATH) 
export CROSS_COMPILE=arm-linux-gnueabihf-
export CC=$(CROSS_COMPILE)gcc
export HOSTCC=gcc
export ARCH=arm
export SHELL=/bin/bash


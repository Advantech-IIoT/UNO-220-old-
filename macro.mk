##################################
# folders                        #
##################################
builddir=$(shell realpath -m $(currdir)/build)
kerneldir=$(shell realpath -m $(currdir)/../kernel)
rootfs=$(shell realpath -m $(builddir)/root)
##################################
# files                          #
##################################
zipimg=$(builddir)/raspbian.img.zip
imgname=2019-09-26-raspbian-buster-full.img
img=$(builddir)/$(imgname)
#img=$(builddir)/2019-09-26-raspbian-buster-lite.img
##################################
# urls                           #
##################################
imgurl=http://downloads.raspberrypi.org/raspbian_full/images/raspbian_full-2019-09-30/2019-09-26-raspbian-buster-full.zip
#imgurl=http://downloads.raspberrypi.org/raspbian_lite/images/raspbian_lite-2019-09-30/2019-09-26-raspbian-buster-lite.zip
##################################
# image                          #
##################################
sector=512
##################################
# kernel                         #
##################################
kernelversion=4.19.75-v7l+
##################################
# sd card devices                #
##################################
sddev1=/dev/sde1
sddev2=/dev/sde2

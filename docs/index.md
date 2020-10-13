Create Raspbian Image for UNO-220
===

### Prerequisite
---
- **[Project Github Link](https://github.com/Advantech-IIoT/uno-220/tree/master)**
- **[Raspberry pi 4 model b](https://www.raspberrypi.org/products/raspberry-pi-4-model-b/)**
- **Advantech UNO-220 (IO extender)**
- **SD card (over 8GB recommanded)**
- **Host PC**
  - Ubuntu 16.04 (x86_64) recommanded
  - This guide uses Virtualbox with Ubutuntu 16.04 x86_64 image.
  - Packages needs to be installed in host ubuntu. 
    ```
    $ apt-get install bison flex libssl-dev
    ```

### UNO-220 Information
---
- **TI TCA9554 IO extender**  
- **RTC RX-8010SJ-B**
- **Serial to RS-232/485** 

### Build Raspbian Debian Buster Full Image Sample Code
---
- **Clone project source from Github**
  ```
  $ git clone --depth=1 -b project/iocard https://github.com/Advantech-IIoT/uno-220.git project/iocard
  ```
- **Fetch project source**
  ```
  $ cd project/iocard
  $ make 
  ```
- **Build image**
  ```
  $ cd build/image
  $ make 
  ```
- **Imgae location**
  ```
  $ ls build/2019-09-26-raspbian-buster-full.img
  ```

### Write image to SD card
---
  Please check your SD card device in your system, the naming rule will be `/dev/sdx`. This following example is to use `/dev/sde`. 
  
  ```
  ./scripts/writesdimage.sh -d /dev/sde -i build/2019-09-26-raspbian-buster-full.img
  ```

### Official Raspbian Debian Buster Full Image
---
- **Download Image**
  ```
  $ curl -o 2019-09-26-raspbian-buster-full.zip http://downloads.raspberrypi.org/raspbian_full/images/raspbian_full-2019-09-30/2019-09-26-raspbian-buster-full.zip 
  $ unzip 2019-09-26-raspbian-buster-full.zip
  ```
- **Use `fdisk` command to check disk partitions.**
  ```
  $ fdisk -l 2019-09-26-raspbian-buster-full.img
  Disk 2019-09-26-raspbian-buster-full.img: 6.4 GiB, 6811549696 bytes, 13303808 sectors
  Units: sectors of 1 * 512 = 512 bytes
  Sector size (logical/physical): 512 bytes / 512 bytes
  I/O size (minimum/optimal): 512 bytes / 512 bytes
  Disklabel type: dos
  Disk identifier: 0x5e3da3da

  Device                               Boot  Start      End  Sectors  Size Id Type
  2019-09-26-raspbian-buster-full.img1        8192   532479   524288  256M  c W95 FAT32 (LBA)
  2019-09-26-raspbian-buster-full.img2      532480 13303807 12771328  6.1G 83 Linux

  ```

**INPORTANT!!**

Official raspbain image doesn't include UNO-220's RTC driver(rtc-rx8010).

If you update your system or kernel, please add driver by manual.

             
### Quick Way to Add RTC Drvier

The kernel version in UNO-220's SD card is `4.19.75-v7l+`. 

If you update your system or kernel, you can follow the quick way to add driver. 

Check your kernel version and rtc driver: 

```
$ uname -r
$ ls /lib/modules/$(uname -r)/extra/rtc-rx8010.ko
```

If not exists, please copy it into your current release. 

```
$ sudo mkdir -p /lib/modules/$(uname -r)/extra
$ sudo cp -a /lib/modules/4.19.75-v7l+/extra/rtc-rx8010.ko /lib/modules/$(uname -r)/extra/rtc-rx8010.ko
$ sudo depmod -a 
```

### Raspbian Image Compiler and Kernel Source
---
- [Kernel Source](https://github.com/raspberrypi/linux.git)
- [Toolchain](https://github.com/raspberrypi/tools.git)


### Compile RTC Driver
---
- **Clone [raspbian/kernel](https://github.com/Advantech-IIoT/uno-220/tree/raspbian/kernel) from github repository.**

  If you want to change the kernel, please modify the kernel source git URL and branch in [Makefile](https://github.com/Advantech-IIoT/uno-220/blob/raspbian/kernel/Makefile) first . 
  
  ```
  $ git clone --depth 1 -b raspbian/kernel https://github.com/Advantech-IIoT/uno-220.git
  $ cd build/kernel
  $ make modules
  ```

  Raspberry PI 4 kernel source git url and branch definition: 
  
  ```
  rpikernelurl=https://github.com/raspberrypi/linux.git
  rpikernelbranch=raspberrypi-kernel_1.20190925-1
  ```

- **Then, rtc driver will be located in the path as below.**
  ```
  $ ls build/modules/rtc/rtc-rx8010.ko
  build/modules/rtc/rtc-rx8010.ko
  ```

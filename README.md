# openwrt-orange-pi
openwrt on orange pi, try to bring up mali 400

#### 1. create container to build openwrt
It's optional to build openwrt inside a container.
```
./docker.sh build
./docker.sh create
# enter container
./docker.sh
# https://openwrt.org/docs/guide-developer/toolchain/install-buildsystem#debianubuntu
# install dependences for openwrt building
./docker.sh apt-install
#add "export GIT_SSL_NO_VERIFY=1" to .bashrc
#commit container as new docker image
```

#### 2. build openwrt
```
./docker.sh start
# enter docker
./docker.sh
cd share

# https://openwrt.org/docs/guide-developer/toolchain/use-buildsystem
# Download and update the sources
git clone https://git.openwrt.org/openwrt/openwrt.git
cd openwrt
git pull
 
# Select a specific code revision
git branch -a
git tag
git checkout v21.02.2
 
# Update the feeds
./scripts/feeds update -a
./scripts/feeds install -a
 
# configure for x86 openwrt
wget https://downloads.openwrt.org/releases/21.02.2/targets/x86/64/config.buildinfo -O .config
# configure for orange pi pc
wget https://downloads.openwrt.org/releases/21.02.2/targets/sunxi/cortexa7/config.buildinfo -O .config
make menuconfig #select target profile: Xunlong Orange Pi PC
		#select image size to 256M - 50M, later resize to 256M or 512M?
		#libdrm
		?note: disable qosify when build mainline


# Build the firmware image
make -j $(nproc) defconfig download clean world
?make save defconfig

# normal build
yes "" | make -j $(nproc)
```

#### 3 test in qemu
For x86 openwrt
```
cd openwrt/bin/targets/x86/64/
cp openwrt-21.02.2-x86-64-generic-ext4-rootfs.img.gz 1.img.gz
gunzip 1.img.gz
./qemu.sh x86-x86
```

For orange pi pc
```
cd bin/targets/sunxi/cortexa7/
cp openwrt-21.02.2-sunxi-cortexa7-xunlong_orangepi-pc-ext4-sdcard.img.gz n1.img.gz
gunzip n1.img.gz
qemu-img resize n1.img 512M(or 2048M?)
./qemu.sh x86-h3
```

#### 4 test on orange pi R1 board
Follow orange web site, use dd command to burn the image

#### 5 enable cedrus
Add below flags

CONFIG_MEDIA_SUPPORT
CONFIG_MEDIA_CONTROLLER
CONFIG_MEDIA_CONTROLLER_REQUEST_API
CONFIG_V4L_MEM2MEM_DRIVERS
CONFIG_VIDEO_SUNXI_CEDRUS

```
make kernel_menuconfig
make -j 8
make -j 8 world
```

#### 6 build libva, libva-v4l2-request
##### Preparation
Download libva-v2.14-branch.zip, libva-v4l2-request-release-2019.03.zip to a directory and untar them.
Clone openwrt-feeds-xorg. like this,
```
richard@richard-NH50-70RA:~/work/2022/k516/tmp$ pwd
/home/richard/work/2022/k516/tmp
richard@richard-NH50-70RA:~/work/2022/k516/tmp$ ls
openwrt-feeds-xorg/         libva-2.14-branch/                   release-2019.03.zip
libva-v2.14-branch.zip     libva-v4l2-request-release-2019.03/
```

```
# put feeds.conf in the root directory of openwrt sourcecode
# in the feeds.conf, must specify the correct mypackages location
./scripts/feeds update mypackages
./scripts/feeds install -a -p mypackages
make menuconfig

#select Examples/libva, libva_v4l2_request
#select libdrm
#seelct xorg/utils/xorg-macros

make 
```

to build libva/libdrm/libva_v4l2_request
> make V=s package/xxxxx/{clear,compile}


#### 7 build mali mali drivers
```
make V=s package/sunxi_mali/{clean,compile}
```

#### 8 build ffmpeg and examples hw_decode
select package ffmpeg from menuconfig, and change the makefile to include examples compiling
```
make V=s package/ffmpeg/compile
```

#### 9 test egl/opengl sample application
opengl sample application: multilangs/c/hellofunc.c
egl sample application: multilangs/c/egltutorial.c
```
make V=s package/helloworld/{clean,compile}
```


# Appendix
### Good links on openwrt
build module/application/package for openwrt
https://www.ccs.neu.edu/home/noubir/Courses/CS6710/S12/material/OpenWrt_Dev_Tutorial.pdf

### enable openwrt network
```
#/etc/config/network
config interface 'wan'      
        option ifname 'eth0'
        option proto 'dhcp' 

/etc/init.d/network restart
```

### copy from host
```
scp -P 33333 richard@192.168.100.1:/path/to/file ./
```

### install sshd
```
opkg update
opkg install openssh-server
```


# Appendix
## Errors
> scripts/config/mconf: error while loading shared libraries: libncurses.so.5: cannot open shared obje
Fix: sudo apt-get install libncurses5

> sudo apt update #fail as no network
sudo systemctl restart docker

> openwrt package update and rebuild
#first add package
./scripts/feeds update mypackages
./scripts/feeds install -a -p mypackages
make menuconfig

#update mypackages/../Makefile
./scripts/feeds update mypackages
./scripts/feeds install -a -p mypackages

#change source code
make -j1 V=s package/libva_v4l2_request/prepare #remove directory inside the build_dir
make -j1 V=s package/libva_v4l2_request/clean   #remove directory inside the build_dir
make -j1 V=s package/libva_v4l2_request/compile #maybe copy code from source
                                        #make menuconfig sometimes also copy?


> create libva package to build in openwrt
https://openwrt.org/docs/guide-developer/packages

> debug libva compiling issue
- libva compiling fail
  libdrm dependency check fail
  add "pkg-config --list-all" to makefile/prepare in libva, and run make prepare
  so, problem come to how to make libdrm build and install well
- libdrm compiling report xorg-macros must be installed

- investigate xorg-macros installation issue
  autoreconf -d  
  comparing and it means miss of xutils-dev in openwrt, the host side??(missing ../usr/share/aclocal)
  so, 
  https://github.com/suwus/openwrt-feeds-xorg/tree/master/utils/xorg-macros

- compiling xorg-macros
  but, how to seperate compiling this, it's too long to compile all
  make package/libdrm_c/configure #can work
  make package/xorg-macros/configure#can work
  make V=s package/xorg-macros/compile
 
  find staging_dir/ -name "xorg-macro" # no need to install?
  
- build libdrm again
  make V=s package/libdrm/configure # work
  make V=s package/libdrm/compile # work

- build libva again
  make V=s package/libva/compile
  but, don't know how to install the libva. and make pkg-config know it
  2022/02/27
     * before the libva install issue. again, compiling libva can not find libdrm
       when I try to use pkg-config --list-all, it passed??
     * come to libva install issue
       1. why make -j1 V=s package/libva/install, no target?
       2. find a comparing
 
- 2022/02/28
  * compiling libva
    make -j1 V=s package/libva/prepare --- does nothing
    make -j1 V=s package/libva/configure --- does nothing
    make -j1 V=s package/libva/compile --- does nothing
    so, run
    make -j1 V=s package/libva/clean
    then, compile works
    ---- but content is empty??? some logic delete it???
         reason is, select as module in menuconfig???
         no,xxx, only mistake can break the building process to suspend rm of result


> error, build fail on make world, need select new configuration

> A building try
  
  make -j $(nproc) defconfig download clean 
  make -j1 V=s world  #use pipe to flush the default selection?

> compiling error on libva-v4l2-request
https://github.com/bootlin/libva-v4l2-request/issues/7
just disable the error section temporarily

> package stage code are missing
use blow setting to leave the stage code
```
define Package/sunxi_mali/install
	false
endef
```

> sdcard format
```
sdc      8:32   1  29.7G  0 disk 
??????sdc1   8:33   1  29.4G  0 part /media/...
$ ls /media/...
bin  boot  dev  etc  home  lib  lost+found  media  mnt  
opt  proc  root  run  sbin  selinux  srv  sys  tmp  usr  var
$ ls /media/.../boot/
boot.bmp  boot.scr             dtb               initrd.img-5.4.65-sunxi  
orangepi_first_run.txt.template  System.map-5.4.65-sunxi  uInitrd-5.4.65-sunxi  zImage
boot.cmd  config-5.4.65-sunxi  dtb-5.4.65-sunxi  orangepiEnv.txt          
overlay-user                     uInitrd         vmlinuz-5.4.65-sunxi

$ sudo fdisk -l /dev/sdc
Disk /dev/sdc: 29.7 GiB, 31914983424 bytes, 62333952 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x6efe98ba

Device     Boot Start      End  Sectors  Size Id Type
/dev/sdc1        8192 61710591 61702400 29.4G 83 Linux
```

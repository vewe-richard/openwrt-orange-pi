# openwrt-orange-pi
openwrt on orange pi, video decoder using mali 400

#### 1. create container to build openwrt
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
		#libdrm ===> no, build from source code
		?note: disable qosify when build mainline


?make defconfig 
# Build the firmware image
make -j $(nproc) defconfig download clean world
?make save defconfig
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
qemu-img resize n1.img 512M
./qemu.sh x86-h3
```

#### 4 enable cedrus
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

> 

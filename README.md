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

 
# Build the firmware image
make -j $(nproc) download clean world
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





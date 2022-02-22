#!/bin/bash
case $1 in
	x86-x86)
	echo "qianjiang" | sudo -S chmod 666 /dev/kvm
	qemu-system-x86_64  -smp 4 -enable-kvm -m 2G \
		-kernel openwrt/build_dir/target-x86_64_musl/linux-x86_64/linux-5.4.179/arch/x86/boot/bzImage \
		-append "root=/dev/sda rw console=ttyS0" \
		-netdev user,id=n1,ipv6=off,hostfwd=tcp::5555-:22 -device e1000,netdev=n1 \
		-hda /home/richard/work/2022/k516/openwrt/bin/targets/x86/64/1.img \
       		-nographic
	;;

	x86-h3)
	KERNEL_IMAGE_PATH=allwiner/build_dir/target-arm_cortex-a7+neon-vfpv4_musl_eabi/linux-sunxi_cortexa7/zImage 
	DTB_PATH=allwiner/build_dir/target-arm_cortex-a7+neon-vfpv4_musl_eabi/linux-sunxi_cortexa7/linux-5.4.179/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dtb

	/home/richard/work/knet/qemu/build/qemu-system-arm -M orangepi-pc \
		-nic user,hostfwd=tcp::5555-:22 -nographic \
		-kernel $KERNEL_IMAGE_PATH\
		-append 'console=ttyS0,115200 root=/dev/mmcblk0p2' \
		-dtb $DTB_PATH\
		-sd allwiner/bin/targets/sunxi/cortexa7/n1.img
	;;

	*)
	echo "Unknown command $1"
	;;
esac

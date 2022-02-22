#!/bin/bash
case $1 in
	create)
	docker run  -d -v $(pwd):/home/richard/share/ --name openwrt jiangjqian/openwrt
	;;

	build)
	docker build . -t jiangjqian/openwrt
	;;

	start)
	docker start openwrt
	;;

	stop)
	docker stop openwrt
	;;

	apt-install)
	sudo apt install build-essential ccache ecj fastjar file g++ gawk \
		gettext git java-propose-classpath libelf-dev libncurses5-dev \
		libncursesw5-dev libssl-dev python python2.7-dev python3 unzip wget \
		python3-distutils python3-setuptools python3-dev rsync subversion \
		swig time xsltproc zlib1g-dev
	;;

	*)
	docker exec -it openwrt /bin/bash
	;;
esac

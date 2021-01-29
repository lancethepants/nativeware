#!/bin/bash

set -e
set -x

export BASE=`pwd`

export PATH=~/.bin:$PATH

if [ ! -d /opt/brcm ]; then

	sudo mkdir -p /opt/brcm
	sudo chmod -R 777 /opt/brcm
fi

if [ ! -f /opt/brcm/usr/bin/arm-unknown-linux-uclibcgnueabi-gcc ]; then
	tar xvjf $BASE/buildroot-2012.05.tar.bz2 -C $BASE
	cd $BASE/buildroot-2012.05
	cp $BASE/defconfig .
	sed -i 's,JOBS,'`nproc`',g' ./defconfig
	make defconfig BR2_DEFCONFIG=defconfig
	make
fi

for link in addr2line ar as c++ cc c++filt cpp elfedit g++ gcc gccbug gcov gprof ld ld.bfd ldconfig ldd nm objcopy objdump ranlib readelf size strings strip
	do
		ln -sf arm-unknown-linux-uclibcgnueabi-$link /opt/brcm/usr/bin/arm-brcm-linux-uclibcgnueabi-$link
	done

#!/bin/bash

set -e
set -x

export BASE=`pwd`
SRC=$BASE/src
MAKE="make -j`nproc`"
PREFIX=/mmc/bin/gcc-4.5.3

mkdir -p $SRC/{binutils,gcc}

export PATH=~/.bin:/opt/brcm/usr/bin/:$PATH

############ ################################################################
# BINUTILS # ################################################################
############ ################################################################

cd $SRC/binutils

if [ ! -f .extracted ]; then
	rm -rf binutils-2.21.1 build
	tar xvjf $BASE/dl/binutils-2.21.1.tar.bz2 -C $SRC/binutils
	mkdir build
	touch .extracted
fi

cd build

if [ ! -f .configured ]; then
	LDFLAGS="-s -static --static" \
	../binutils-2.21.1/configure \
	--prefix=$PREFIX \
	--with-sysroot=$PREFIX \
	--with-build-sysroot=/opt/brcm/usr/arm-unknown-linux-uclibcgnueabi/sysroot \
	--host=arm-brcm-linux-uclibcgnueabi \
	--target=arm-brcm-linux-uclibcgnueabi \
	--disable-werror
	touch .configured
fi

if [ ! -f .built ]; then
	$MAKE
	touch .built
fi

if [ ! -f .installed ]; then
	make install DESTDIR=$BASE
	touch .installed
fi

####### #####################################################################
# GCC # #####################################################################
####### #####################################################################

cd $SRC/gcc

if [ ! -f .extracted ]; then
	rm -rf gcc-4.5.3.tar build
	tar xvjf $BASE/dl/gcc-4.5.3.tar.bz2 -C $SRC/gcc
	mkdir build
	touch .extracted
fi

cd build

if [ ! -f .configured ]; then
	LDFLAGS="-s -static --static" \
	../gcc-4.5.3/configure \
	--prefix=$PREFIX \
	--host=arm-brcm-linux-uclibcgnueabi \
	--target=arm-brcm-linux-uclibcgnueabi \
	--enable-languages=c,c++ \
	--with-sysroot=$PREFIX \
	--with-build-sysroot=/opt/brcm/usr/arm-unknown-linux-uclibcgnueabi/sysroot \
	--disable-__cxa_atexit \
	--enable-target-optspace \
	--disable-libgomp \
	--with-gnu-ld \
	--disable-libssp \
	--disable-multilib \
	--enable-tls \
	--enable-shared \
	--enable-threads \
	--disable-decimal-float \
	--with-float=soft \
	--with-abi=aapcs-linux \
	--with-arch=armv7-a \
	--with-tune=cortex-a9
	touch .configured
fi

if [ ! -f .built ]; then
	$MAKE
	touch .built
fi

if [ ! -f .installed ]; then
	make install DESTDIR=$BASE
	touch .installed
fi

cd $BASE$PREFIX/bin

for link in addr2line ar as c++ c++filt cpp elfedit g++ gcc gccbug gcov gprof ld ld.bfd nm objcopy objdump ranlib readelf size strings strip
	do
		mv $link arm-brcm-linux-uclibcgnueabi-$link
	done

cd $BASE/mmc
cp -r /opt/brcm/usr/arm-unknown-linux-uclibcgnueabi/sysroot/* $BASE$PREFIX
tar zcvf $BASE/gcc-4.5.3.tar.gz bin

Nativeware
==========

Nativeware is a native toolchain for tomato-arm firmware supported routers that can compile out-of-tree kernel modules. One example of its capability is zfs-0.8.6 (with some patching). In addition to the toolchain you will need a copy of the pre-compiled kernel source tree. (Fresh)Tomato has seen enough kernel activity in 2020 that modules compiled earlier in the year may no longer work with the latest releases. So make sure that you have a recent version of the kernel.

Nativeware can also compile userspace binaries against the firmware's native system c-library. Compiling only against the C standard library is supported. (Fresh)Tomato doesn't include every library from the C standard library either (ie libresolv). If your program has any other dependencies you will have to compile those yourself. I recommend using Tomatoware for anything more than the simplest of programs.

This toolchain only provides you with a compiler and linker. You will likely need additional develment tools like `make`. I use Tomatoware to supply these tools.

Using
==========
Download and extract the the toolchain.  
https://files.lancethepants.com/Nativeware/

tar zxvf gcc-4.5.3.tar.gz -C /mmc/  
Add `/mmc/bin/gcc-4.5.3/bin` to you PATH  
Extract pre-compiled kernel source tree.  

Compiling Nativeware
==========

Nativeware is compiled on Debian 6 "Squeeze". You will need DVDs 1 & 2 to install Debian 6 and all the necessary packages. I didn't keep track, but you can start off with `build-essential` and go from there.
Run `make`

# NuttX Emulation with QEMU

This repo documents my progress in emulating NuttX using QEMU and trying 
to run wasm modules and functions from inside a 'native' C custom app.

## Prerequisites

sudo apt-get install \ 
gcc-arm-none-eabi \ 
qemu-system-arm
					 

## Setting up the environment

Clone the repo and build nuttx:

```
git clone https://github.com/loloRvz/nuttx-emulation.git

cd nuttx-env/nuttx
make distclean
./tools/configure.sh sabre-6quad:wamr
make #(this will lead to an error concerning wamr)
patch -p0 -d ../.. < ../../patches/p2-wamr.patch
make
```

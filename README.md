# NuttX Emulation with QEMU

This repo documents my progress in emulating NuttX using QEMU and trying 
to run wasm modules and functions from inside a 'native' C custom app.

## Prerequisites

To build NuttX and run QEMU:
```
sudo apt-get install gcc-arm-none-eabi qemu-system-arm
```				 

To build WASM modules, follow the following tutorial:

https://github.com/bytecodealliance/wasm-micro-runtime/blob/main/doc/build_wasm_app.md

## Setting up the environment

Clone the repo to your desired location (we'll be working in this directory) 
and build nuttx:

```
git clone https://github.com/loloRvz/nuttx-emulation.git

cd nuttx-env/nuttx
make distclean
./tools/configure.sh sabre-6quad:wamr
make #(this will lead to an error concerning wamr in nuttx)
patch -p0 -d ../.. < ../../patches/p2-wamr.patch
make
```

Run qemu: 

```
qemu-system-arm -machine sabrelite -kernel nuttx -nographic
```

You should now have access to the NuttX shell (nsh>)! To exit qemu press 
'ctrl^a', followed by 'x'.

## Running WASM Modules on NuttX inside QEMU

We first have to be able to share files between host and guest on QEMU. 
For this, we'll be using TFTP. Set up a TFTP server using the following 
tutorial:

https://linuxhint.com/install_tftp_server_ubuntu/


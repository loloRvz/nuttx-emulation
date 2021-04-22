# NuttX Emulation with QEMU

This repo documents my progress in emulating NuttX using QEMU and trying 
to run wasm modules and functions from inside a 'native' C custom app.

## Prerequisites

To build NuttX and run QEMU:
```
sudo apt-get install gcc-arm-none-eabi qemu-system-arm
```				 

If you'd like to create or modify wasm modules and apps you'll need to:
* Clone the [WAMR](https://github.com/bytecodealliance/wasm-micro-runtime)
repo and define its root as ```WAMR_DIR``` in your environment variables.
* Be able to [build WASM applications](https://github.com/bytecodealliance/wasm-micro-runtime/blob/main/doc/build_wasm_app.md):
	* Install [wasi-sdk](https://github.com/WebAssembly/wasi-sdk/releases)
and extracting the archive to default path ```/opt/wasi-sdk```.
	* Install [wamrc](https://github.com/bytecodealliance/wasm-micro-runtime#build-wamrc-aot-compiler),
the AoT compiler and add it to you PATH.


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

Now that we can share files to QEMU let's build an example and upload it 
to the server:

```
cd nuttx-emulation/wasm-example/module
```

Change the ip address in "build.sh" and run the script.

```
./build.sh
```

Now run QEMU, get the module and run it:

```
cd ../../nuttx-env/nuttx
qemu-system-arm -machine sabrelite -kernel nuttx -nographic
nsh> cd tmp
nsh> get -h 192.168.0.224 module.aot
nsh> myapp
```

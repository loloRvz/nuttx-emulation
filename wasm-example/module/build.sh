#!/bin/bash

/opt/wasi-sdk/bin/clang \
	-o module.wasm module.c \
	-O3 -z stack-size=8192 -nostdlib \
	-Wl,--initial-memory=65536 \
    -Wl,--strip-all,--no-entry,--allow-undefined \
    -Wl,--export=sum \
    -Wl,--export=callcallback \
    -Wl,--import-memory 

wamrc --target=thumbv7a \
	  -o mod.aot module.wasm
	  
wamrc -o mod1.aot module.wasm

tftp 192.168.0.224 -c put module.wasm
tftp 192.168.0.224 -c put mod.aot


#wat2wasm -o sum.wasm sum.wat

#wamrc --target=thumbv7a \
#	   --cpu=cortex-a9 \
#	   --target-abi=gnueabihf \
#	   -o sum.aot sum.wasm
	  
#tftp 192.168.0.224 -c put sum.wasm
#tftp 192.168.0.224 -c put sum.aot


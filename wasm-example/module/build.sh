#!/bin/bash

/opt/wasi-sdk/bin/clang \
	-o mod.wasm module.c \
	-O3 -z stack-size=8192 -nostdlib \
	-Wl,--initial-memory=65536 \
    -Wl,--strip-all,--no-entry \
    -Wl,--export=sum \
    -Wl,--export=callfunc 

wamrc --target=thumbv7a \
	  --cpu=cortex-a9 \
	  --target-abi=gnueabihf \
	  -o mod.aot mod.wasm
	  
#wamrc -o mod1.aot mod.wasm

tftp 192.168.0.224 -c put mod.wasm
tftp 192.168.0.224 -c put mod.aot


wat2wasm -o sum.wasm sum.wat

wamrc --target=thumbv7a \
	  -o sum.aot sum.wasm
	  
tftp 192.168.0.224 -c put sum.wasm
tftp 192.168.0.224 -c put sum.aot



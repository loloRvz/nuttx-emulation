#!/bin/bash

/opt/wasi-sdk/bin/clang \
	-o module.wasm module.c \
	-O3 -z stack-size=8192 -nostdlib \
	-Wl,--initial-memory=65536 \
    -Wl,--strip-all,--no-entry \
    -Wl,--export=sum \
    -Wl,--export=callcallback \
    -Wl,--import-memory 

wamrc --target=thumbv7a \
	  --cpu=cortex-a9 \
	  --target-abi=gnu \
	  --disable-simd \
	  -o mod.aot module.wasm
	  
tftp 192.168.0.224 -c put module.wasm
tftp 192.168.0.224 -c put mod.aot


wat2wasm -o sum.wasm sum.wat

wamrc --target=thumbv7a \
	  --cpu=cortex-a9 \
	  --target-abi=eabi \
	  -o sum.aot sum.wasm
	  
tftp 192.168.0.224 -c put sum.wasm
tftp 192.168.0.224 -c put sum.aot


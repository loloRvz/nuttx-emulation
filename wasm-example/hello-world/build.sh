#!/bin/bash

/opt/wasi-sdk/bin/clang \
	-o hello.wasm hello.c \
	-O3 -z stack-size=8192 -nostdlib \
	-Wl,--initial-memory=65536 \
    -Wl,--strip-all,--no-entry,--allow-undefined \
    -Wl,--export=main,--export=__main_argc_argv 

wamrc --target=thumbv7a \
	  --cpu=cortex-a9 \
	  --cpu-features=armv7-a \
	  -o hello.aot hello.wasm
	  
wamrc -o hello1.aot hello.wasm

tftp 192.168.0.224 -c put hello.wasm
tftp 192.168.0.224 -c put hello.aot


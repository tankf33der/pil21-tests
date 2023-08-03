# ADDRESS

```
-CC = clang
+CC = clang -fsanitize=address

=================================================================
==2968==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 816 byte(s) in 13 object(s) allocated from:
    #0 0x4c22c2 in malloc (/root/pil21/bin/picolisp+0x4c22c2) (BuildId: 2ada955cbdd61efbf5de9d7d5e73263c56d28ae5)
    #1 0x53ddf4 in ffiPrep (/root/pil21/bin/picolisp+0x53ddf4) (BuildId: 2ada955cbdd61efbf5de9d7d5e73263c56d28ae5)

Direct leak of 4 byte(s) in 1 object(s) allocated from:
    #0 0x4ac0a1 in strdup (/root/pil21/bin/picolisp+0x4ac0a1) (BuildId: 2ada955cbdd61efbf5de9d7d5e73263c56d28ae5)
    #1 0x7efedb85c055  (/lib64/libffi.so.8+0x9055) (BuildId: 308041eea4a8d89d9265d3c24b7261dfbe44a61e)
    #2 0x7efed950061f  (<unknown module>)

SUMMARY: AddressSanitizer: 820 byte(s) leaked in 14 allocation(s).


$ ASAN_OPTIONS=detect_leaks=0 && ../pil @lib/test.l +
OK
:
```
# MEMORY
```
+CC = clang -fsanitize=memory -fno-omit-frame-pointer -fsanitize-memory-track-origins

$ ../pil @lib/test.l +
==3920==WARNING: MemorySanitizer: use-of-uninitialized-value
    #0 0x4f0b4b in ffiPrep (/root/pil21/bin/picolisp+0x4f0b4b) (BuildId: d016cb30d1dd862715a88d3ba0585e3bc7e62db7)
    #1 0x4df286 in ffi (/root/pil21/bin/picolisp+0x4df286) (BuildId: d016cb30d1dd862715a88d3ba0585e3bc7e62db7)
    #2 0x4d37cf in _nat (/root/pil21/bin/picolisp+0x4d37cf) (BuildId: d016cb30d1dd862715a88d3ba0585e3bc7e62db7)
    #3 0x4c79cb in _let (/root/pil21/bin/picolisp+0x4c79cb) (BuildId: d016cb30d1dd862715a88d3ba0585e3bc7e62db7)
    #4 0x4d7010 in evExpr (/root/pil21/bin/picolisp+0x4d7010) (BuildId: d016cb30d1dd862715a88d3ba0585e3bc7e62db7)
    #5 0x4b538b in _setq (/root/pil21/bin/picolisp+0x4b538b) (BuildId: d016cb30d1dd862715a88d3ba0585e3bc7e62db7)
    #6 0x4d10ad in _sigio (/root/pil21/bin/picolisp+0x4d10ad) (BuildId: d016cb30d1dd862715a88d3ba0585e3bc7e62db7)
    #7 0x4c5fd6 in _unless (/root/pil21/bin/picolisp+0x4c5fd6) (BuildId: d016cb30d1dd862715a88d3ba0585e3bc7e62db7)
    #8 0x4d8d62 in repl (/root/pil21/bin/picolisp+0x4d8d62) (BuildId: d016cb30d1dd862715a88d3ba0585e3bc7e62db7)
    #9 0x4bd93a in _load (/root/pil21/bin/picolisp+0x4bd93a) (BuildId: d016cb30d1dd862715a88d3ba0585e3bc7e62db7)
    #10 0x4d8d62 in repl (/root/pil21/bin/picolisp+0x4d8d62) (BuildId: d016cb30d1dd862715a88d3ba0585e3bc7e62db7)
    #11 0x4ee007 in main (/root/pil21/bin/picolisp+0x4ee007) (BuildId: d016cb30d1dd862715a88d3ba0585e3bc7e62db7)
    #12 0x7fe46ee28149 in __libc_start_call_main (/lib64/libc.so.6+0x28149) (BuildId: 27ff8f6f7d3d6c681f099f2f52d5ffcdfd351c3e)
    #13 0x7fe46ee2820a in __libc_start_main@GLIBC_2.2.5 (/lib64/libc.so.6+0x2820a) (BuildId: 27ff8f6f7d3d6c681f099f2f52d5ffcdfd351c3e)
    #14 0x4275b4 in _start (/root/pil21/bin/picolisp+0x4275b4) (BuildId: d016cb30d1dd862715a88d3ba0585e3bc7e62db7)

SUMMARY: MemorySanitizer: use-of-uninitialized-value (/root/pil21/bin/picolisp+0x4f0b4b) (BuildId: d016cb30d1dd862715a88d3ba0585e3bc7e62db7) in ffiPrep
Exiting

```

# UNDEFINED
```
+CC = clang -fsanitize=undefined

$ ../pil @lib/test.l +
OK
```

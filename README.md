WIP: Unofficial test code for testing PicoLisp LLVM implementation named
[pil21](https://git.envs.net/mpech/pil21/).

After calling [tests.l](tests.l) file should return all "OKs".

You must take care for stack depth, 16Kb is ok:
```
$ ulimit -s
16384
```

Happy coding.

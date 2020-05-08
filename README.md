# bitfetch - simple cli system information tool written in C

```shell
    $ make help                     # show help
    $ make CC=clang bitfetch        # build bitfetch using clang as a C compiler
    $ sudo make install             # install bitfetch to /usr/local/bin (build it before installing)
    $ make bitfetch XINERAMA=NO     # build bitfetch without Xinerama (multimonitor) support
    $ make bitfetch X=NO            # build bitfetch without X support
```

```shell
    $ bitfetch -h # view help message
```


# ATTENTION

if you wanna create an issue for me to add your distro support please paste `cat /etc/os-release` output.

![screenshot](./bitfetch.png)

# Logo sources:
+ [ufetch](https://gitlab.com/jschx/ufetch)

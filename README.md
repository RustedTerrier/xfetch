# Xfetch is a fork of [bitfetch](https://gitlab.com/bit9tream/bitfetch)

```shell
    $ make CC=clang xfetch        # build xfetch using clang as a C compiler
    $ sudo make install             # install xfetch to /usr/local/bin (build it before installing)
    $ make xfetch XINERAMA=NO     # build xfetch without Xinerama (multimonitor) support
    $ make xfetch X=NO            # build xfetch without X support
    $ make xfetch PKG=NO          # xfetch won't show number of installed packages
```

```shell
    $ xfetch -h # view help message
```

# For CRUX, Artix and other distro without /etc/os-release file users

```shell
    # because of youre distro doesn't have /etc/os-release file you need to manually specify youre distro ID
    # artix for Artix linux
    # crux for CRUX linux
    $ make xfetch ID=crux
    $ make xfetch ID=artix
    $ make xtfetch ID=asd # if you provide not supported ID xfetch will be build with generic logo.
```

## Currently supported distros:

+ Arch Linux
+ ArtiX Linux
+ Ataraxia Linux
+ CRUX
+ Debian
+ Elementary OS
+ Fedora Linux
+ Gentoo Linux
+ Kiss Linux
+ Linuxmint
+ Manjaro Linux
+ Opensuse-leap
+ Opensuse-tumbleweed
+ Solus
+ Ubuntu Linux
+ Void Linux

# Dependencies
+ xlib
+ xinerama

# Logo sources:
+ [ufetch](https://gitlab.com/jschx/ufetch)

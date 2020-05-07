# jetson-tk1-buildroot
Buildroot configs for Jetson TK1 on mainline kernel

## Build

1. Pull this repo
```
git clone https://github.com/yeyus/jetson-tk1-buildroot.git
```

2. Download and extract buildroot
```
wget https://buildroot.org/downloads/buildroot-2020.02.1.tar.gz
tar xfz buildroot-2020.02.1.tar.gz
```

3. Customize!
```
export BR2_EXTERNAL=/path/to/jetson-tk1-buildroot
cd buildroot-2020.02.1
make jetson-tk1_defconfig
```

4. Build
```
make
```

**TODO**

## Configure TFTP Boot

**TODO**

## Configure NFS root

**TODO**

## Install U-Boot

The default version of U-Boot included with the Jetson TK1 board won't be able to run modern linux kernels, we need to compile a custom U-Boot for our board and flash it using NVidia tools.

**TODO**

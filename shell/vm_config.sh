#!/bin/bash

# ============================================================
# VM Configuration File for vmstart, vmmutil, vmctrl
# Centralizes common VM configuration and defaults
# ============================================================

# -------- COLOR DEFINITIONS (共用) --------
RED_COLOR='\E[1;31m'         # Red
GREEN_COLOR='\E[1;32m'       # Green
YELLOW_COLOR='\E[1;33m'      # Yellow
BLUE_COLOR='\E[1;34m'        # Blue
CYAN_COLOR='\E[1;36m'        # Cyan
PINK_COLOR='\E[1;35m'        # Pink
RES='\E[0m'                  # Reset

# -------- NETWORK CONFIGURATION (共用) --------
ipprefix="192.168.22."
qemu_prefix="qemu-"
tailipmin=120
tailipmax=125

# -------- DEFAULT VM PARAMETERS (共用) --------
rtfstype="_ext4"             # rootfs type: _ext4, _xfs
arch="_aarch64"              # cpu arch: _x86, _aarch64
mem="2G"                     # default memory
cpus=4                       # default cpu numbers
disk_size="1G"               # default disk size
disks="scsi-mq"              # default disk type
port_range=5555              # port range base

# -------- DIRECTORY PATHS (共用) --------
CPATH=`pwd`
WORKPATH=~/work/vm
vm_workdir=$WORKPATH/image/vm
rootfspath=$vm_workdir
arch_image=$WORKPATH/image/Image${arch}
user_image="~/gitwork/linux-next/arch/arm64/boot/Image"
src_rootfs=$WORKPATH/image/rootfs${arch}${rtfstype}.gz
fs_path=$vm_workdir/fspath
ksdir=$WORKPATH/image/ksnapshot
LOG_DIR=$WORKPATH/log/
diskpath=/tmp/ll_disk
socketx=/tmp/ll_socket
host_share=$HOME/hostshare

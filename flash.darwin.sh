#!/bin/sh

# params:
#  $1: flash-tool path
#  $2: drive path
#  $3: image filepath
#  $4: wifi config file

LOGFILE="$1/flash-tool.log"

dt=$(date '+%d/%m/%Y %H:%M')
echo "START $dt" >> $LOGFILE
echo "params=$1 $2 $3 $4" >> $LOGFILE

# flash drive
"$1/balena" "$3" --drive "$2" --yes --unsupported
ret=$?
echo "balena-cli returncode=$ret" >> $LOGFILE
if [ $ret != 0 ]
then
    exit $ret
fi

# copy default wifi config
if [ ! -z "$4" ]
then
    # search root partition
    partition=`/usr/sbin/diskutil list | grep boot | awk '{print $(NF)}'`
    echo "partition=$partition" >> $LOGFILE

    # mount first drive partition (should be root one in fat32)
    /bin/mkdir /tmp/cleep_root
    /sbin/mount -t msdos /dev/$partition /tmp/cleep_root

    # then copy file
    echo "Copy $4 file to /tmp/cleep_root/cleep-network.conf" >> $LOGFILE
    /bin/cp -f "$4" /tmp/cleep_root/cleep-network.conf >> $LOGFILE

    # and umount/clean properly
    /bin/sync
    /sbin/umount -f /tmp/cleep_root
    /bin/rmdir /tmp/cleep_root
fi

dt=$(date '+%d/%m/%Y %H:%M')
echo "END $dt" >> $LOGFILE


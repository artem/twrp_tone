#!/sbin/sh
# REMOVE ME ASAP

sleep 3

if [ -b /dev/block/dm-0 ]; then
  DEVICE=/dev/block/dm-0
else
  DEVICE=/dev/block/bootdevice/by-name/userdata
fi

mount -o ro /system
if [ -f /system/bin/toolbox ]; then
  PATH=/system/bin:/sbin
  LD_LIBRARY_PATH=/system/lib64:/sbin
  if [ "$(tune2fs -l $DEVICE | grep features | tail -c 6)" = "quota" ]; then
    e2fsck -E journal_only $DEVICE
    tune2fs -O ^quota $DEVICE
  fi
fi

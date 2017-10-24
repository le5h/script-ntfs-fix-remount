#!/bin/bash
# NTFS partition auto fix and remount

if [ -z $1 ]
  then
    echo -n "Enter partition name: "
    read disk
  else
    disk=$1 # first parameter
fi

user=$USER # username
label=$(ls -l /dev/disk/by-label | grep $disk)
label=($label)
label=${label[8]} # label is 9th item
folder="/run/media/"$user"/"$label # arch specific

sudo umount /dev/$disk
sudo ntfsfix /dev/$disk
sudo mkdir $folder
sudo ntfs-3g /dev/$disk $folder # mounts

echo Done.

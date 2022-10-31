#!/bin/sh

# using techniques from https://wiki.archlinux.org/index.php/benchmarking
# modified to copy a file to /tmp - hopefully fast - from /dev/urandom
# to avoid false readings due to the compressability of data from /dev/zero

count=4096


echo Creating test file
dd bs=1M count=$count if=/dev/urandom of=/tmp/test.tmp conv=fdatasync
echo reading back test file
sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'
dd bs=1M count=$count if=/tmp/test.tmp of=/dev/null

if [ -e test.tmp ]
then
  echo "test.tmp exists and would be clobbered"
  exit 1
fi

echo write performance
dd bs=1M count=$count if=/tmp/test.tmp of=test.tmp conv=fdatasync
dd bs=1M count=$count if=/tmp/test.tmp of=test.tmp conv=fdatasync


echo read performance
# drop caches
sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'
dd if=test.tmp of=/dev/null bs=1M count=$count
sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'
dd if=test.tmp of=/dev/null bs=1M count=$count
rm test.tmp


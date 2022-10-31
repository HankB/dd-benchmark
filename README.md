# dd-benchmark

Script to perform a dd benchmark.

At present only tested on Linux.

## Features

* Uses random data for the test file to prevent wildly optimistic results if the filesystem supports compression and `/dev/zero` is used as the data source.
* Attempts to eliminate having the source of the data (e.g. a slow HDD when benchmarking a fast SSD) dominate the result by putting the test data in `/tmp` which is ideally stored in RAM (e.g. `tmpfs`).
* Drops cache before reading back the test file (which requires root.) This probably doesn't drop the ZFS caches.

## Example output

```text
hbarta@olive:~$ time -p dd-benchmark.sh
Creating test file
4096+0 records in
4096+0 records out
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 11.8762 s, 362 MB/s
reading back test file
4096+0 records in
4096+0 records out
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 0.573235 s, 7.5 GB/s
write performance
4096+0 records in
4096+0 records out
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 5.8197 s, 738 MB/s
4096+0 records in
4096+0 records out
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 5.62669 s, 763 MB/s
read performance
4096+0 records in
4096+0 records out
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 2.84171 s, 1.5 GB/s
4096+0 records in
4096+0 records out
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 2.81245 s, 1.5 GB/s
real 31.95
user 0.07
sys 20.87
hbarta@olive:~$ 
```

## contributing

Feel free to suggest improvements, implement command line arguments and (perhaps most of all) point out flaws. And typos.

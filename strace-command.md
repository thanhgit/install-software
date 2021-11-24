# Strace command

## 1. Trace linux command system calls
```bash
strace df -h
```
```text
execve("/bin/df", ["df", "-h"], 0x7ffef5afa388 /* 125 vars */) = 0
brk(NULL)                               = 0x55903f6e1000
arch_prctl(0x3001 /* ARCH_??? */, 0x7ffcad4a8460) = -1 EINVAL (Invalid argument)
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/home/thanhuit/.gvm/pkgsets/go1.16/global/overlay/lib/tls/haswell/x86_64/libc.so.6", O_RDONLY|O_CLOEXEC) = -1 ENOENT 
...
write(1, "Filesystem      Size  Used Avail"..., 49Filesystem      Size  Used Avail Use% Mounted on
) = 49
write(1, "udev            7,7G     0  7,7G"..., 43udev            7,7G     0  7,7G   0% /dev
) = 43
...
close(1)                                = 0
close(2)                                = 0
exit_group(0)                           = ?
+++ exited with 0 +++
```
## 2. Trace linux process PID
- ### If a process is already running, you can trace it by simply passsing its PID
```bash
strace -p 36157
```
## 3. Get summary of linux process
```bash
strace -c -p 36157
```
```text
strace: Process 36157 attached

% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 43,14    0,029455          10      2928           poll
  ...
  0,00    0,000002           1         2           lseek
  0,00    0,000002           2         1         1 rt_sigreturn
  0,00    0,000002           0         4           fcntl
  ...
  0,00    0,000000           0         1         1 kill
  0,00    0,000000           0         2           uname
  0,00    0,000000           0         1         1 mkdir
------ ----------- ----------- --------- --------- ----------------
100.00    0,068277                 10101      4249 total
```
## 4. Print Instruction Pointer During System Call
```bash
sudo strace -i df -h
```
## 5. Show Time of Day For Each Trace Output Line
```bash
sudo strace -t df -h
```
## 6. Print Command Time Spent in System Calls
```bash
sudo strace -T df -h
```
## 7. Trace Only Specific System Calls
```bash
sudo strace -e trace=write df -h
```
## 8. Trace System Calls Based on a Certain Condition
```bash
sudo strace -q -e trace=process df -h
```
```bash
sudo strace -q  -e trace=file df -h
```
```bash
sudo strace -q -e trace=memory df -h
```
```bash
sudo strace -e trace=network df -h
```
```bash
sudo strace -e trace=signal df -h
```
## 9. Redirect Trace Output to File
```bash
sudo strace -o df_debug.txt df -h
```
## 10. Show Some Debugging Output of Strace
```bash
strace -d df -h
```
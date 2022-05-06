# Incident Response
- ### `Detecting any intrusion` in your system is a very important step towards Incident response
- ### là quá trình phát hiện và xử lý sự cố an ninh, tấn công mạng hoặc vi phạm dữ liệu, khắc phục mối đe dọa đó và phục hồi sau hậu quả.

### Kế hoạch là rất quan trọng trước khi bắt đầu nỗ lực ứng phó với bất kỳ sự cố nào
- ### Trọng tâm của một kế hoạch ứng phó sự cố là playbook – ‘một cuốn sổ tay’ - Nó sẽ nêu chi tiết các nhiệm vụ và hành động mà tổ chức của bạn nên thực hiện để đối phó với các sự cố khác nhau

### The `security incidents` that could be overcome by:
- ### By checking the running processes
- ### By understanding the contents of physical memory
- ### By gathering details on the hostname, IP address, OS, ...
- ### Gathering information on system services
- ### By identifying all the known and unknown users logged onto the system
- ### By inspecting network connections, open ports and any network activity
- ### By determining the various files present (scan virus)

## `Linux`
### `User Accounts`
- ### It is very important to investigate the user account’s activity => understand the logged-in users, the existing users, usual or unusual logins, failed login attempts, permissions, access by sudo, ...
```bash
/etc/passwd
```
- ### Check user info with `Setuid` option
```bash
passwd -S thanhuit
```
---
```text
thanhuit P 02/24/2021 0 99999 7 -1
```
- ### To Identify and display whether an attacker created any temporary user to perform an attack
```bash
find / -nouser -print
```
---
```text
find: ‘/run/user/1000/doc’: Permission denied
find: ‘/run/user/1000/gvfs’: Permission denied
/var/cache/private/fwupdmgr
/var/cache/private/fwupdmgr/fwupd
/var/cache/private/fwupdmgr/fwupd/lvfs-metadata.xml.gz.asc
/var/cache/private/fwupdmgr/fwupd/lvfs-metadata.xml.gz
/var/lib/dpkg/info/vagrant.md5sums
/var/lib/docker/volumes/ebb375b0c9cd7d628a8a342ce22d5a416d22a72fc3605895d4741180e7d5d512/_data/k3s/agent/containerd/io.containerd.snapshotter.v1.overlayfs/snapshots/11/fs/usr/local/bin/k9s
...
```

- ### View the encrypted password, details about the passwords
```bash
cat /etc/shadow
```

- ### To displays the information of the groups used by the user.
```bash
cat /etc/group
```

- ### To view information about user and group privileges to be displayed
```bash
cat /etc/sudoers
```

- ### To view the reports of the most recent login of a particular user or all the users
```bash
lastlog
```

- ### To identify any curious SSH & telnet logins or authentication in the system
```bash
tail -f /var/log/auth.log
```

- ### To view the history of commands that the user has typed
```bash
history | less
```

### `System Resources`
- ### It tell you a lot about system logging information, uptime of the system, the memory space and utilisation of the system, ...

- ### How long the server has been running for, the current time in the system, how many users have currently logged on, and the load averages of the system
```bash
uptime
```
---
```text
 00:32:39 up  6:05,  1 user,  load average: 3,78, 3,89, 3,80
```

- ### To view the memory utilisation
```bash
free -h
```
---
```text
              total        used        free      shared  buff/cache   available
Mem:           15Gi       5,4Gi       289Mi       943Mi       9,7Gi       8,8Gi
Swap:          15Gi        26Mi        15Gi
```

- ### To check the detail information of the ram, memory space available, buffers and swap on the system
```bash
cat /proc/meminfo
```
```bash
lsmem
```
---
```text
RANGE                                  SIZE  STATE REMOVABLE  BLOCK
0x0000000000000000-0x0000000097ffffff  2,4G online       yes   0-18
0x0000000100000000-0x000000045fffffff 13,5G online       yes 32-139

Memory block size:       128M
Total online memory:    15,9G
Total offline memory:      0B
```

- ### To check if there is an unknown mount on your system, to check the mount present on your system
```bash
cat /proc/mounts
```

### `Processes`
- ### To view the programs that are currently running in the system, if they necessary to run and if they should be running, and usage of the CPU usage by these processes, ...
```bash
htop
```

- ### To see the process status of your Linux and the currently running processes system and the PID
```bash
ps aux
```

- ### To display more details on a particular process
```bash
lsof -p [pid]
```
---
```text
lsof: WARNING: can't stat() fuse.gvfsd-fuse file system /run/user/1000/gvfs
      Output information may be incomplete.
lsof: WARNING: can't stat() fuse file system /run/user/1000/doc
      Output information may be incomplete.
COMMAND      PID USER   FD      TYPE             DEVICE SIZE/OFF    NODE NAME
systemd-u 212125 root  cwd       DIR                8,2     4096       2 /
systemd-u 212125 root  rtd       DIR                8,2     4096       2 /
systemd-u 212125 root  txt       REG                8,2   744008 6566454 /lib/systemd/systemd-udevd
systemd-u 212125 root  mem       REG                8,2    51832 6585017 /lib/x86_64-linux-gnu/libnss_files-2.31.so
...
systemd-u 212125 root    0r      CHR                1,3      0t0       6 /dev/null
systemd-u 212125 root    1u     unix 0xffff913947c58c00      0t0   21615 type=STREAM
systemd-u 212125 root    2u     unix 0xffff913947c58c00      0t0   21615 type=STREAM
systemd-u 212125 root    3u  a_inode               0,14        0   12442 [eventpoll]
...
systemd-u 212125 root   12r      REG                8,2 10440127 6567292 /lib/udev/hwdb.bin
systemd-u 212125 root   13u  a_inode               0,14        0   12442 [timerfd]
systemd-u 212125 root   14u  netlink                         0t0 7206875 KOBJECT_UEVENT
```

### `Services`
- ### Linux system can be classified into system and network services
    - ### `System services` include the status of services, cron, ...
    - ### `Network services` include file transfer, DNS, firewalls, ...

- ### To find any abnormally running services
```bash
service –-status-all
```
```bash
systemctl list-units
```

- ### Looking for any suspicious scheduled tasks and jobs
```bash
cat /etc/crontab
```

- ### To resolve DNS configuration issues
```bash
more /etc/resolv.conf
```

- ### To check file that translates hostnames or domain names to IP addresses
```bash
more /etc/hosts
```

- ### To check and manage the IPv4 packet filtering and NAT
```bash
iptables -L -n
```

### `Files`
- ### You should be aware of any abnormal-looking files in your system

- ### To identify any overly large files in your system and their permissions with their destination
```bash
find /home/ -type f -size +512k -exec ls -lh {} \;
```

- ### To see an anomalous file that has been present in the system for 2 days
```bash
find / -mtime -2 -ls
```

### `Network Settings`
- ### It is extremely vital to identify the overall picture of a system network and its health
```bash
ifconfig -a
```

- ### To list all the processes that are listening to ports with their PID
```bash
lsof -i
```

- ### To display all the listening ports
```bash
netstat -nap
```

- ### To display the system ARP cache
```bash
arp -a
```
---
```text
_gateway (192.168.1.1) at a4:81:7a:18:0a:68 [ether] on wlp2s0
lab.local (192.168.1.20) at <incomplete> on wlp2s0
? (172.21.0.2) at 02:42:ac:15:00:02 [ether] on br-2f4f032487b2
lab1.local (192.168.1.11) at <incomplete> on wlp2s0
```

- ### The `$PATH` displays a list of directories that tells the shell about executable files
```bash
echo $PATH
```
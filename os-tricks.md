# OS tricks

### Troubleshooting with `journalctl`
```bash
journalctl -n 50 -p err 
```
```bash
journalctl -f
```
```bash
journalctl _PID=6610
```

### Background Services
- ### To list the available categories of daemons
```bash
systemctl -t help
```
```text
Available unit types:
service
socket
target
device
mount
automount
swap
timer
path
slice
scope
```
- ### To see the system's processes
```bash
systemctl list-units --type=service
```
```bash
systemctl list-units --type=socket --state=LOAD
```
```bash
systemctl list-units --type=path --all
```
```bash
systemctl list-unit-files
```

### List the current active process
```bash
ps -auxc
```
---
```text
...
polkitd      736  0.0  0.2 1765416 23388 ?       Ssl  Mar23   0:40 polkitd
root         738  0.0  0.0  79124  6912 ?        Ss   Mar23   1:11 systemd-machine
root         741  0.0  0.0 124892  4656 ?        Ssl  Mar23   0:07 irqbalance
root         743  0.0  0.1 428900 14688 ?        Ss   Mar23   1:53 sssd
root         756  0.1  0.5 1494556 44956 ?       Ssl  Mar23   8:45 snapd
root         778  0.0  0.0 236288  2696 ?        S    Mar23   0:07 ksmtuned
chrony       812  0.0  0.0 151156  4576 ?        S    Mar23   0:01 chronyd
root         923  0.2  0.2 602824 20496 ?        Ssl  Mar23  14:32 NetworkManager
root         925  0.0  0.1 437480 15568 ?        S    Mar23   0:20 sssd_be
root         933  0.0  0.5 439148 41024 ?        S    Mar23   0:47 sssd_nss
root         942  0.0  0.0  94476  7608 ?        Ss   Mar23   0:06 sshd
root         944  0.5  0.5 790976 44568 ?        Ssl  Mar23  42:41 tuned
root         949  0.4  0.8 1649280 64204 ?       Ssl  Mar23  34:32 containerd
root         952  0.0  0.0 311568  3772 ?        Ssl  Mar23   0:00 gssproxy
root         961  0.0  0.0  92632  7632 ?        Ss   Mar23   1:17 systemd-logind
root         999  0.0  0.3 520788 25752 ?        Ssl  Mar23   2:35 rsyslogd
root        1015  0.0  0.0 246716  3596 ?        Ss   Mar23   0:00 crond
root        1022  0.0  0.0 226348  1740 tty1     Ss+  Mar23   0:00 agetty
root        1024  0.0  0.0 225988  2180 ttyS0    Ss+  Mar23   0:00 agetty
root        1331  0.0  0.0 132344  2380 ?        Ss   Mar23   0:00 nginx
nginx       1332  0.0  0.1 162996 12596 ?        S    Mar23   0:02 nginx
nginx       1333  0.0  0.1 162448 11604 ?        S    Mar23   0:00 nginx
nginx       1334  0.0  0.1 162448  8128 ?        S    Mar23   0:00 nginx
nginx       1335  0.0  0.1 162448  8060 ?        S    Mar23   0:00 nginx
...
```

### Kill processes
- ### Kill a process
```bash
kill -9 1000
```
- ### Kill mutilple processes using their executable name
```bash
killall -15 nginx
pkill -U tester
```

### Set user to `nologin`
```bash
usermod -s /sbin/nologin nginx_usr1
```

## How to remove ubuntu-desktop
```bash
apt-get remove ubuntu-desktop -y
apt-get autoremove -y
```
```bash
apt-get remove nautilus nautilus-* gnome-power-manager gnome-screensaver gnome-termina* gnome-pane* gnome-applet* gnome-bluetooth gnome-desktop* gnome-sessio* gnome-user* gnome-shell-common zeitgeist-core libzeitgeist* gnome-control-center gnome-screenshot -y
apt-get autoremove -y
```

## How to test disk
```bash
badblocks -sv /dev/sda
```
- ### Ref: https://askubuntu.com/questions/291570/mark-bad-sectors-on-hard-drive-without-formatting/490549#490549
```bash
sudo apt-get install smartmontools
```
- ### Read all attributes from the first disk
```bash
sudo smartctl --all /dev/sda
```
- ### You can even trigger self tests of the disk when supported by your model
```bash
sudo smartctl -t long /dev/sda
```
- ### Ref: https://www.debugpoint.com/2020/07/scan-repair-bad-sector-disk-linux/
- ### To identify the disk partition which you want to scan for bad sectors
```bash
lsblk -o name,mountpoint,label,size,uuid
```
- ### Scan to find bad sectors
```bash
badblocks -v /dev/sda1 > ~/bad_sectors.txt
```
- ### Repair Bad Sectors
```bash
sudo e2fsck -cfpv /dev/sda1
```
OR
- ### You can also specify the bad_sectors.txt file created in the earlier steps as well to force e2fsck to repair those in the file only via the below command
```bash
sudo e2fsck -l bad_sectors.txt /dev/sda1
```
OR
- ### For other file systems (such as FAT32)
```bash
sudo fsck -l bad_sectors.txt /dev/sda1
```

## Check whether your CentOS installation already has swap enabled
```bash
sudo swapon --show
```
```text
NAME      TYPE      SIZE USED PRIO
/dev/dm-1 partition 1.5G   0B   -1
```

## Check swap
```bash
free -m
```

## Enable swap
- ### Skip non-existent devices
```bash
swapon -e
```
- ### Activate all of swap space.
```bash
swapon -a
```

## Disable swap
```bash
swapoff -a
```

## Swap parameter in system
- ### `sysctl.conf`
```bash
vm.Swappiness = 10
vm.vfs_cache_pressure = 50
```

## Check SSD or HDD
```bash
lsblk -d -o name,rota
```
- ### HDD - 1
```text
NAME  ROTA
vda      1
vdb      1
```
- ### SSD - 0
```text
NAME   ROTA
sda       0
sdb       0
```

## Find out who is monopolizing or eating the CPUs
```bash
ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10
```

## Backup with borgbackup
```bash
sudo apt-get install borgbackup
```
- ### Ref of push mode: https://viblo.asia/p/nguoi-ta-lam-cach-nao-de-backup-thuong-xuyen-thu-muc-rat-lon-bJzKm4MO59N
- ### Ref of pull mode: https://borgbackup.readthedocs.io/en/stable/deployment/pull-backup.html

## In Unix ecosystem
- ### `stdout` (file descriptor = 1)
```bash
echo “Hello World” > log.txt
```
- ### `stderr` (file descriptor = 2)
```bash
asdfadsa 2> error.txt
```

- ### Redirecting output to /dev/null
```bash
grep -r hello /sys/ 2> /dev/null
echo $?
```
```text
2
```

- ### Redirect all output to /dev/null
```bash
grep -r hello /sys/ > /dev/null 2>&1
echo $?
```
```text
2 - The value is 2 because the command generated a lot of errors.
```

- ### Redirect bot stdout and stderr to /dev/null
```bash
grep -r hello /sys/ &> /dev/null
```
```text
2
```

## How to test
- ### Test download
```bash
wget -o /dev/null https://github.com/elastic/kibana/archive/refs/tags/v6.8.18.tar.gz
echo $?
```
```text
0
```
- ### Check docker command
```bash
check_docker() {
    command -v docker >& /dev/null
    NODOCKER=$?
    DOCKER=null
    if [ "${NODOCKER}" == 0 ]; then
        DOCKER=$(docker -v)
    fi
    echo ${DOCKER}
}
```

## How to list packages in debian-based
```bash
dpkg -l | awk '{print $2}'
```
## How to specify package version in debian-base such as ubuntu
- ### Get version
```bash
apt-cache show ufw | grep ^Version
```
```text
Version: 0.36-6
```

- ### How to install a package with specific verison
```bash
apt-get install ufw=0.36-6
```

- ### How to get dependencies of a package
```bash
apt-cache --recurse depends ufw
```

- ### How to clean apt cache
```bash
apt-get autoremove
apt-get clean
```

- ### Remove docs in debian-based
```bash
rm -rf /usr/share/doc/* /usr/share/man/* /usr/share/info/*
```

- ### How to delete `*.log` file
```bash
find /var | grep '\.log$' | xargs rm -v
```

## How to clean cache DNS
```bash
sudo systemd-resolve --flush-caches
```

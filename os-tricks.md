# OS tricks

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

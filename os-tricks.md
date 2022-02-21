# OS tricks

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

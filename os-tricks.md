# OS tricks

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

# CubeSandbox

#### Install
* Mount data system
  ```bash
  mkfs.xfs /dev/nvme1n1 -f
  mkdir -p /data/cubelet
  mount /dev/nvme1n1 /data/cubelet
  ```
* Check
  ```bash
  df -T /data/cubelet
  ```
* Get UUID
  ```bash
  sudo blkid
  ```
* Update `/etc/fstab`
  ```text
  UUID=abc123 /data/cubelet xfs defaults,pquota 0 0
  ```
* Script íntall
  ```bash
  curl -sL https://cnb.cool/CubeSandbox/CubeSandbox/-/git/raw/master/deploy/one-click/online-install.sh | MIRROR=cn bash
  ```

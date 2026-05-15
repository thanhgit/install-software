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
  sudo su root
  
  curl -sL https://cnb.cool/CubeSandbox/CubeSandbox/-/git/raw/master/deploy/one-click/online-install.sh | MIRROR=cn bash
  ```
* Create VM template
  ```bash
  cubemastercli tpl create-from-image \
    --image cube-sandbox-int.tencentcloudcr.com/cube-sandbox/sandbox-code:latest \
    --writable-layer-size 1G \
    --expose-port 49999 \
    --expose-port 49983 \
    --probe 49999
  ```

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
    --template-id code-sandbox \
    --image cube-sandbox-int.tencentcloudcr.com/cube-sandbox/sandbox-code:latest \
    --writable-layer-size 1G \
    --expose-port 49999 \
    --expose-port 49983 \
    --probe 49999
  ```
* Check job id
  ```bash
  cubemastercli tpl watch --job-id ...
  ```

* Create cert
  ```bash
  sudo apt update
  sudo apt install -y chromium-browser libnss3-tools
  
  mkdir -p ~/.pki/nssdb
  certutil -N -d sql:$HOME/.pki/nssdb
  ```

### Fix:
* Error sandbox
  * List all image
    ```bash
    cd /usr/local/services/cubetoolbox/cubebox_os_image/
    ```
  * Copy file .ext4 -> .vm
  * Tạo file version với content là: `v1`

* Clean up `ip a`
  ```bash
  for i in $(ip -o link show | awk -F': ' '{print $2}' | grep z192); do
    sudo ip link delete $i
  done
  ```
* Clean up `data`
  ```bash
  docker volume rm support_cube-sandbox-mysql-data
  docker volume rm support_cube-sandbox-redis-data
  ```
















  

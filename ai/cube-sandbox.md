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

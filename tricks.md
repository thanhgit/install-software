# Common trick

## Update software
```bash
yum update --downloadonly --downloaddir=/tmp/polkit polkit
cd /tmp/polkit
rpm -Uvh polkit-0.112-26.el7_9.1.x86_64.rpm
```

## Linux common command
- https://tel4vn.edu.vn/blog/top-30-cau-lenh-tren-linux-thuong-duoc-su-dung-trong-devops/
## Check OS info
```
inxi -Fxxxa
```

## Camera operation in linux
- ### Disable camera
  ```bash
  sudo modprobe -r uvcvideo
  ```
- ### Enable camera
  ```bash
  sudo modprobe uvcvideo
  ```

## Switch gdm3 and lightdm
```bash
sudo dpkg-reconfigure gdm3
```
 
## Scan virus in ubuntu
```bash
clamscan --infected --recursive --remove /
```

### Update current time on server
```bash
CURRENT=$(wget -qSO- --max-redirect=0 google.com 2>&1 | grep Date: | cut -d' ' -f5-8)Z
sudo date -s "$CURRENT"
```

## Uninstall a deb file
- ### Get package name
  ```bash
  sudo dpkg -f xxx.deb
  ```
- ### Remove
  ```bash
  sudo dpkg -r package_name
  ```
  
## Debug websocket
- ### Install wscat
  ```bash
  npm install -g wscat
  ```
- ### How to use
  ```bash
  wscat -c wss://xxx.com
  ```

## If systemctl status -> degrated
```bash
systemctl reset-failed
```

## List installed-package in ubuntu
```bash
apt list --installed
```

## Use base64
- ### Encode
```bash
openssl base64 -in xxx.key -out key.txt
```
- ### Decode
```bash
openssl base64 -in yyy.crt -out crt.txt
```

## How to create P12 from .crt and .key
```bash
openssl pkcs12 \
       -inkey xxx.key \
       -in xxx.crt \
       -export -out domain.pfx
```

## How to call curl from P12 file
```bash
curl -v --cert-type P12 -E domain.pfx:password https://xxx.com
```

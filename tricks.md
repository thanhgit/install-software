# Common trick

<a href="https://m.media-amazon.com/images/I/71MGiPTwXAL._AC_UY218_.jpg" target="_blank" rel="noopener noreferrer">
<img src="https://m.media-amazon.com/images/I/71MGiPTwXAL._AC_UY218_.jpg" />
</a>

Here's a link to [Google](https://google.com){target="_blank"}


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

### Set up the ACME script ready to request a free SSL certificate and private key from Let’s Encrypt
- ### Install
```bash
apt install -y socat
curl https://get.acme.sh | sh
alias acme.sh=~/.acme.sh/acme.sh
acme.sh --upgrade --auto-upgrade
```
- ### Setup default CA
```bash
acme.sh --set-default-ca --server letsencrypt
```
- ### Issue `Elliptic Curve Cryptography certificate for hostname`
```bash
acme.sh --issue -d demo.example.com --standalone --keylength ec-256
```
- ### Generate certificate
```bash
acme.sh --install-cert -d demo.example.com --ecc --fullchain-file /tmp/fullchain.cer --key-file /demo/private.key
```
- ### Force certificate renewal
```bash
acme.sh --renew -d demo.example.com --force --ecc
```
- ### Using
```yaml
tls:
  cert: /tmp/fullchain.cer
  key: /tmp/private.key
```


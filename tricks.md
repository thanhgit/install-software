# Common tricks

## How to increase CPU/RAM available to VSCode
- #### File -> Preferences -> Settings
- #### Type: `files.maxMemoryForLargeFilesMB`

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

## Fix error: login loop => long time to wait
- ### Edit file /etc/gdm3/custom.conf
- ### Not enable nvidia
```bash
#WaylandEnable=false
```
- ### Enable nvidia
```bash
WaylandEnable=false
```

## Disable secure boot before using `nvidia-smi`
 
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

#### Uptime kuma 
* Custom status page
```csss
footer::after {
    content: "";
    display: block;
    width: 100%;
    
    /* 1. THAY ĐƯỜNG DẪN ẢNH CỦA BẠN VÀO ĐÂY (Link phải có đuôi .png/.jpg) */
    background-image: url("https://images2.thanhnien.vn/528068263637045248/2024/1/25/c3c8177f2e6142e8c4885dbff89eb92a-65a11aeea03da880-1706156293184503262817.jpg") !important; 
    
    /* Cấu hình hiển thị ảnh cân đối */
    background-size: contain;
    background-repeat: no-repeat;
    background-position: center;
    
    /* 2. CHIỀU CAO ẢNH: Bạn có thể tăng/giảm số này để ảnh to hoặc nhỏ hơn */
    height: 450px; 
    
    /* Khoảng cách giữa dòng chữ footer cũ và bức ảnh sơ đồ */
    margin-top: 40px; 
    margin-bottom: 20px;
    
    /* Hiệu ứng bo góc và đổ bóng nhẹ để tách biệt với nền */
    border-radius: 12px;
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
}

/* Tự động thu nhỏ ảnh khi xem trên màn hình điện thoại */
@media (max-width: 768px) {
    footer::after {
        height: 220px;
        margin-top: 20px;
    }
}
```
* Notification template for webhook webdis
```
{
"Authorization": "Basic ***"
}
```
```
{% if status contains 'Up' %}{% assign status_code = 1 %}{% else %}{% assign status_code = 0 %}{% endif %}{% capture kuma_json %}{"id":{{ monitorJSON.id }},"service":"{{ name }}","status":{{ status_code }},"message":"{{ msg }}","target":"{{ hostnameOrURL }}","time":"{{ heartbeatJSON.time | date: '%Y-%m-%dT%H:%M:%SZ', 0 }}","ping":{{ heartbeatJSON.ping | default: -1 }}}{% endcapture %}SET/uptime-kuma-{{ monitorJSON.id }}/{{ kuma_json | strip | url_encode }}
```




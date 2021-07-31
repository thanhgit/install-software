# Common trick

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
## Start minikube
```bash
minikube start --memory 8192 --cpus 2
```

## If systemctl status -> degrated
```bash
systemctl reset-failed
```

## List installed-package in ubuntu
```bash
apt list --installed
```

# Common trick

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
  
## How to untrack a file in git
- ### Keep the local file for you, but will delete it for anyone else when they pull.
```bash
git rm -r --cached <folder-name>
```
```bash
git rm --cached <file-name>
```
- ### Index will be reset and file(s) overwritten if there are upstream changes to the file/folder (when you pull).
```bash
git update-index --assume-unchanged <path-name>
```
- ### Tell git you want your own independent version of the file or folder. For instance, you don't want to overwrite (or delete) production/staging config files
- File
```bash
git update-index --skip-worktree explorer/connection-profile/test-network.json
```
```bash
git update-index --no-skip-worktree explorer/connection-profile/test-network.json
```
- Directory
```bash
cd directory
find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "cd '{}' && pwd && git ls-files -z ${pwd} | xargs -0 git update-index --skip-worktree" \;
```
```bash
cd directory
find . -maxdepth 1 -type d \( ! -name . \) -exec bash -c "cd '{}' && pwd && git ls-files -z ${pwd} | xargs -0 git update-index --no-skip-worktree" \;
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

## Interact cognito CLI
```bash
aws cognito-idp sign-up --region xxx --client-id yyy --username zzz --password ppp

aws cognito-idp admin-confirm-sign-up --region xxx --user-pool-id uuu --username zzz

aws cognito-idp admin-initiate-auth --region ap-northeast-1 --cli-input-json file://auth.json

{
    "UserPoolId": "uuu",
    "ClientId": "yyy",
    "AuthFlow": "ALLOW_USER_SRP_AUTH",
    "AuthParameters": {
        "USERNAME": "zzz",
        "PASSWORD": "ppp"
    }
}
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

## Fix errors
- ### Related to virtualbox
```text
WARNING: The character device /dev/vboxdrv does not exist.
	 Please install the virtualbox-dkms package and the appropriate
	 headers, most likely linux-headers-generic.
```
bash
```
sudo modprobe vboxdrv
sudo modprobe vboxnetflt
```
- ### List virtualbox
```bash
VBoxManage list vms
```
- ### List server running
```bash
VBoxManage list runningvms
```
- ### List server running detail
```bash
VBoxManage list -l runningvms
```
- ### Show detail of a server
```bash
VBoxManage showvminfo server_name
```
- ### Modify CPU, RAM
```bash
VBoxManage modifyvm server_name --cpus 2 --memory 2048 --vram 12
```
- ### Configuring a Virtual Network Adapter
```bash
 VBoxManage modifyvm server_name --nic1 bridged --bridgeadapter1 eth0
```
- ### Attaching Virtual Media to a VM
```bash
VBoxManage createhd --filename /path/to/hard_drive_image/server_name.vdi --size 5120 
```
```bash
VBoxManage storagectl server_name --name "SATA Controller" --add sata --bootable on
```
- ### List OS type
```bash
VBoxManage list ostypes
```
- ### Start server
```bash
VBoxManage startvm "server_name" --type headless
```
- ### Pause server
```bash
VBoxManage controlvm "server_name" pause --type headless
```
- ### To restart that paused VM
```bash
VBoxMange controlvm "server_name" resume --type headless
```
- ### To shut down the VM
```bash
VBoxManage controlvm "server_name" poweroff --type headless
```

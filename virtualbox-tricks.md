# Virtualbox

## Fix errors
- ### Related to virtualbox
```text
WARNING: The character device /dev/vboxdrv does not exist.
	 Please install the virtualbox-dkms package and the appropriate
	 headers, most likely linux-headers-generic.
```
```bash
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
```bash
VBoxManage storageattach server_name --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium /path/to/hard_drive_image/server_name.vdi
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
- ### Ref: https://www.oracle.com/technical-resources/articles/it-infrastructure/admin-manage-vbox-cli.html

### Register gitlab-runner in docker-machine
```bash
sudo gitlab-runner register \
    	-u http://192.168.33.10/ci \
    	-r psu73HL3bCXbGj4dXcay \
    	-n \
    	--executor docker+machine \
    	--docker-image "microsoft/dotnet:2-sdk" \
    	--machine-machine-driver "virtualbox" \
    	--machine-machine-name "%s" \
    	--tag-list "dotnet-core"\
    	--name "docker-machine-runner"
```

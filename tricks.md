# Common trick

## Disable camera
```bash
sudo modprobe -r uvcvideo
```

## Enable camera
```bash
sudo modprobe uvcvideo
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

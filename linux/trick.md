# Enhance ubuntu boot

#### Disable some service
```bash
sudo systemctl disable NetworkManager-wait-online.service
```
```bash
sudo systemctl disable gpu-manager.service
```

#### View từng dòng mỗi giây trong linux
```bash
cat -n file.txt | while IFS= read -r line; do echo "$line"; sleep 1; done
```

# Enhance ubuntu boot

#### Configure Permissions (Run Without sudo)
* Using `setcap` to grant the binary the necessary capabilities so you can run it as a standard user
  ```bash
  sudo setcap 'cap_net_raw,cap_bpf,cap_perfmon+eip' /usr/bin/rustnet
  ```
* Using `visudo`
  ```bash
  sudo visudo -f /etc/sudoers.d/rustnet
  ```
  ```text
  ten_user ALL=(ALL) NOPASSWD: /usr/bin/rustnet
  ```

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

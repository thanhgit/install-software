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
  ```
  echo "alias rustnet='sudo /usr/bin/rustnet'" >> ~/.bashrc
  source ~/.bashrc
  ```
* Dùng SUID Bit (chmod u+s) — (Không khuyến khích)
  * để ép file thực thi luôn chạy dưới quyền chủ sở hữu (root) bất kể ai gọi nó
  * cấp toàn bộ quyền root cho tiến trình
  ```bash
  sudo chown root:root /usr/bin/rustnet
  sudo chmod u+s /usr/bin/rustnet
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

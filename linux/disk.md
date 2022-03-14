# Disk

### Case: nâng cấp hard disk 
- ### Chia partition: MBR (4 primary partition), GPT (128 primary partition)
- ### Format partition: EXT4 
- ### Kết nối partition vào "Folder do admin chỉ định" => MOUNT

### Kiểm tra xem trong linux có bao nhiêu hard disk
```bash
cat /proc/partitions
```
---
```text
major minor  #blocks  name

   7        0      56840 loop0
   7        1      63252 loop1
   7        2      63380 loop2
   7        3      56768 loop3
   7        4      44632 loop4
   8        0  156290904 sda
   8        1  156289024 sda1
```
OR
```bash
ls -l /dev/ | grep -i "sda*"
```
---
```text
brw-rw---- 1 root disk      8,   0 Mar 12 14:55 sda
brw-rw---- 1 root disk      8,   1 Mar 12 14:55 sda1
```
OR
```bash
fdisk -l
```

### Cách chia partition 
```bash
fdisk /dev/sdb
```
- `m`: hiển thị menu
- `n`: nghĩa là tạo một partition mới 
- `p`: nghĩa là tạo ra một primary partition 
- `1`: tạo partition thứ nhất 
- `default` sẽ dùng hết dung lượng
- `First cylinder (..., default 1):` -> nếu default thì enter
- `Last cylinder, +cylinders or +size(K,M,G) (...,...)` -> nếu muốn cấp phát 10Gb ->  +10G
- `w`: lưu đến disk và exit (lệnh này mới là lệnh thực thi những lệnh trước đó)

### Cách format partition 
- ### Dùng lệnh `mkfs`
```bash 
mkfs -t ext4 /dev/sdb1
```

### Kết nối partition tới folder
- ### Create a folder
```bash
mkdir /DATA1
```
- ### Connect partition to folder
- ### Mount tạm thời
```bash
mount -t ext4 /dev/sda1 /DATA1
```
- ### Check
```bash
mount
```
---
```text
...
/dev/sda1 on / type ext4 (rw,relatime,errors=remount-ro,data=ordere
...
```
- ### How to remove mount
```bash
umount /DATA1
```
- ### Mount cố định trong `/etc/fstab`
```text
UUID=e1f826b7-8fe4-4040-a500-2aa6b89aad25 /               ext4    errors=remount-ro 0       1
Col_1                                    Col_2          Col_3       Col_4           Col_5   Col_6
```
- ### `Col_1`: device or partition
- ### `Col_2`: mount point
- ### `Col_3`: Type of file system such as ext4, ext3, ext2, swap, ...
- ### `Col_4`: Mount options
    - ### default is `defaults` consists of the features such as rw, suid, dev, exec, auto, nouser
    - ### Choose others such as: auto, no-auto, user, no-user, ro, rw
- ### `Col_5`: DUMP feature to backup. 0 -> no dump, 1 -> dump
- ### `Col_6`: using `fsck` to scan file system. 0 -> no check, 1 -> check
```text
/dev/sdb1   /DATA1  ext4    defaults    0   0
```
- ### Read /etc/fstab and reconnect
```bash
mount -a
```

### How to remount
- ### Edit at /etc/fstab
- ### Remount: `mount -o remount /`
# User, group

### List user
```bash
cat /etc/passwd
```
- ### Normal user (userid > 100)
- ### System user (userid < 100)

### List group
```bash
cat /etc/group
```

### Create a user
```bash
adduser
```
- ### Create user id
- ### Create group id
```bash
adduser sinhvien
```
```text
Adding user `sinhvien' ...
Adding new group `sinhvien' (1002) ...
Adding new user `sinhvien' (1002) with group `sinhvien' ...
Creating home directory `/home/sinhvien' ...
Copying files from `/etc/skel' ...
Enter new UNIX password: 
Retype new UNIX password: 
passwd: password updated successfully
Changing the user information for sinhvien
Enter the new value, or press ENTER for the default
	Full Name []: Sinh vien
	Room Number []: 
	Work Phone []: 
	Home Phone []: 
	Other []: 
Is the information correct? [Y/n] Y
```
- ### Add user with specific home path
```bash
useradd -d /home/demo demo
```

### Check user
```bash
id thanhnp
```
---
```text
uid=1000(thanhnp) gid=1000(thanhnp) groups=1000(thanhnp),4(adm),24(cdrom),27(sudo),30(dip),46(plugdev),108(lxd),113(lpadmin),114(sambashare)
```

### Add group
```bash
groupadd giaovien
groupadd hocvien
useradd g1
useradd -g giaovien -G hocvien g1
id g1
```

### ACL
- ### `getfacl`: kiểm tra permission của file và folder
- ### `setfacl`: gán permission cho file và folder 
# Ansible
- ### Ansible works by configuring client machines from an computer with Ansible components installed and configured
- ### It communicates over normal SSH channels in order to retrieve information from remote machines, issue commands, and copy files
- ### Ansible keeps track of all of the servers that it knows about through a `/etc/ansible/hosts` file

## Install ansible
```bash
yum install -y epel-release
yum install -y ansible
```

## Configure servers in `/etc/ansible/hosts`
```bash
cat <<EOF > /etc/ansible/hosts
[ci]
host1 ansible_ssh_host=192.168.1.2
host2 ansible_ssh_host=192.168.1.4

[auth]
host3 ansible_ssh_host=192.168.1.6
EOF

mkdir -p /etc/ansible/group_vars/

cat <<EOF /etc/ansible/group_vars/ci
---
ansible_ssh_user: root
EOF

cat <<EOF > /etc/ansible/group_vars/auth
---
ansible_ssh_user: admin
EOF

cat <<EOF > /etc/ansible/group_vars/all
---
ansible_ssh_user: root
EOF
```

## Execute command
- ### Test ping
```bash
ansible -m ping all
```
---
```bash
host1 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    }, 
    "changed": false, 
    "ping": "pong"
}
host2 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    }, 
    "changed": false, 
    "ping": "pong"
}
```
- ### Other test ping
```bash
ansible -m ping ci
ansible -m ping auth
```

- ### Shell command
```bash
ansible -m shell -a 'free -m' host1:host2
```
---
```text
host2 | CHANGED | rc=0 >>
              total        used        free      shared  buff/cache   available
Mem:           5301         834        2280         289        2186        3891
Swap:          3275           0        3275
host1 | CHANGED | rc=0 >>
              total        used        free      shared  buff/cache   available
Mem:           9837        4650        1123          97        4064        4785
Swap:          2047           0        2047
```

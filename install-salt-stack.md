# Install salt stack in centos 7

## Install salt-master
```bash
yum install -y https://repo.saltproject.io/yum/redhat/salt-repo-latest.el7.noarch.rpm
yum install -y salt-master
sed -i 's/# interface: 0.0.0.0/interface: 0.0.0.0/g' /etc/salt/master
sed -i 's/#timeout: 5/timeout: 600/g' /etc/salt/master
systemctl start salt-master
```

### Configuration
- ### Edit `/etc/salt/master` file
```text
interface: 0.0.0.0
timeout: 600

file_roots:
  base:
    - /srv/salt
```
- ### Start salt-master with `systemctl start salt-master`
- ### Accept the salt-minion key with `salt-key -a saltclient`
- ### Verify salt-minion with `salt 'saltclient' test.ping`

### Installing packages through single command
```bash
salt '*' pkg.install nmap
---
saltclient2:
    ----------
    nmap:
        ----------
        new:
            2:6.40-19.el7
        old:
saltclient:
    ----------
    nmap:
        ----------
        new:
            2:6.40-19.el7
        old:
```

## Install salt-minion
```bash
yum install -y https://repo.saltproject.io/yum/redhat/salt-repo-latest.el7.noarch.rpm
yum install -y salt-minion
sed -i 's/#master: salt/master: 192.168.1.4/g' /etc/salt/minion
sed -i 's/#id:/id: saltclient2/g' /etc/salt/minion
systemctl start salt-minion
```

### Configuration
- ### Edit ` /etc/salt/minion` file
```text
master: 192.168.1.4
id: saltclient
```
- ### Start salt-master with `systemctl start salt-minion`


# References
- https://www.assistanz.com/install-saltstack-master-centos7/

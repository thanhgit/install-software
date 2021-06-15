# Install salt stack in centos 7

## Install salt-master
```bash
yum install -y https://repo.saltproject.io/yum/redhat/salt-repo-latest.el7.noarch.rpm
yum install -y salt-master
```

### Configuration
- ### Edit `/etc/salt/master` file
```text
interface: 0.0.0.0
timeout: 600
```
- ### Start salt-master with `systemctl start salt-master`
- ### Accept the salt-minion key with `salt-key -a saltclient`
- ### Verify salt-minion with `salt 'saltclient' test.ping`

## Install salt-minion
```bash
yum install -y https://repo.saltproject.io/yum/redhat/salt-repo-latest.el7.noarch.rpm
yum install -y salt-minion
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

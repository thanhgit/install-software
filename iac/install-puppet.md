# Install puppet in centos 7

## Install puppet server
```bash
rpm -ivh https://yum.puppetlabs.com/el/7/products/x86_64/puppetlabs-release-7-11.noarch.rpm
yum install -y puppet-server
systemctl start puppetmaster.service
systemctl status puppetmaster.service
```

## Install puppet client
```bash
yum install -y puppet
```

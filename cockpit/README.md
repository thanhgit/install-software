# Nginx proxy manager

## Setup server
```bash
vagrant up --provider=virtualbox
```

## Access server
```bash
vagrant ssh
```

## Install cockpit
```bash
sudo yum install cockpit -y
sudo systemctl start cockpit
sudo systemctl status cockpit
```

## Install report
```bash
sudo yum install sos -y
```

## Access admin https://192.168.1.71:9090/system with linux account
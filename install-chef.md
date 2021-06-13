# Intall Chef  in centos 7

## Bash script
```bash
cd /tmp
wget https://packages.chef.io/files/current/chef-server/14.5.13/el/7/chef-server-core-14.5.13-1.el7.x86_64.rpm
rpm -ivh chef-server-core-14.5.13-1.el7.x86_64.rpm
chef-server-ctl reconfigure
```

## Check status
```bash
chef-server-ctl status
---
run: bookshelf: (pid 26948) 15829s; run: log: (pid 26580) 15941s
run: elasticsearch: (pid 26929) 15829s; run: log: (pid 26412) 15982s
run: nginx: (pid 26856) 15830s; run: log: (pid 26745) 15840s
run: oc_bifrost: (pid 26800) 15831s; run: log: (pid 26312) 15999s
run: oc_id: (pid 26845) 15830s; run: log: (pid 26330) 15988s
run: opscode-erchef: (pid 26962) 15828s; run: log: (pid 26686) 15935s
run: postgresql: (pid 26785) 15831s; run: log: (pid 25812) 16020s
run: redis_lb: (pid 26771) 15832s; run: log: (pid 26770) 15832s
```

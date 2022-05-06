# Using module functions

## Execute function
- ### Syntax
```bash
salt <target> <module>.<function> [arguments...]
For example: salt '*' test.echo 'Hello world'
```
- ### Common functions:
  - ### test.ping
```bash
salt nfs test.ping
---
nfs:
    True
```
  - ### test.echo
```bash
salt nfs test.echo "Server ${HOSTNAME}"
---
nfs:
    Server keycloak
```
  - ### test.sleep
```bash
salt nfs test.sleep 1
---
nfs:
    True
```
  - ### test.version
```bash
salt nfs test.version
---
nfs:
    3000.9
```
## Use case
- ### Install httpd
```bash
salt nfs pkg.install httpd
---
nfs:
    ----------
    httpd:
        ----------
        new:
            2.4.6-97.el7.centos
        old:
        
salt nfs cmd.run cmd='systemctl start httpd'
---
nfs:

salt nfs cmd.run cmd='systemctl status httpd'
---
nfs:
    * httpd.service - The Apache HTTP Server
...
```
- ### Remove httpd
```bash
salt nfs pkg.remove httpd
---
nfs:
    ----------
    httpd:
        ----------
        new:
        old:
            2.4.6-97.el7.centos
```
- ### Replace file with `file.replace` ~ `sed command`, `file.find`, `file.chown`, `file.get_mode`, `file.rename`

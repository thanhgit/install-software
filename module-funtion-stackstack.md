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

# Golang tricks

## Install gvm
```bash
git clone https://github.com/moovweb/gvm.git
bash < ./gvm/binscripts/gvm-installer
source ~/.gvm/scripts/gvm
```
### Get version of package
```bash
go list -m -versions golang.org/x/net
```

### Edit package
```bash
go mod edit -require github.com/wilk/uuid@0.0.1
```
```bash
go get -v -t ./...
```

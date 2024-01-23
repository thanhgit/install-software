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
```bash
go mod tidy
```

### Install and run govulncheck
```bash
go install golang.org/x/vuln/cmd/govulncheck@latest
```
```bash
govulncheck ./...
```

### Install and run deadcode
````bash
go install golang.org/x/tools/cmd/deadcode@latest
```
```bash
deadcode -test ./...
```

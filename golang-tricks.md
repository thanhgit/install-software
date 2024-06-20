# Golang tricks

### Get go package versions
```bash
curl https://proxy.golang.org/github.com/gin-contrib/gzip/@v/list
```
```text
v1.0.0
v0.0.1
v0.0.5
v0.0.3
v0.0.4
v0.0.2
v1.0.1
v0.0.6
```
### Check go package info
```bash
curl https://proxy.golang.org/github.com/gin-contrib/gzip/@v/v1.0.0.info
```
```json
{
  "Version": "v1.0.0",
  "Time": "2024-03-23T11:49:10Z",
  "Origin": {
    "VCS": "git",
    "URL": "https://github.com/gin-contrib/gzip",
    "Ref": "refs/tags/v1.0.0",
    "Hash": "b476794c4a434a879afab54c4ceb8881d71c705e"
  }
}
```

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

### Insider
- ### Link: https://github.com/insidersec/insider
- ### Install
```bash
wget https://github.com/insidersec/insider/releases/download/2.1.0/insider_2.1.0_linux_x86_64.tar.gz
tar -xf insider_2.1.0_linux_x86_64.tar.gz
chmod +x insider
```
- ### Run
```bash
./insider --tech csharp --target . --exclude insider --exclude "style.css" --exclude CHANGELOG.md --exclude demo.sln
```

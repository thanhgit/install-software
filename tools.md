# Common tools
```bash
docker stop ui-template-de | /bin/true

docker run --rm -i --name ui-template-de \
		-p 127.0.0.1:9999:9999 \
		-p 127.0.0.1:8501:8501 \
		-e UTIL4DEV_SUBNET=172.17.0.0/16 \
		docker.io/thanhdocker/ui-template-de:1.0.4
```

### [A tool for writing better scripts](https://github.com/google/zx)

### https://vi.aliexpress.com
```javascript
const title = document.querySelectorAll('h1[data-pl="product-title"]');
const search = title[0].outerText.substring(0,8).replaceAll(' ', '-')
console.log(search)

const imgs_arr = []
Array.from(document.getElementsByTagName("img")).map(i => i.src).filter(i => i.includes("https://") && i.includes(search)).forEach(item => console.log(item))

console.log(imgs_arr.toString())
```
![image](https://github.com/thanhgit/install-software/assets/21302811/9f8ee869-c72d-403a-890d-9d889af1f303)

### https://us.shein.com/
```javascript

```
![image](https://github.com/thanhgit/install-software/assets/21302811/f73324bf-7bef-4fac-8907-c18035ad569c)

### Copy image link
![image](https://github.com/thanhgit/install-software/assets/21302811/45c2126a-4d30-4b0f-99a6-d96ddb4ecc37)

#### PDF 
* https://github.com/alam00000/bentopdf

### Utils tool
* [Wait4X](https://github.com/wait4x/wait4x)
* To allows you to wait for a port or a service to enter the requested state, with a customizable timeout and interval time.

### SecScanMCP
* https://github.com/zakariaf/SecScanMCP
* 12+ analyzers, 117 YARA rules, ML-powered threat detection, dual scoring system. Detects prompt injection, tool poisoning and more

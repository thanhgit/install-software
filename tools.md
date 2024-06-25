# Common tools

### [A tool for writing better scripts](https://github.com/google/zx)

### https://vi.aliexpress.com
```javascript
const title = document.querySelectorAll('h1[data-pl="product-title"]');
const search = title[0].outerText.substring(0,8).replaceAll(' ', '-')
console.log(search)

const imgs_arr = []
Array.from(document.getElementsByTagName("img")).map(i => i.src).filter(i => i.includes("https://") && i.includes(search)).forEach(item => console.log(item))

console.log(imgs_arr.join(','))
```

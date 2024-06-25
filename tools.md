# Common tools

### [A tool for writing better scripts](https://github.com/google/zx)

### https://vi.aliexpress.com
```javascript
const title = document.querySelectorAll('h1[data-pl="product-title"]');
const search = title[0].outerText.substring(0,8).replaceAll(' ', '-')
console.log(search)

function img_find(search) {
    return Array.from(document.getElementsByTagName("img")).map(i => i.src).filter(i => i.includes("https://") && i.includes(search));
}

const imgs_arr = img_find(search).map(item => item)

console.log(imgs_arr)
```

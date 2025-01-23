# Install nginx with brotli

#### Install support libs
```bash
sudo apt install git gcc cmake libpcre3 libpcre3-dev zlib1g zlib1g-dev openssl libssl-dev -y
```

#### Compile brotli with nginx 1.18.0
```bash
wget https://nginx.org/download/nginx-1.18.0.tar.gz
tar zxvf nginx-1.18.0.tar.gz
git clone https://github.com/google/ngx_brotli.git
cd ~/ngx_brotli
git submodule update --init
cd ~/nginx-1.18.0
./configure --with-compat --add-dynamic-module=../ngx_brotli
make modules
sudo cp ./objs/*.so /usr/share/nginx/modules
```

#### Load brotli libs in nginx.conf
```bash
load_module modules/ngx_http_brotli_filter_module.so;
load_module modules/ngx_http_brotli_static_module.so;
```

#### Configure brotli in nginx.conf
```bash
##Brotli
brotli on;
brotli_comp_level 6;
brotli_types text/plain text/css text/xml application/json application/javascript application/xml+rss application/atom+xml image/svg+xml;
```

#### Restart nginx server
```bash
systemctl restart nginx
```

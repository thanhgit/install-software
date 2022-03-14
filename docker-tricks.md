# Docker trick

### Using `skopeo` to interact with registry such as: copy, delete image
```bash
skopeo delete docker://localhost:5000/imagename:latest
```

### Slim down Docker containers.
```text
Cleaning APT in a RUN layer: This must be done in the same layer as that of the other APT commands. 
If not, the previous layers will still contain the original information and your images will still be large.
```
```text
RUN {apt commands} \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
```
- ### Flatten an image:
```bash
ID=$(docker run -d image-name /bin/bash)
docker export $ID | docker import – flat-image-name
```
- ### For backup:
```bash
ID=$(docker run -d image-name /bin/bash)
(docker export $ID | gzip -c > image.tgz)
gzip -dc image.tgz | docker import - flat-image-name
```

### Remove all untagged images
```bash
docker rmi $(docker images | grep “^” | awk '{split($0,a," "); print a[3]}')
```

### Get environment settings
```bash
docker run --rm ubuntu env
```

### Kill `running containers`
```bash
docker kill $(docker ps -q)
```

### Delete all containers (force!! running or stopped containers).
```bash
docker rm -f $(docker ps -qa)
```

### Delete old containers such as `weeks ago`
```bash
docker ps -a | grep 'weeks ago' | awk '{print $1}' | xargs docker rm
```

### Delete stopped containers
```bash
docker rm -v $(docker ps -a -q -f status=exited)
```

### Delete containers after stopping
```bash
docker stop $(docker ps -aq) && docker rm -v $(docker ps -aq)
```

### Delete dangling images
```bash
docker rmi $(docker images -q -f dangling=true)
```

### Delete dangling volumes. As of Docker 1.9.0
```bash
docker volume rm $(docker volume ls -q -f dangling=true)
```


## See container port forwarding 
```bash
ps aux | grep docker
```
```text
root        1218  0.1  0.5 2494572 95288 ?       Ssl  Thg 823   3:36 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock
root      848309  0.0  0.0 1962072 10536 ?       Sl   Thg 823   0:58 /usr/bin/docker-proxy -proto tcp -host-ip 0.0.0.0 -host-port 8080 -container-ip 172.19.0.2 -container-port 8080
thanhuit 1018997  0.3  0.3 1277460 51884 pts/7   Sl+  02:43   0:12 docker stats mywebhook_app_1
root     1020527  0.0  0.0 1223088 4172 ?        Sl   02:52   0:01 /usr/bin/docker-proxy -proto tcp -host-ip 0.0.0.0 -host-port 8000 -container-ip 172.17.0.2 -container-port 8080
```
## How to use unix-socket with docker daemon
- ### List of available image
```bash
curl --unix-socket /var/run/docker.sock http://locahost/images/json | jq
```
```text
 % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  5678    0  5678    0     0   126k      0 --:--:-- --:--:-- --:--:--  128k
[
  {
    "Containers": -1,
    "Created": 1627452842,
    "Id": "sha256:17851392168f28d0325f5fede52b66bae9f2740724e5c3c6ebceb9b33199axxx",
    "Labels": null,
    "ParentId": "sha256:771c5fab999937f042b0c367bfd705f2c04029f128c8a6aaba3be6fc61260xxx",
    "RepoDigests": null,
    "RepoTags": [
      "container_name:latest"
    ],
    "SharedSize": -1,
    "Size": 30578184,
    "VirtualSize": 30578184
  },
  ...
]
```
- List of running container
```bash
curl --unix-socket /var/run/docker.sock http://locahost/images/json | jq
```
- Monitor events in daemon docker
```bash
curl --no-buffer --unix-socket /var/run/docker.sock http://localhost/events
```
```text
{
   "status":"destroy",
   "id":"9e8224f668d90c06529c5b9ad2e2ab0428b51e69adb8533312840186d78832db",
   "from":"migrate/migrate:v4.14.1",
   "Type":"container",
   "Action":"destroy",
   "Actor":{
      "ID":"9e8224f668d90c06529c5b9ad2e2ab0428b51e69adb8533312840186d78832db",
      "Attributes":{
         "com.docker.compose.config-hash":"91da9e012c4e095434b813c3bfdc054fc4c9ac3a56d7ff0643f95c600af74b4b",
         "com.docker.compose.container-number":"1",
         "com.docker.compose.oneoff":"False",
         "com.docker.compose.project":"docker",
         "com.docker.compose.service":"migrate",
         "com.docker.compose.version":"1.21.2",
         "image":"migrate/migrate:v4.14.1",
         "name":"docker_migrate_1"
      }
   },
   "scope":"local",
   "time":1627769313,
   "timeNano":1627769313567352230
}
...
```
- ### Create a tag to an image
```bash
curl -i -X POST --unix-socket /var/run/docker.sock "http://localhost/images/17851392168f/tag?repo=custom_tag&tag=latest"
```
```text
HTTP/1.1 201 Created
Api-Version: 1.41
Docker-Experimental: false
Ostype: linux
Server: Docker/20.10.7 (linux)
Date: Sat, 31 Jul 2021 22:20:48 GMT
Content-Length: 0
```

- ### Stop a running container
```bash
curl --unix-socket /var/run/docker.sock -X POST http:/v1.24/container/container_id/stop | jq
```

- ### Pull a image
```bash
curl --unix-socket /var/run/docker.sock -X POST "http:/v1.24/images/create?fromImage=alpine"
```
```text
{"status":"Pulling from library/alpine","id":"2.6"}
{"status":"Image docker.io/library/alpine:2.6 uses outdated schema1 manifest format. Please upgrade to a schema2 image for better future compatibility. More information at https://docs.docker.com/registry/spec/deprecated-schema-v1/"}
{"status":"Pulling fs layer","progressDetail":{},"id":"2a3ebcb7fbcc"}
...
{"status":"Pull complete","progressDetail":{},"id":"31603596830f"}
{"status":"Digest: sha256:414e0518bb9228d35e4cd5165567fb91d26c6a214e9c95899e1e056fcd349011"}
{"status":"Pulling from library/alpine","id":"3.9"}
{"status":"Digest: sha256:414e0518bb9228d35e4cd5165567fb91d26c6a214e9c95899e1e056fcd349011"}
{"status":"Pulling from library/alpine","id":"3"}
{"status":"Digest: sha256:adab3844f497ab9171f070d4cae4114b5aec565ac772e2f2579405b78be67c96"}
{"status":"Pulling from library/alpine","id":"edge"}
{"status":"Digest: sha256:12341c2503d96f13a17b0c935ae9090034e317afdfc934f1e0df1a5be813e73e"}
{"status":"Pulling from library/alpine","id":"latest"}
{"status":"Digest: sha256:adab3844f497ab9171f070d4cae4114b5aec565ac772e2f2579405b78be67c96"}
{"status":"Status: Downloaded newer image for alpine"}
```

## Docker monitor ( CPU MEMORY NET I/0 )
```bash
docker stats -a
```
```text
CONTAINER ID   NAME                        CPU %     MEM USAGE / LIMIT     MEM %     NET I/O          BLOCK I/O    PIDS
217d24599df3   xxxxxxxxxxxxxxx             0.00%     96.53MiB / 15.43GiB   0.61%     0B / 0B          230MB / 0B   1
e76fa4094262   yyyyyyyyyyyyyyy             0.00%     6.715MiB / 15.43GiB   0.04%     1.2MB / 34.2kB   0B / 0B      6
```

## Load testing
- Ref: https://httpd.apache.org/docs/2.4/programs/ab.html
```bash
docker run --net=host --rm --name=01basic_load russmckendrick/ab ab -k -n 10000 -c 5 http://0.0.0.0:8080/hello
```

## List processes in container ~ `ps aux`
```bash
docker top xxx
```
```text
UID                 PID                 PPID                C                   STIME               TTY                 TIME                CMD
500                 848343              848323              0                   Thg                 823                 ?                   00:02:05 /bin/xxx
```

## Monitor host with cAdvisor
- ### Run command
```bash
docker run \
--detach=true \
--volume=/:/rootfs:ro \
--volume=/var/run:/var/run:rw \
--volume=/sys:/sys:ro \
--volume=/var/lib/docker/:/var/lib/docker:ro \
--publish=8000:8080 \
--privileged=true \
--name=cadvisor \
google/cadvisor:latest
```
- ### Access to http://localhost:8000

## Observe history of docker image
```bash
docker history <image>:<tag> -H --no-trunc --format '{{.CreatedBy}}'
```

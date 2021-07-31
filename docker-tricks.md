# Docker trick

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

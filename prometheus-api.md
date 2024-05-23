# Prometheus API

### Check Prometheus status
```bash
http://localhost:9090/api/v1/query?query=up
```
```json
{
    "status": "success",
    "data": {
        "resultType": "vector",
        "result": [
            {
                "metric": {
                    "__name__": "up",
                    "instance": "uptime-kuma:3001",
                    "job": "uptime"
                },
                "value": [
                    1716406929.82,
                    "1"
                ]
            }
        ]
    }
}
```

### Query uptime-kuma monitor status
```bash
http://localhost:9090/api/v1/query?query=monitor_status{monitor_name=~"git.util4dev.xyz|demo test"}
```
```json
{
    "status": "success",
    "data": {
        "resultType": "vector",
        "result": [
            {
                "metric": {
                    "__name__": "monitor_status",
                    "instance": "uptime-kuma:3001",
                    "job": "uptime",
                    "monitor_hostname": "null",
                    "monitor_name": "demo test",
                    "monitor_port": "53",
                    "monitor_type": "http",
                    "monitor_url": "https://google.com"
                },
                "value": [
                    1716423996.189,
                    "1"
                ]
            },
            {
                "metric": {
                    "__name__": "monitor_status",
                    "instance": "uptime-kuma:3001",
                    "job": "uptime",
                    "monitor_hostname": "null",
                    "monitor_name": "git.util4dev.xyz",
                    "monitor_port": "null",
                    "monitor_type": "http",
                    "monitor_url": "https://git.util4dev.xyz/"
                },
                "value": [
                    1716423996.189,
                    "0"
                ]
            }
        ]
    }
}
```

### Query range with rule
```bash
http://localhost:9090/api/v1/query_range?query=monitor_status{monitor_name=%22demo%20test%22}&start=1716420484.395&end=1716424084.394&step=14
```
```json
{
    "status": "success",
    "data": {
        "resultType": "matrix",
        "result": [
            {
                "metric": {
                    "__name__": "monitor_status",
                    "instance": "uptime-kuma:3001",
                    "job": "uptime",
                    "monitor_hostname": "null",
                    "monitor_name": "demo test",
                    "monitor_port": "53",
                    "monitor_type": "http",
                    "monitor_url": "https://google.com"
                },
                "values": [
                    [
                        1716420484.395,
                        "1"
                    ],
                    //...
                ]
            }
        ]
    }
}
```

### Get targets
```bash
http://localhost:9090/api/v1/targets
```
```json
{
    "status": "success",
    "data": {
        "activeTargets": [
            {
                "discoveredLabels": {
                    "__address__": "uptime-kuma:3001",
                    "__metrics_path__": "/metrics",
                    "__scheme__": "http",
                    "__scrape_interval__": "30s",
                    "__scrape_timeout__": "10s",
                    "job": "uptime"
                },
                "labels": {
                    "instance": "uptime-kuma:3001",
                    "job": "uptime"
                },
                "scrapePool": "uptime",
                "scrapeUrl": "http://uptime-kuma:3001/metrics",
                "globalUrl": "http://uptime-kuma:3001/metrics",
                "lastError": "",
                "lastScrape": "2024-05-23T10:41:32.506241132Z",
                "lastScrapeDuration": 0.130893469,
                "health": "up",
                "scrapeInterval": "30s",
                "scrapeTimeout": "10s"
            }
        ],
        "droppedTargets": []
    }
}
```

### Querying label names
```bash
http://localhost:9090/api/v1/labels
```
```json
{
    "status": "success",
    "data": [
        "__name__",
        "instance",
        "job",
        "kind",
        "le",
        "major",
        "minor",
        "monitor_hostname",
        "monitor_name",
        "monitor_port",
        "monitor_type",
        "monitor_url",
        "patch",
        "space",
        "type",
        "version"
    ]
}
```

### Querying label values
```bash
http://localhost:9090/api/v1/label/monitor_name/values
```
```json
{
    "status": "success",
    "data": [
        "common services",
        "demo test",
        "git.util4dev.xyz",
        "test"
    ]
}
```

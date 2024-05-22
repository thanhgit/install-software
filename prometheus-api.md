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

# Install openclaw

#### Setup using http
```json
gateway": {
    "port": 18789,
    "mode": "local",
    "bind": "custom",
    "customBindHost": "192.168.1.35",
    "controlUi": {
      "allowInsecureAuth": true,
      "dangerouslyDisableDeviceAuth": true,
      "allowedOrigins": [
        "http://localhost:18789",
        "http://127.0.0.1:18789",
        "http://192.168.1.35:18789"
      ]
    },
    "auth": {
      "mode": "token",
      "token": "9673dbdb58a89ae4aa99cda1d4bc39608d66076e28dcf91b"
    },
    "tailscale": {
      "mode": "off",
      "resetOnExit": false
    },
    "remote": {
      "url": "wss://192.168.1.35:18789",
      "token": "8b2dc910d531d5ce13f781a23a22ea0d7d5c027070dbe0f2"
    }
  },
```

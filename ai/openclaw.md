# Install openclaw

## Flow hệ thống
1. User chat qua OpenClaw
2. → API Gateway xác thực
3. → Agent Router chọn agent
4. → Agent (LangGraph) xử lý reasoning
5. → truy cập memory
6. → gửi task qua message bus
7. → n8n / worker thực thi
8. → trả kết quả ngược lại

```
                ┌────────────────────────────┐
                │        Chat Layer          │
                │   (OpenClaw / Slack UI)   │
                └────────────┬──────────────┘
                             │
                             ▼
                ┌────────────────────────────┐
                │     API Gateway Layer      │
                │  Auth / Rate Limit / RBAC  │
                └────────────┬──────────────┘
                             │
                             ▼
                ┌────────────────────────────┐
                │   Agent Router / Registry  │
                │  - Agent discovery         │
                │  - Task routing            │
                │  - Load balancing          │
                └────────────┬──────────────┘
                             │
        ┌────────────────────┼────────────────────┐
        ▼                    ▼                    ▼
┌───────────────┐   ┌────────────────┐   ┌────────────────┐
│ LangGraph     │   │ LangGraph      │   │ LangGraph      │
│ Agent A       │   │ Agent B        │   │ Agent C        │
└──────┬────────┘   └──────┬─────────┘   └──────┬─────────┘
       │                   │                    │
       └──────────┬────────┴──────────┬─────────┘
                  ▼                   ▼
        ┌────────────────────────────────────┐
        │        Shared Memory Layer         │
        │  - Redis (short-term state)        │
        │  - Vector DB (semantic memory)     │
        │  - Postgres (long-term data)       │
        └────────────┬───────────────────────┘
                     │
                     ▼
        ┌────────────────────────────────────┐
        │     Message Bus / Event Stream     │
        │   (Kafka / Redis Streams / NATS)   │
        └────────────┬───────────────────────┘
                     │
                     ▼
        ┌────────────────────────────────────┐
        │        Execution Layer             │
        │     (n8n + Worker Services)        │
        └────────────┬───────────────────────┘
                     │
                     ▼
        ┌────────────────────────────────────┐
        │     External Tools / Systems       │
        │  APIs / DB / SaaS / Internal svc   │
        └────────────────────────────────────┘
```

#### 1. Chat Layer (entry point)
* User gửi: command / natural language request

👉 Vai trò:
* UI + ChatOps control
* trigger toàn bộ hệ thống

#### 2. API Gateway
* Auth (JWT / SSO)
* RBAC (ai được gọi agent nào)
* Rate limit (tránh spam AI = cháy tiền)
* Request validation

👉 Gợi ý:
* Kong / Nginx / AWS API Gateway

#### 3. Agent Router / Registry (não điều phối)
👉 Đây là phần nhiều người bỏ qua nhưng cực quan trọng:

Chức năng:

* quản lý danh sách agent
* mapping:
  * “task → agent phù hợp”
* load balancing
* fallback logic

Ví dụ:
* “viết report” → agent writing
* “phân tích dữ liệu” → agent analytics

#### 4. Agent Layer (LangGraph)
Mỗi agent:
* có role riêng
* có tool riêng
* có state machine riêng

👉 Ví dụ:
* Research Agent
* Coding Agent
* Finance Agent

#### 5. Shared Memory Layer (CỰC QUAN TRỌNG)
Nếu thiếu cái này → không phải multi-agent thật

Bao gồm: **Redis** + session memory + cache nhanh

**Vector DB**:
* semantic search
* long-term memory (RAG)

**Postgres**
* structured data
* audit / history

#### 6. Message Bus (xương sống async)
👉 Cho phép:
* agent giao tiếp
* event-driven system
* scale lớn

Gợi ý:
* Kafka (enterprise)
* NATS (nhẹ, nhanh)
* Redis Streams (đơn giản)

#### 7. Execution Layer = n8n + worker services
👉 Là nơi: gọi API + chạy job + automation workflow

⚠️ Lưu ý:
* n8n nên dùng cho orchestration nhẹ
* job nặng → worker riêng (Python / Node)

#### 8. Observability (bắt buộc thêm)
Bạn nên gắn thêm:
* Logging: ELK / Loki
* Metrics: Prometheus + Grafana
* Tracing: OpenTelemetry

👉 Debug multi-agent nếu không có cái này = ác mộng 😅

#### 🔐 Governance Layer (cross-system)
Chạy xuyên suốt:
* RBAC
* Audit logs
* Cost tracking (token usage)
* Secrets management


## Debug
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

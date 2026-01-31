# LLM manager
- #### Một hệ thống mạnh mẽ = **AI** + **sự giám sát của con người** trong quy trình làm việc => tự động hóa có giám sát cho các quyết định kinh doanh quan trọng
- #### Các AI agent là `các hệ thống vận hành dựa trên dữ liệu`, cụ thể như sau:
  * Cá nhân hóa
  * Suy luận nhanh
  * Trí nhớ có context
  * Hành động theo realtime data
  * Khả năng học hỏi từ quá khứ

![image](https://github.com/user-attachments/assets/bb40f4e0-bf18-45f5-a3f9-fc824f9f1a08)

### 5 key data assets that power the smartest AI agents
![image](https://github.com/user-attachments/assets/a95f1f8a-1f97-4057-891d-3d69d37f6a78)

#### 1. **Prompt Manager** – *Cá nhân hóa theo thời gian thực*
* **Dữ liệu sử dụng:** user profile API
* **Tác dụng:** Giúp AI hiểu ngữ cảnh người dùng mà vẫn bảo mật
* **Tính chất nổi bật:**
  * Tuân thủ GDPR
  * Độ trễ < 250ms
  * Tạo prompt cá nhân hóa sâu, tránh trả lời chung chung

#### 2. **LLM Reasoning** – *Xử lý phản hồi nhanh và quy mô lớn*
* **Dữ liệu sử dụng:** Endpoint mô hình suy luận độ trễ thấp
* **Tác dụng:** Tăng tốc quá trình “suy nghĩ” của AI
* **Tính chất nổi bật:**
  * Độ trễ P99 < 300ms, kể cả khi tải cao
  * Caching tại biên, gần người dùng
  * Khả năng mở rộng cao, không bị nghẽn

#### 3. **Context and Memory** – *Nhớ và hiểu đúng context*
* **Dữ liệu sử dụng:** Vector DB / Knowledge Graph
* **Tác dụng:** Cải thiện độ chính xác, giảm sai lệch
* **Tính chất nổi bật:**
  * Tìm kiếm gần đúng (ANN) < 50ms
  * Dựa trên embeddings và dữ liệu chuyên ngành
  * Giảm khoảng 30% “ảo tưởng” (hallucination)

![image](https://github.com/user-attachments/assets/0033204b-284d-49d1-aeae-c1221eff33dc)
#### 4. **Tool Orchestrator** – *Hành động đúng lúc với dữ liệu thời gian thực*
* **Dữ liệu sử dụng:** Feed tồn kho và giá cả theo thời gian thực
* **Tác dụng:** Giúp AI ra quyết định chính xác ngay lập tức
* **Tính chất nổi bật:**
  * Cập nhật dưới 1 giây
  * Giao hàng chính xác 1 lần (exactly-once)
  * Ngăn chặn bán trùng hoặc lỗi do cập nhật chậm

#### 5. **Action / Output** – *Học hỏi từ mỗi phản hồi đã đưa ra*
* **Dữ liệu sử dụng:** Interaction logs không thể thay đổi
* **Tác dụng:** Mỗi phản hồi được lưu lại để cải thiện AI
* **Tính chất nổi bật:**
  * Có version, audit rõ ràng
  * Ghi log theo luồng thời gian thực
  * Dữ liệu đầu vào cho việc tinh chỉnh RAG

---
### AI agent ↔ Workflow
Workflow chính là policy đã hội tụ (converged policy)
| RL           | AI system của bạn                              |
| ------------ | ---------------------------------------------- |
| Environment  | Data / user / hệ thống                         |
| State (S)    | Context state đã chuẩn hóa                     |
| Action (A)   | Tool call / response / decision                |
| Reward (R)   | Outcome (success, cost, latency, user signal…) |
| Policy π     | Logic quyết định                               |
| Exploration  | AI agent reasoning                             |
| Exploitation | Workflow / rule engine                         |

Trong AI agent (LLM):
* Exploration là semantic exploration
* Dựa trên: prior knowledge / reasoning / latent pattern

Chu trình chuyển đổi:
```
Exploration phase (AI agent)
   ↓
Log (state, decision, outcome)
   ↓
Policy distillation
   ↓
Exploitation phase (workflow)
   ↓
Exception / drift detected
   ↓
Quay lại exploration
```

Điều kiện policy hội tụ:
```
P(action | state) > 0.9
  AND variance(action | state) < ε
  AND reward ổn định trong N samples
```
* Đơn giản là, cùng state → cùng action ≥ 80–90%
* outcome không xấu đi

---
### Tư duy khung: Context → Decision → Rule
| Tầng          | Đặc điểm      | Xử lý               |
| ------------- | ------------- | ------------------- |
| Deterministic | Luôn đúng     | Workflow cứng       |
| Heuristic     | Đúng phần lớn | Rule + fallback AI  |
| Exploratory   | Mơ hồ         | Context engineering |

AI agent tiến hóa thành workflow engine
```
Data Context
   ↓ (diễn giải có kiểm soát)
Context State <-> [Context Builder]
   ↓ (suy đoán có căn cứ)
Decision Hypothesis
   ↓ (xác nhận bằng log / outcome)
[Decision Layer]
   ├─ Rule Engine (từ log đã cứng hóa)
   └─ AI Reasoner (fallback / edge case)
   ↓
Workflow Step
   ↓
[Outcome Logger]
   ↺ (feedback loop)
```

Dấu hiệu đã “đủ căn cứ để chuẩn hóa”:
1. Nếu cùng context state, agent có luôn ra cùng quyết định không?
2. Có mô tả được quyết định bằng IF–THEN không dùng từ mơ hồ?
3. Có log chứng minh rule đó đúng trong >X% case?
4. Có fallback khi rule fail?
5. Người khác đọc rule có hiểu mà không cần hiểu prompt gốc?

#### Chuẩn hóa Context: biến “ngữ cảnh mơ hồ” thành “state có cấu trúc”
* 👉 Context = tập hợp state
  ```json
  {
    "input_data": {...},
    "historical_memory": {...},
    "user_intent": "X",
    "constraints": ["time", "policy", "cost"],
    "confidence_level": 0.82
  }
  ```

* Context phải có điều kiện rõ ràng ~ có thể kiểm tra logic:
  * user_intent = ask_info (hỏi thông tin)
  * data_confidence > 0.8
  * tool_available = true

#### Log để suy ngược được logic
* Làm căn cứ để chuẩn hóa thành workflow 
  ```json
  {
    "context_state": {...},
    "reasoning_trace": [ // ~ logic quan sát được
      "X được suy ra từ Y",
      "Điều kiện A thỏa mãn"
    ],
    "decision": "call_tool_A",
    "confidence": 0.87,
    "outcome": "success"
  }
  ```
* Người đề xuất chuẩn hóa cần trả lời được 3 câu hỏi:
  * Vì sao agent làm thế?
  * Trong điều kiện nào thì agent luôn làm vậy?
  * Nếu bỏ AI đi, rule nào thay thế được?

#### Từ suy đoán → xác định: kỹ thuật “Rule Extraction”
* Gom nhóm decision theo context:
  * 83% trường hợp có:
    * user_intent = lookup and data_confidence > 0.75 and tool_latency < 2s
    * Quan sát → agent luôn gọi tool A
  * 👉 Đây là pattern ổn định

* Chuyển pattern thành rule:
  ```
  IF user_intent == "lookup"
    AND data_confidence > 0.75
    AND tool_latency < 2s
  THEN call_tool_A
  ```
  * => workflow bắt đầu hình thành





























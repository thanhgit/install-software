# Cách dùng AI-OPS giải quyết sự có

**Quy trình xử lý sự cố:**
* Tại sao có sự cố?
  ```
  POST /payment
        ↓
  payment-api
        ↓
  server-03
        ↓
  error rate 41%
        ↓
  server-01/02 healthy
  ```
* Nơi nào có thể can thiệp
  ```
  server-03
     ↓
  Load Balancer
     ↓
  drain supported
     ↓
  capacity sufficient
  ```
* Nên làm gì tiếp theo
  ```
  → Drain server-03
  ```

https://strategizeyourcareer.com/p/write-a-postmortem-like-a-senior
https://strategizeyourcareer.com/p/why-most-engineers-fail-at-knowledge

### AI-Ops là gì 

<img width="965" height="439" alt="image" src="https://github.com/user-attachments/assets/01f53c0f-9e27-47bb-a703-40e993324ccf" />

<img width="1035" height="672" alt="image" src="https://github.com/user-attachments/assets/1ec0c783-bc33-4bf9-b73e-36cc71298e98" />

<img width="1217" height="712" alt="image" src="https://github.com/user-attachments/assets/99375e3f-835c-481d-824f-62e0d667b55f" />

#### Biểu đồ phân tích về nghịch lý trong vận hành
<img width="1325" height="520" alt="image" src="https://github.com/user-attachments/assets/fe88f9d3-0f9f-4de0-85ef-23911f1cd057" />

```
Chuẩn bị dữ liệu đầu vào thật tốt

Chọn một metric có thể giám sat một cách tự động, đánh giá sự cải thiện nó
VD: mean time to restore

Luôn luôn có kế hoạch dự phòng trong trường hợp AI xử lý sai 
```

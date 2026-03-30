# Quy trình hướng trách nhiệm
* **Reward** → success
* **Accountability** → bottleneck + upstream + designer nếu cần
* **Learning** → cập nhật hệ thống để giảm lỗi lặp lại

Dựa trên nguyên tắc:
* Tư duy trách nhiệm (Ai làm gì, đạt mục tiêu gì) phải có TRƯỚC
* Phân định trách nhiệm (Từng bước cụ thể) phải làm TRONG KHI viết quy trình
* Văn hóa trách nhiệm (Cam kết thực hiện) được hình thành SAU KHI vận hành
* Tập trung vào "Tối ưu hóa tổng thể" thay vì "Tối ưu hóa cục bộ"
* Sử dụng ma trận RACI 
```mermaid
flowchart TD
    %% Nodes
    A[Requester tạo request] --> B[Operator xử lý request]
    B --> C{Bottleneck kiểm soát / approve?}
    C -->|Success| D[Quy trình thành công]
    D --> E[Sharing bonus cho tất cả]
    
    C -->|Exception| F[Bottleneck giải trình]
    F --> G{Nguyên nhân?}
    
    G -->|Input / Upstream| H[Bước trước bottleneck giải trình]
    G -->|Operator lỗi| I[Bottleneck phạt / corrective action]
    G -->|System design lỗi| J[Designer giải trình / update system]
    
    H --> F
    I --> K[Learning / cập nhật guideline / rule]
    J --> K
    K --> B
    
    %% Notes
    classDef success fill:green,stroke:#155724,stroke-width:2px;
    classDef exception fill:black,stroke:#721c24,stroke-width:2px;
    classDef accountability fill:black,stroke:#856404,stroke-width:2px;

    class D,E success
    class F,H,I,J exception
    class K accountability
```


### Giải thích workflow:
B1. **Requester** tạo request → **Operator** xử lý

B2. **Bottleneck** kiểm soát request:
   * Nếu **thành công** → tất cả nhận **sharing bonus**
   * Nếu **exception** → bottleneck **giải trình**

B3. **Nguyên nhân exception**:
   * **Input / Upstream lỗi** → bước trước bottleneck phải giải trình
   * **Operator lỗi** → bottleneck phạt / corrective action
   * **System design lỗi** → designer giải trình, cập nhật system

B4. **Learning / Feedback loop**:
   * Rule, guideline, template được cập nhật → quay lại operator xử lý request mới

---
## Áp dụng vào ChatOps, giúp:
* **Accountability rõ ràng** → leader (system designer) chịu trách nhiệm rule/template/compliance
* **Throughput cao** → junior/senior operator vận hành trực tiếp, AI giúp lọc & điều phối
* **Minh bạch + traceability** → mọi hành động, exception, giải trình đều có log trong chat

**Human, reward & accountability**,
* **Junior Operator**: làm các task tần suất cao, rule đơn giản → AI điều phối, chỉ log
* **Senior Operator**: làm task khó, AI gợi ý corrective action
* **Leader / System Designer**: approve exceptions lớn, cập nhật rule/template, quyết định compliance
* **AI**: routing → monitoring → gợi ý learning → ghi log → tính bonus

### 🧩 Vai trò trong ChatOps

| Vai trò                      | Mô tả                                                  | Quyền / Responsibility                                                                                      |
| ---------------------------- | ------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------- |
| **Leader / System Designer** | Cập nhật rule, template, compliance; quyết định policy | - Chịu trách nhiệm cuối cùng cho rule/template <br> - Giải trình khi bottleneck fail liên quan đến thiết kế |
| **Senior Operator**          | Thực hiện task phức tạp, mentor junior                 | - Xử lý request theo rule <br> - Giải trình nếu xảy ra exception trong phạm vi họ kiểm soát                 |
| **Junior Operator**          | Thực hiện task đơn giản / tần suất cao                 | - Thực hiện theo hướng dẫn <br> - Không chịu phạt nếu tuân thủ rule                                         |
| **AI / Chatbot**             | Điều phối task, lọc request, gợi ý hành động           | - Xử lý rule-based routing <br> - Gợi ý corrective action <br> - Log, monitor exception                     |

### 🔄 Workflow ChatOps
```mermaid
flowchart TD
    %% Nodes
    A[Requester gửi request vào ChatOps] --> B[AI phân loại & routing request]
    B --> C{Task type?}
    
    %% Junior task
    C -->|Simple / low-risk| D[Junior Operator xử lý]
    D --> E{Task thành công?}
    E -->|Yes| F[AI ghi log & trigger sharing bonus cho team]
    E -->|No| G[Exception → Senior Operator xử lý & giải trình]
    
    %% Senior task
    C -->|Complex / high-risk| H[Senior Operator xử lý]
    H --> I{Task thành công?}
    I -->|Yes| F
    I -->|No| J[Exception → Bottleneck / Leader giải trình & corrective action]
    
    %% Leader / System Designer
    J --> K[Leader/System Designer kiểm tra, cập nhật rule/template/compliance]
    K --> B
    
    %% Feedback / learning
    F --> L[AI ghi pattern, cập nhật template / rule nếu cần]
    L --> B
    
    %% Notes / styling
    classDef success fill:green,stroke:#155724,stroke-width:2px;
    classDef exception fill:#red,stroke:#721c24,stroke-width:2px;
    classDef aiNode fill:blue,stroke:#004085,stroke-width:2px;
    classDef accountability fill:#fff3cd,stroke:#856404,stroke-width:2px;

    class F,L success
    class G,J,K exception
    class B aiNode
```
B1. **Requester gửi request vào group chat**

B2. **AI agent**:
* Phân loại request
* Gửi đến operator phù hợp (junior/senior):
    * Simple → Junior
    * Complex → Senior
* *Nếu cần approval* → gửi đến bottleneck (senior hoặc leader nếu rule phức tạp)

B3. **Operator xử lý request** trong chat,
* AI agent ghi log mọi hành động
* Nếu thành công → AI ghi log & chia bonus cho team
* Nếu exception → Senior/Bottleneck giải trình

B4. **Bottleneck / Leader / System Designer**:
* kiểm tra exception → giải trình → cập nhật rule/template/compliance (*nếu cần*)
* Trả lại workflow cho AI để tiếp tục vận hành

B5. **Sharing bonus / reward**: nếu task thành công → AI thông báo chia thưởng

B6. **Learning loop**:
* Ghi lại pattern
* Gợi ý cải tiến rule/template
* Giúp hệ thống thông minh hơn, giảm lỗi lặp lại

### ⚡ Ưu điểm của mô hình này
* **Throughput cao**:
    * AI giảm workload bottleneck
    * → operator tập trung vào task thực sự cần con người
* **Accountability rõ ràng**:
    * leader/ bottleneck chịu trách nhiệm rule/template
    * operator chỉ thực hiện
* **Traceability**:
    * mọi request, quyết định, exception được ghi trong chat
    * → dễ audit
* **Feedback real-time**:
    * AI gợi ý corrective action
    * → rút ngắn learning loop
* **Scalable**:
    * junior/senior tăng số lượng request mà không tăng bottleneck quá nhiều

### ⚠️ Một vài điểm cần chú ý
P1. **Bottleneck không bị overload**
* Rule phức tạp → tất cả phải đi qua leader → chậm
* Giải pháp: **multi-layer bottleneck** (senior first, leader chỉ approve edge-case)

P2. **Quality của input / chat logs**
* Operator phải follow template → AI mới tự động xử lý, gợi ý
* Nếu input sai → bottleneck vẫn phải giải trình → tạo friction

P3. **AI orchestration**
* AI cần có:
   * routing, logging, exception detection, alerting
   *  gợi ý corrective action
* Nếu AI yếu → **bottleneck sẽ lại quá tải**

P4. **Incentive design**
* Sharing bonus nên phản ánh cả **throughput + success rate + compliance**
* **không chỉ success đơn thuần**
















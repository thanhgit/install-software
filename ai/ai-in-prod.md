# AI trong môi trường production

<img width="1190" height="482" alt="image" src="https://github.com/user-attachments/assets/72692768-0fc8-45e1-9756-0c81008321e4" />

#### Tool calling
`Yêu cầu`:
* 100-1000x more concurrent executions
* <500ms latency for real-time workflows
* Zero-downtime updates to tool inventory

1. Async Task Queues - Hàng đợi tác vụ bất đồng bộ
* Công cụ gửi lệnh đến Kafka/RabbitMQ
* Worker xử lý theo nguyên tắc ai đến trước được phục vụ trước (hoặc ưu tiên VIP)

2. Smart Throttling - Điều chỉnh thông minh
* Dành 20% dung lượng cho các công cụ quan trọng (ví dụ: xác thực, thanh toán, ...)
* Xử lý hàng loạt (batching) các task không khẩn cấp (ví dụ: cập nhật CRM hàng đêm, ...)

3. Execution Pools
* Thiết lập các tool được gọi nhiều ở chế độ sẵn sàng cao như hot-start hoặc warm-start (sau vài phút chưa có request) (tra cứu hồ sơ người dùng, ...)
* Cô lập các tool không ổn định để ngăn ngừa lỗi lan truyền

<img width="852" height="508" alt="image" src="https://github.com/user-attachments/assets/a2e1247e-5fc4-41ba-90b8-d55a9055c812" />

#### Memory ~ cân bằng giữa speed, cost, and accuracy:

Short-term context (active conversation history)
  * `Real-Time Recall Layer`:
  * -> Use a fast in-memory store (like Redis) for real-time context
  * -> it keeps sessions snappy even during traffic spikes
  
Long-term personalization (user preferences, historical interactions)
  * `Persistent Memory Layer`
  * -> A vector-capable database (like Pinecone)
  * -> lưu trữ lịch sử người dùng chi tiết mà không làm chậm các tương tác trực tiếp
  
Enterprise knowledge (product specs, compliance rules)
  * `Governance Controls`
  * -> Auto-expire old data and enforce access controls
  * -> this keeps systems lean and audit-ready

<img width="1392" height="825" alt="image" src="https://github.com/user-attachments/assets/f9f5b732-5e08-41f7-a1d4-f9631264e98c" />

#### Decision Making

`Yêu cầu`:
* AI agent phải ra quyết định nhanh và đáng tin cậy trong môi trường prod
* Cân bằng logic, business rules và cập nhật tri thức (realtime-data)

Nếu thiết kế không đúng sẽ dẫn đến:
* Inconsistent outputs (e.g., approving invalid transactions)
* Bottlenecks (slow API calls blocking decisions)
* Compliance risks (violating regulations due to missing guardrails

#### Agentic patterns

| **MẪU**                  | **KHI SỬ DỤNG**                                                                                                                                                           | **CÁC TRƯỜNG HỢP SỬ DỤNG / VÍ DỤ**                                                         |
| ------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------ |
| **Chuỗi xác định** <br>DeterministicChain       | - Luồng nhiệm vụ cố định, có thể lặp lại  <br> - Cần có khả năng kiểm toán cao <br> - Độ trễ thấp và đầu ra có thể dự đoán được <br> - Logic hiếm khi thay đổi <br> - Giúp kiểm soát chặt chẽ hành vi AI          | - Bot câu hỏi thường gặp <br> - Tuân thủ quy trình công việc <br> - RAG pipeline cơ bản   |
| **Hệ thống đại lý đơn** <br>Single-Agent System  | - Các truy vấn khác nhau trong một domain duy nhất <br> - Cần lý giải hoặc thử lại <br> - Tìm kiếm sự linh hoạt mà không phức tạp <br> - Độ tinh tế vừa phải                | - Trợ lý bộ phận trợ giúp <br> - Công cụ AI nội bộ <br> - Công cụ điền biểu mẫu thông minh |
| **Hệ thống đa tác nhân** <br>Multi-Agent System | - Bao gồm các business domain đa dạng <br> - Logic/context chuyên biệt cho mỗi task <br> - Cần kiến trúc mô-đun, có thể mở rộng <br> - Phân chia vai trò rõ ràng <br> - Phù hợp cho các doanh nghiệp lớn cần giải quyết nhiều nhiệm vụ song song, với các agent chuyên biệt | - Nền tảng Enterprise AI <br> - AI copilots <br> - AI-powered CRMs     |

#### Rủi ro bảo mật từ LLM 

Ba loại tấn công phổ biến:
* Evasion Attacks
* Poisoning Attacks
* Privacy Attacks

Cụ thể, `Indirect Prompt Injection`
* kẻ tấn công giấu lệnh trong dữ liệu đầu vào mà người dùng không biết
* => `dẫn đến rò rỉ dữ liệu, quyết định sai, hoặc hành vi trái phép của hệ thống`

Các nguyên tắc bảo mật:
* Về tính sẵn sàng, bảo mật và toàn vẹn như:
  * Phân tích log, giám sát thiết bị
  * Quản lý danh tính, kiểm soát truy cập, chứng thực đa yếu tố (MFA),
  * Phân đoạn vi mô, mã hóa, và giám sát liên tục
  * ...
* => zero trust ~ `không nên tin tưởng hoàn toàn vào đầu ra của model` => `triển khai generative AI an toàn`

Zero Trust, dựa trên ba nguyên tắc cốt lõi:
* Xác thực và phân quyền liên tục
* Nguyên tắc quyền tối thiểu
* `Không tin tưởng mặc định` – luôn giả định có rủi ro từ bên trong lẫn bên ngoài hệ thống

Rủi ro đặc thù của AI, như:
* Bảo vệ trọng số mô hình, data huấn luyện, và tham số hệ thống => `tránh bị truy cập trái phép`
* Giám sát data đầu vào, đầu ra và pipeline huấn luyện => `để phát hiện hoạt động bất thường`
* Chống lại các hình thức tấn công như Evasion, Poisoning, và Privacy Attacks

<img width="779" height="913" alt="image" src="https://github.com/user-attachments/assets/cc33ab56-4e99-4bad-aaa8-c01ac388333d" />

#### Hệ thống đề xuất







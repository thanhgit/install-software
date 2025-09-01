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

#### Thiết kế hệ thống đề xuất
* Không nên tin tưởng tuyệt đối vào các hệ thống LLM
* Kkhông khuyến khích vận hành hoàn toàn tự động mà không có giám sát của con người
* Bởi `giám sát và kiểm tra bởi con người` + `giới hạn rõ ràng quyền tự động` => `đảm bảo tính minh bạch và kiểm soát.`

LLM an toàn cần tuân thủ các nguyên tắc bảo mật từ khâu chọn mô hình nền đến cấu trúc hệ thống triển khai

* **Model card** là tài liệu đi kèm với nhiều LLM
 * mô tả thông tin về chức năng, dữ liệu huấn luyện, tuân thủ pháp lý và đánh giá rủi ro (bao gồm Prompt Injection)
 * `Việc chọn mô hình nền phù hợp` là bước quan trọng vì lỗi trong huấn luyện (dữ liệu độc hại, thiên lệch...) có thể gây rò rỉ dữ liệu và hành vi không an toàn

* `Đánh giá và chuẩn bị dữ liệu huấn luyện kỹ lưỡng` là cần thiết nhưng khó thực hiện do khối lượng lớn và dữ liệu thường không công khai

* Hệ thống hoạt động cần có giám sát liên tục
 * Với cơ chế **kiểm soát truy cập, authN, authZ**
 * Các yếu tố kỹ thuật khác như PKI, logging, IAM...
  
* Cân bằng giữa giảm thiểu rủi ro từ **Poisoning, Evasion và Privacy Attacks** và đảm bảo tính khả dụng và dễ sử dụng trong việc áp dụng **Nguyên tắc Zero Trust**

* Mỗi nguyên tắc bảo mật được trình bày theo cấu trúc: mô tả tổng quan → kịch bản rủi ro → biện pháp giảm thiểu đề xuất

---
### Authentication & Authorization trong LLM Systems

* **Xác thực (Authentication)** và **phân quyền (Authorization)** là **nền tảng bảo mật** trong hệ thống LLM
* => đảm bảo **chỉ những người dùng và tác nhân hợp lệ mới có quyền truy cập** và thực thi các hành động tương ứng
* Mỗi tương tác – giữa người dùng, agent, LLM và các thành phần hệ thống – **phải được xác minh và cấp quyền rõ ràng**, với thời gian tin cậy giới hạn.

> **Không nên tin tưởng mặc định bất kỳ tác nhân nào trong hệ thống LLM**
> 
> Mọi truy cập, tương tác và hành động đều cần được kiểm soát, xác thực, và giới hạn theo ngữ cảnh và vai trò
>
> Việc bảo mật thành công hệ thống LLM không chỉ là kỹ thuật, mà còn là thiết kế nguyên tắc và quy trình vận hành đúng đắn.


⚠️ **Các rủi ro bảo mật điển hình**

1. **Truy cập ngoài phạm vi nhiệm vụ:**
   LLM kết nối RAG có thể bị khai thác bởi người dùng tạo prompt truy vấn vượt ngoài phạm vi được phép nếu không có cơ chế phân quyền chặt chẽ.

2. **Leo thang đặc quyền:**
   Các chức năng mở rộng có thể cho phép người dùng thao tác dữ liệu vượt quá quyền hạn ban đầu, dẫn đến rủi ro Prompt Injection và sửa đổi trái phép.

3. **Không thu hồi quyền tạm thời:**
   Nếu quyền admin không được thu hồi sau khi hoàn tất nhiệm vụ, người dùng có thể tiếp tục truy cập và thay đổi hệ thống ngoài phạm vi cho phép.

✅ **Chiến lược giảm thiểu rủi ro**

| **Biện pháp**                                                   | **Ý nghĩa chính**                                                                                                    |
| --------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| **MFA (Xác thực đa yếu tố)**                                    | Tăng độ tin cậy bằng cách yêu cầu nhiều yếu tố để xác minh người dùng và agent.                                      |
| **Không sử dụng LLM để xác thực**                               | Tránh để LLM thực hiện chức năng xác thực, vì chúng không được thiết kế cho việc này.                                |
| **Nguyên tắc quyền tối thiểu (Least Privilege)**                | Chỉ cấp đúng và đủ quyền cho từng vai trò; mọi hành động cần nằm trong ngữ cảnh bảo mật của người dùng khởi tạo.     |
| **Kiểm soát truy cập động (Dynamic Access Control)**            | Xem xét các yếu tố như thời gian, vị trí, hành vi để phát hiện truy cập bất thường.                                  |
| **Phân quyền theo thuộc tính (Attribute-based Access Control)** | Quyền truy cập phụ thuộc vào các thuộc tính như vai trò, thời gian, loại tài nguyên... và phải được rà soát định kỳ. |
| **Giới hạn plug-in**                                            | Ngăn plugin truy cập lịch sử hội thoại trừ khi thực sự cần thiết.                                                    |
| **Giám sát liên tục**                                           | Theo dõi hoạt động hệ thống, phát hiện hành vi bất thường, hỗ trợ kiểm tra và truy vết.                              |
| **Lưu trữ & ghi log**                                           | Ghi lại mọi tương tác giữa các thành phần để dễ dàng kiểm soát và kiểm toán.                                         |
| **Hạn chế tính tự động không cần thiết**                        | Với tác vụ đơn giản, dùng workflow hoặc mã hóa trực tiếp thay vì dùng agent phức tạp.                                |
| **Kiến trúc đa tenant (Multi-Tenant)**                          | Phân chia người dùng, agent và dữ liệu theo độ nhạy cảm, kết hợp các tầng xác thực phù hợp.                          |

---
### **Input & Output Restrictions trong LLM Systems**

**Luồng dữ liệu trở thành điểm tấn công nhạy cảm nhất** bởi:

* **Prompt Injection**
* **Dữ liệu đầu vào bất thường hoặc nguy hại**
* **Hành vi không lường trước của model khi tương tác với công cụ bên ngoài**

Dẫn đến:
* **Không chỉ người dùng mà cả dữ liệu cũng có thể là "tác nhân độc hại"**
* => kiểm soát chặt chẽ mọi data vào-ra 
* Đặc biệt các công cụ bên ngoài (plug-ins, RAG, API, ...)

⚠️ **Rủi ro bảo mật điển hình**

1. **Prompt Injection qua mô tả công cụ như MCP, API, ...:**
   Một mô tả công cụ độc hại khiến LLM làm lộ dữ liệu nhạy cảm khi sử dụng công cụ bên ngoài không được kiểm soát chặt chẽ

2. **Tấn công qua hình ảnh có chứa prompt ẩn:**
   Markdown chứa hình ảnh được tự động tải về và xử lý (OCR), có thể giấu các chỉ dẫn nguy hiểm như `"Ignore all previous instructions..."`.

3. **Lạm dụng markdown để rò rỉ dữ liệu:**
   Markdown chèn link hình ảnh đến server của attacker, lợi dụng tính năng prerendering để trích xuất và gửi dữ liệu nhạy cảm mà không cần sự đồng thuận của người dùng.

✅ **Các biện pháp phòng ngừa chính**

| **Biện pháp**                            | **Ý nghĩa sâu sắc**                                                                                                                                                                          |
| ---------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Gateway kiểm soát đầu vào**            | Thiết lập "cổng kiểm tra" giữa LLM và các thành phần khác, kết hợp kiểm tra cú pháp, từ khóa, độ dài đầu vào và thuật toán học máy để phát hiện prompt lạ.                                   |
| **Tag phân loại nguồn dữ liệu**          | Gắn nhãn nguồn đầu vào để phân biệt nội dung đáng tin cậy và không đáng tin cậy, từ đó bỏ qua chỉ dẫn nguy hiểm từ nguồn bên ngoài.                                                          |
| **Trust Algorithm (Thuật toán tin cậy)** | Tính điểm tin cậy cho mỗi yêu cầu dựa trên ngữ cảnh (người dùng, thiết bị, lịch sử truy cập...), rồi đưa ra quyết định xử lý tùy theo ngưỡng xác định.                                       |
| **Kiểm soát đầu ra (Output Control)**    | Áp dụng guardrails và xác thực kết quả trước khi hiển thị hoặc thực thi. Các hành động cần được mô tả có thể xác minh, kết hợp với **Human-in-the-Loop** trong các trường hợp quan trọng.    |
| **Hạn chế tự động tải và thực thi**      | Không tự động tải hoặc thực thi nội dung từ nguồn không xác định (ví dụ: markdown image, URL). Trước khi truy cập nội dung ngoài, hệ thống phải thông báo rõ cho người dùng và xin xác nhận. |
| **LLM kiểm tra LLM**                     | Dùng một LLM thứ hai để **giải thích lệnh hệ thống** trước khi thực thi – giúp phát hiện hành vi nguy hiểm tiềm ẩn, tăng tính minh bạch và kiểm tra.                                         |

---
### 🔒 **Sandboxing trong LLM Systems**

Sandboxing là một biện pháp bảo mật **cốt lõi** trong hệ thống LLM nhằm:

* **Ngăn chặn tương tác ngoài ý muốn** giữa các thành phần hoặc với hệ thống bên ngoài.
* **Cô lập dữ liệu và hành vi** của từng phiên làm việc và từng người dùng.
* **Hạn chế rủi ro leo thang đặc quyền** hoặc khai thác lỗ hổng để chiếm toàn quyền hệ thống.

Bởi cách vận hành:
* **Không có sự cách ly → không có bảo mật**
* Khi mọi hành vi có thể được kích hoạt qua dữ liệu đầu vào => sandboxing là **yêu cầu bắt buộc**
* Việc **cách ly phiên làm việc, bộ nhớ, và môi trường triển khai** là nền tảng để chống lại các hành vi bất thường như Prompt Injection, data leakage, hay privilege escalation

⚠️ **Các rủi ro điển hình**

| **Tình huống**                              | **Nguy cơ**                                                                                                                              |
| ------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| **Vòng lặp vô hạn do mô-đun lỗi**           | Một module mới khiến LLM liên tục tự gọi lại chính nó, gây treo hệ thống.                                                                |
| **Payload độc hại thực thi trong hệ thống** | Prompt từ website độc hoặc từ agent bị nhiễm có thể khiến hệ thống thực thi mã độc, mở cửa hậu hoặc rò rỉ dữ liệu.                       |
| **Thiếu cách ly phiên (session)**           | Người dùng tải file ở phiên trước, nhưng vẫn thấy được ở phiên sau → Lỗ hổng bảo mật nghiêm trọng, đặc biệt trong môi trường dùng chung. |
| **Memory chia sẻ giữa phiên làm việc**      | Prompt Injection có thể trở thành “mã độc định cư” trong bộ nhớ của hệ thống nếu được lưu lại và dùng lại ở phiên sau.                   |

**Biện pháp giảm thiểu**

| **Biện pháp**                          | **Mục tiêu & Ý nghĩa**                                                                                                            |
| -------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **Memory Management (Quản lý bộ nhớ)** | Cách ly dữ liệu giữa các phiên & người dùng, không lưu dữ liệu trừ khi cần thiết. Dọn sạch bộ nhớ sau mỗi phiên.                  |
| **Emergency Shutdown**                 | Nếu phát hiện tấn công nguy hiểm, tắt ngay hệ thống hoặc module liên quan, đảm bảo có backup để phục hồi.                         |
| **System Isolation**                   | Hạn chế LLM truy cập Internet hoặc công cụ không đáng tin. Không để người dùng click vào link do LLM sinh ra mà chưa kiểm tra.    |
| **Session Management**                 | Tách biệt mỗi phiên làm việc bằng phiên suy luận riêng (inference session), chỉ chia sẻ thông tin thực sự cần thiết.              |
| **Context Window Sanitization**        | Không để thông tin nhạy cảm trong context window, đặc biệt nếu LLM có truy cập Internet hoặc xử lý hình ảnh.                      |
| **Environment Segregation**            | Phân biệt rõ môi trường **phát triển**, **kiểm thử** và **sản xuất** để hạn chế xử lý dữ liệu thật trong môi trường chưa an toàn. |
| **Network Segmentation**               | Chia nhỏ mạng nội bộ để giảm thiểu hậu quả nếu một phần bị tấn công.                                                              |

---
### 📊 **Giám sát, Báo cáo & Kiểm soát trong LLM Systems**

Đảm bảo hệ thống LLM vận hành:

* **An toàn**
* **Đáng tin cậy**
* **Tuân thủ quy định**
  bằng cách **quan sát liên tục**, **phát hiện rủi ro sớm**, và **đáp ứng sự cố tự động hoặc có kiểm soát**

Vì:
* **Bạn không thể bảo vệ thứ bạn không quan sát**
* => cần có khả năng **“nhìn thấy chính mình” đang bị khai thác**
* => `phản ứng một cách nhanh chóng, minh bạch, có kiểm soát`

Việc lạm dụng hệ thống, dù là **vô tình hay có chủ đích**, có thể dẫn đến:

* Hỏng dữ liệu
* Tăng chi phí vận hành
* Tổn thất uy tín và pháp lý
* => **giám sát không chỉ là một tính năng, mà là một phần thiết yếu của kiến trúc bảo mật Zero Trust**

⚠️ **Các rủi ro điển hình**

| **Tình huống**                               | **Nguy cơ**                                                                                            |
| -------------------------------------------- | ------------------------------------------------------------------------------------------------------ |
| **Lạm dụng chatbot ngoài mục đích thiết kế** | Ví dụ: dùng chatbot của chính quyền để dịch văn bản hoặc tạo email spam cá nhân hóa hàng loạt.         |
| **Tự triệu hồi liên tục (self-invocation)**  | Gây lãng phí tài nguyên tính toán, làm chậm hệ thống hoặc gây sập.                                     |
| **Lạm dụng token bởi người dùng/mã độc**     | Người dùng hoặc bot khai thác giới hạn token để gây quá tải hoặc làm tăng chi phí vận hành bất thường. |

✅ **Biện pháp giảm thiểu & kiểm soát**

| **Biện pháp**                              | **Ý nghĩa và mục tiêu**                                                                                                                                                |
| ------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Threat Detection Mechanisms**            | Phát hiện sớm các hành vi bất thường (dịch vụ bị lạm dụng, sử dụng API quá mức, brute-force) bằng giám sát hành vi đầu cuối, theo dõi tiêu thụ tài nguyên CPU/GPU/API. |
| **Automated Responses**                    | Thiết lập phản ứng tự động cho các mối đe dọa đã biết để tăng tốc độ xử lý sự cố, giảm can thiệp thủ công.                                                             |
| **Token Limits**                           | Giới hạn số token mà mỗi người dùng hoặc thiết bị có thể sử dụng để tránh lạm dụng và đảm bảo hệ thống ổn định.                                                        |
| **Logging & Analytics**                    | Lưu trữ nhật ký tương tác chi tiết để phục vụ audit, điều tra sự cố, và phát triển năng lực threat intelligence.                                                       |
| **Regular Testing**                        | Tự động kiểm tra thường xuyên để phát hiện lỗ hổng và đảm bảo hệ thống vẫn tuân thủ các chính sách bảo mật.                                                            |
| **Real-Time Monitoring & Prompt Blocking** | Giám sát yêu cầu của chatbot theo thời gian thực. Nếu có prompt đáng ngờ, chặn ngay lập tức. Hỗ trợ kiểm soát hiệu suất và ngăn chặn prompt injection/phá hoại.        |



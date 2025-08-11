# Agentic adaptive RAG
- #### Agentic Corrective + Self-Reflective RAG

#### 📌 RAG(Thế hệ Agumented Agumented)
- #### 1. `Truy vấn và Embedding (Retrieval)`: Mô hình lấy lại dữ liệu liên quan từ nguồn dữ liệu, và sau đó Vector DB lấy nó từ phần nhúng trước chỉ số.
- #### 2. `Bổ sung gợi ý (Đại lý)`: Thông tin được lấy lại hợp nhất với truy vấn và gợi ý hệ thống.
- #### 3. `Đầu ra LLM (Thế hệ)`: Một mô hình ngôn ngữ lớn sau đó hiểu được câu hỏi kết hợp và tìm lại để tạo ra phản hồi cuối cùng.

#### 📌 Đại lý AI
- #### 1. `Xử lý truy vấn`: Đại lý tiếp nhận và phân tích truy vấn của người dùng.
- #### 2. `Trí nhớ và Kế hoạch`: Tận dụng một bộ nhớ và khung kế hoạch (Phản xạ, Phản xạ) dựa trên truy vấn để tạo ra chiến lược cho câu trả lời.
- #### 3. `Cách sử dụng công cụ`: Tìm nạp dữ liệu thời gian thực qua các công cụ bên ngoài (ví dụ: Google, Mail).
- #### 4. `Thế hệ đầu ra`: Tận dụng lý luận để nâng cao câu trả lời của người dùng bằng thông tin thu thập từ các công cụ và bộ nhớ.

#### 📌 Cách sử dụng cả RAGs và AI Agents?
- #### Embedding và retrieval vector của RAG được quản lý bởi các AI agent, cho phép lựa chọn nguồn dữ liệu linh động dựa trên nhu cầu truy vấn.
- #### Các AI powered employee xây dựng trên các gợi ý tăng cường của RAG bằng cách thêm dữ liệu dựa trên kế hoạch và công cụ, cung cấp một thông tin tinh chỉnh cho LLM.

#### 🧵 Quy trình hoạt động:
- #### 1. `Truy vấn`: Truy vấn của người dùng được điều hướng đến AI agent để xử lý và điều phối
- #### 2. `Giữ chân ngữ cảnh`: Đặc vụ tận dụng bộ nhớ ngắn hạn và dài hạn để theo dõi ngữ cảnh truy vấn.
- #### 3. `Lập kế hoạch nhiệm vụ`: AI agent xác định chiến lược thu hồi và lựa chọn các công cụ phù hợp dựa trên yêu cầu truy vấn.
- #### 4. `Tìm nạp dữ liệu`: Quy trình này sử dụng các công cụ (ví dụ: tìm kiếm vector để lấy lại) để thu thập dữ liệu liên quan từ cơ sở kiến thức.
- #### 5. `Tối ưu hóa gợi ý`: AI agent kết hợp data đã truy xuất với truy vấn và gợi ý hệ thống, áp dụng lý luận cho thông tin nhập LLM.
- #### 6. `Thế hệ phản hồi`: LLM xử lý đầu vào tối ưu hóa để sản xuất và cung cấp đầu ra cuối cùng.

#### NeuroSymbolic cho suy luận trên Knowledge Graphs (KGs)
Hai thái cực: 

(1) Các phương pháp biểu tượng (symbolic), dựa trên luật, dễ hiểu và tận dụng tri thức miền, nhưng hạn chế về hiệu năng và khả năng mở rộng

(2) Các phương pháp học nhúng (embedding), có hiệu suất cao nhưng lại là “hộp đen”, thiếu khả năng giải thích

* **Module neural**: thường là mạng nơ-ron sâu dùng để sinh ra embedding cho KG.
* **Module symbolic**: sử dụng luật logic hoặc tri thức dạng quy tắc, thường là từ ontology hay nguồn chuyên gia.

Các phương pháp này có một số đặc điểm nổi bật mà các phương pháp thuần túy symbolic hoặc neural không có được:

1. **Tính dễ giải thích (Interpretability)**: Các hệ thống symbolic vốn có khả năng giải thích tự nhiên, trong khi các phương pháp embedding thường không. Tuy nhiên, các phương pháp neurosymbolic cho thấy khả năng giữ được mức độ giải thích nhất định mà không làm giảm hiệu năng đáng kể, dù một số vẫn đánh đổi hiệu năng để đạt được khả năng diễn giải.

2. **Huấn luyện có định hướng (Guided Training)**: Nhờ tích hợp tri thức từ ontology hoặc chuyên gia, các mô hình có thể tránh việc “tái học” các mẫu đã biết, từ đó dẫn đến quá trình học hiệu quả hơn, đặc biệt trong những tình huống dữ liệu hạn chế. Trong khi các phương pháp embedding cần khối lượng lớn dữ liệu huấn luyện và thường phải huấn luyện trước (pre-training) với chi phí cao, thì neurosymbolic có thể đạt hiệu quả tương tự thông qua tích hợp tri thức vào quá trình học.

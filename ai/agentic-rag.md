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

3. **Xử lý các kiểu dữ liệu ít đại diện (Underrepresented Types)**: Trong các tập dữ liệu mất cân bằng, những kiểu thực thể hoặc mối quan hệ hiếm thường khó được mô hình embedding học hiệu quả. Một số phương pháp neurosymbolic đề xuất kỹ thuật bổ sung hoặc khuếch đại KG nhằm cải thiện khả năng nhận diện và học các mẫu dữ liệu ít xuất hiện này.

4. **Tổng hợp không đồng nhất (Heterogeneous Aggregation)**: Các KG phức tạp (ví dụ trong y sinh) chứa nhiều loại nút và cạnh với cách tương tác rất khác nhau. Điều này gây khó khăn cho các phương pháp học dựa trên truyền thông tin giữa nút (message passing), đặc biệt là khi các loại nút có đặc trưng và ý nghĩa rất khác biệt. Phương pháp neurosymbolic có thể tận dụng các luật logic để biểu diễn rõ ràng các mối quan hệ giữa các loại thành phần không đồng nhất thay vì buộc mạng nơ-ron học toàn bộ từ dữ liệu.

5. **Phụ thuộc dài hạn (Long-range Dependencies)**: Nhiều GNN hiện nay gặp khó khăn trong việc học các quan hệ giữa những nút cách nhau nhiều bước (hops) do hiện tượng "oversquashing" và "oversmoothing". Trong khi đó, các luật logic có thể biểu diễn các quan hệ dài thông qua chuỗi liên kết logic. Tuy nhiên, suy luận logic trên KG lớn có thể không khả thi về mặt tính toán. Một số phương pháp neurosymbolic lai được thiết kế để khắc phục điểm yếu này bằng cách kết hợp khả năng biểu diễn của logic và hiệu năng của học sâu.

---

#### 🧠 **Ba loại suy luận được phân tích:**

### 1. **Suy luận diễn dịch (Deductive reasoning)**

* Là quá trình rút ra kết luận chắc chắn từ các tiền đề logic đúng (nếu A → B và B → C thì A → C).
* Kết luận có tính **chắc chắn và bảo toàn sự thật** nếu lập luận hợp lệ.
* LLMs gặp khó khăn với suy luận diễn dịch thực sự do bản chất **xác suất** và thiếu tính đảm bảo logic chặt chẽ.
* Điều này là **rào cản lớn** nếu muốn ứng dụng LLMs trong các hệ thống yêu cầu độ tin cậy cao.

### 2. **Suy luận quy nạp (Inductive reasoning)**

* Rút ra kết luận có xác suất cao dựa trên các quan sát cụ thể.
* Không đảm bảo tính đúng tuyệt đối nhưng **LLMs lại làm rất tốt điều này**, nhờ khả năng tổng quát hóa thống kê từ dữ liệu lớn.
* Dù chưa hiểu rõ cách chúng “nén” và “khái quát hóa” thông tin, nhưng hiệu quả là rõ ràng.

### 3. **Suy luận theo lối giả thuyết (Abductive reasoning)**

* Thu thập quan sát, đưa ra suy luận và chọn giả thuyết hợp lý nhất.
* Đây là loại suy luận linh hoạt, phản ánh cách con người thường đưa ra kết luận trong thực tế.
* Tác giả đề xuất một **hướng tiếp cận hứa hẹn**: kết hợp khả năng khớp mẫu (inductive) của LLMs với hệ thống logic hình thức (knowledge graphs) để tạo thành **vòng lặp neuro-symbolic năng động**, giúp cải thiện suy luận thực sự.

### **Neuro-Symbolic: Tích hợp symbolic knowledge vào neural systems**

* Đây là nơi **logic** gặp **học sâu**:

  * Knowledge graphs = dữ liệu có cấu trúc & quy tắc logic
  * LLMs = học cách biểu diễn và sinh ngôn ngữ theo pattern
    → **Kết hợp lại = Mô hình có thể "suy luận" một cách có định hướng hơn**

**“Suy luận diễn dịch thực sự”**, bạn vẫn cần:

* Một lớp kiểm định logic rõ ràng
* Hoặc một mô hình kết hợp giữa **neural + symbolic**

### → Giải pháp hứa hẹn: **LLM + Knowledge Graph + Logic Engine (neurosymbolic hybrid)**

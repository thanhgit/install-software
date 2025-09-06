# Làm cho AI Agent trở nên đáng tin cậy hơn nhờ Reinforcement Learning (RL)

* Hãy chắc chắn rằng bạn đã đạt hiệu suất tối đa với mô hình prompt-based
* Chỉ khi đã tối ưu prompt hết mức và thực sự cần nâng cao accuracy, tiết kiệm chi phí, giảm độ trễ
* Sau đó cân nhắc dùng RL để huấn luyện AI Agent => RL sẽ thực sự là “game changer” cho AI Agent
* => `là nền tảng để xây dựng hệ thống agent hiệu quả và đáng tin cậy`

**1. Tầm quan trọng của AI Agent**

* AI agents đang trở thành trụ cột trong tự động hóa và hệ thống tự trị.
* Việc xây dựng agent đáng tin cậy là **thách thức kỹ thuật lớn**, nhưng cực kỳ quan trọng vì:

  * Trợ lý email sai → mất niềm tin người dùng.
  * Phân tích tài chính sai → thiệt hại nghiêm trọng.
  * Hệ thống chậm → giảm năng suất.

**2. Bài học từ Kyle Corbitt tại AI Engineer World's Fair**

* Nhấn mạnh cách làm cho agent **đáng tin cậy hơn bằng Reinforcement Learning (RL)**.
* Đưa ra chiến lược vượt qua các khó khăn trong quá trình huấn luyện agent.

**3. Case study: Dự án ART·E của OpenPipe**

* Là một **trợ lý email dùng ngôn ngữ tự nhiên** để trả lời câu hỏi.
* Agent dùng 2 công cụ chính:

  * **Search Tool** – tìm email chứa từ khóa.
  * **Read Email Tool** – đọc nội dung để đưa ra câu trả lời.
* Ví dụ: "Khi nào Shari chuyển đến Portland?" → Agent tìm trong email và trả lời chính xác.

**4. Bài học then chốt:**

> "Đừng bắt đầu bằng Reinforcement Learning!"

* Đội ngũ ART·E **ban đầu không dùng RL**, mà tối ưu mô hình bằng prompt để đạt hiệu quả cao nhất trước.
* Chỉ sau đó mới cân nhắc đến RL nếu cần tối ưu thêm.

#### ⚠️ Cân nhăc trước khi traning với RL
1. **Cần kiểm tra kỹ môi trường trước khi huấn luyện RL**

   * Phải đảm bảo các **tool hoạt động đúng**, truy cập dữ liệu hợp lệ.
   * Nhiều lỗi phát sinh từ phần tích hợp ban đầu – nếu debug trong giai đoạn RL sẽ **mất thời gian, khó tìm lỗi hơn**.

2. **Prompt tốt có thể đã đủ dùng**

   * Có nhiều trường hợp chỉ cần tối ưu prompt là đã đạt yêu cầu.
   * Tránh được quy trình RL phức tạp và tốn kém nếu không cần thiết.

3. **Niềm vui khi RL thực sự vượt prompt**

   * Nếu bạn thử mọi cách với prompt mà không đạt, rồi dùng RL và **vượt cả mô hình frontier (như o3, o4)** → cảm giác "chiến thắng" rõ ràng và xứng đáng với công sức đầu tư.

#### 📈 Khi nào nên dùng RL? (Dữ liệu thực tế từ dự án ART·E)
1. **Độ chính xác (Accuracy)**

* Dùng mô hình nhỏ (Qwen 2.5 - 14B) huấn luyện bằng RL, accuracy tăng từ:

  * **90% (prompt-based o3)** → **96% (RL-based)**
* Điều này nghĩa là **60% lỗi của o3 đã được khắc phục** bằng RL — cực kỳ quan trọng cho trải nghiệm người dùng.

2. **Chi phí (Cost)**

* Giá cho 1000 lượt tìm kiếm email:

  * o3: \~\$55
  * o4-mini: \~\$8
  * RL-trained Qwen: **\~\$0.8** (!)
* → **Rẻ hơn 70 lần** so với o3, và **10 lần** so với o4-mini → cực kỳ đáng giá cho bài toán sản phẩm quy mô lớn.

3. **Độ trễ (Latency)**

* RL giúp mô hình:

  * Dùng **mô hình nhỏ hơn** nhưng hiệu quả cao.
  * **Tối ưu số lần gọi database**, nhờ học cách truy vấn hiệu quả hơn.
* Cộng thêm việc **decoding suy đoán (speculative decoding)** hoạt động tốt hơn với mô hình nhỏ → giảm trễ đáng kể, phù hợp cho ứng dụng thời gian thực (ví dụ: voice assistant, chatbot).


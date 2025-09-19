# Chunk RAG
* cho phép lọc thông tin không liên quan **ở cấp độ đoạn**, thay vì toàn văn bản
* => tăng độ chính xác và giảm sai sót 
* Cụ thể, hệ thống này phân tích từng đoạn nhỏ trong tài liệu được truy xuất
  * sử dụng LLM để xác định mức độ liên quan của từng chunk với truy vấn người dùng
  * Những đoạn không liên quan hoặc chỉ liên quan lỏng lẻo => loại bỏ **trước khi**
* Phù hợp với các tác vụ yêu cầu độ chính xác cao như suy luận nhiều bước (multi-hop reasoning) và kiểm tra sự thật (fact-checking)

1. **Loại bỏ dư thừa bằng Cosine Similarity:**

   * so sánh và loại bỏ các đoạn trùng lặp hoặc quá giống nhau trong tài liệu được truy xuất
   * => nâng cao tính đa dạng và hiệu quả trong quá trình tạo câu trả lời

2. **Multi-Meta-RAG cho truy vấn nhiều bước:**

   * Sử dụng **metadata được trích xuất bởi LLM** để filter trước
   * => truy xuất chính xác hơn với các truy vấn phức tạp yêu cầu nhiều bước suy luận

3. **Viết lại truy vấn để cải thiện truy xuất:** (**Rewrite-Retrieve-Read** )

   * Bằng cách sử dụng học tăng cường (reinforcement learning) dựa trên phản hồi từ hiệu suất của LLM (
   * => cải thiện độ chính xác của truy xuất và giảm việc lấy thông tin không liên quan

4. **Self-RAG – Tự phản hồi để cải thiện chất lượng:**

   * Truy xuất theo yêu cầu và tự phản ánh (self-reflection)
   * Cụ thể, LLM sử dụng các “reflection tokens” để tự đánh giá và chỉnh sửa kết quả tạo ra
   * => giúp giảm thông tin dư thừa và cải thiện tính chính xác của nội dung

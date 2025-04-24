# Main concepts

### Kỹ thuật thiết kế Prompt là gì?
- #### Nó tập trung vào việc xây dựng các hướng dẫn cẩn thận để hướng dẫn mô hình AI tạo ra kết quả mong muốn + `ví dụ trực tiếp được đưa ra cho AI` (CoT)
- #### Tập trung vào cấu trúc và nội dung của câu hỏi/yêu cầu
- #### Sử dụng các từ khóa và cú pháp cụ thể để hướng dẫn phản hồi
- #### Thường bao gồm các ví dụ và hướng dẫn trực tiếp
- #### Có giới hạn trong việc khắc phục các khoảng trống kiến thức cơ bản
- #### `Prompt tốt đặt câu hỏi đúng`
- #### `Nhiệm vụ đơn giản:` Các nhiệm vụ như tóm tắt văn bản hoặc trả lời câu hỏi cơ bản có thể chủ yếu dựa vào kỹ thuật thiết kế prompt

#### Kỹ thuật thiết kế Ngữ cảnh là gì? ~ `"toàn bộ môi trường mà AI hoạt động"`
- #### Nó cung cấp tất cả kiến thức nền, dữ liệu và thông tin liên quan mà AI có thể truy cập để đưa ra phản hồi có ý nghĩa => `Tạo ra một "không gian thông tin" toàn diện cho AI hoạt động`
- #### Giúp AI hiểu được bối cảnh rộng lớn hơn của vấn đề
- #### Cho phép phản hồi sâu sắc hơn, đặc biệt đối với các vấn đề phức tạp
- #### `Ngữ cảnh tốt đảm bảo AI có thông tin cần thiết để trả lời`
- #### `Nhiệm vụ phức tạp:` Các nhiệm vụ như phân tích pháp lý, tư vấn y tế, hoặc nghiên cứu khoa học đòi hỏi sự kết hợp mạnh mẽ của cả hai phương pháp, với trọng tâm đặc biệt vào kỹ thuật thiết kế ngữ cảnh.

#### `Workflows`
- #### are systems where LLMs and tools are orchestrated through predefined code paths

#### `Agents`
- #### are systems where LLMs dynamically direct their own processes and tool usage, maintaining control over how they accomplish tasks
- #### `First` understand basic LLM workflows before building AI agents,

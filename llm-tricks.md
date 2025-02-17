# LLM tricks

### ReAct pattern
- #### Đây là sự kết hợp tinh tế giữa 2 yếu tố: `Reasoning` (Khả năng suy luận của các mô hình LLM) và `Action` (Thực hiện các hành động tương tác với môi trường bên ngoài nhằm hoàn thành một tác vụ cụ thể) => ` kết hợp hài hoà giữa việc suy nghĩ và hành động`
- #### `Lợi ích`: giải quyết chính xác hơn và khả năng tự sửa chữa những lỗi sai từ các hành động trước đó.

#### `Reasoning` 
- #### Dùng Chain-of-Thought (CoT) giúp chúng thực hiện việc reasoning và giải quyết các vấn đề phức tạp bằng cách chia nhỏ yêu cầu đầu vào thành nhiều bước tư duy logic => cho phép mô hình lên kế hoạch và giải quyết từng phần của nhiệm vụ một cách tuần tự

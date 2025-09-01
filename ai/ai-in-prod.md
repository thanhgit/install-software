# AI trong môi trường production

<img width="1190" height="482" alt="image" src="https://github.com/user-attachments/assets/72692768-0fc8-45e1-9756-0c81008321e4" />

#### Tool calling
Yêu cầu:
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
* Thiết lập các tool được gọi nhiều ở chế độ sẵn sàng cao như hot-start hoặc warm-start (tra cứu hồ sơ người dùng)
* Cô lập các tool không ổn định để ngăn ngừa lỗi lan truyền

# LLM manager
- #### Một hệ thống mạnh mẽ = **AI** + `sự giám sát của con người trong quy trình làm việc` => tự động hóa có giám sát cho các quyết định kinh doanh quan trọng
- #### Các AI agent là `các hệ thống vận hành dựa trên dữ liệu`, cụ thể như sau:
  * Cá nhân hóa
  * Suy luận nhanh
  * Trí nhớ có ngữ cảnh
  * Hành động theo dữ liệu thời gian thực
  * Khả năng học hỏi từ quá khứ

![image](https://github.com/user-attachments/assets/bb40f4e0-bf18-45f5-a3f9-fc824f9f1a08)

### 5 key data assets that power the smartest AI agents 2
![image](https://github.com/user-attachments/assets/a95f1f8a-1f97-4057-891d-3d69d37f6a78)

#### 1. **Prompt Manager** – *Cá nhân hóa theo thời gian thực*
* **Dữ liệu sử dụng:** API hồ sơ người dùng
* **Tác dụng:** Giúp AI hiểu ngữ cảnh người dùng mà vẫn bảo mật
* **Tính chất nổi bật:**
  * Tuân thủ GDPR
  * Độ trễ < 250ms
  * Tạo prompt cá nhân hóa sâu, tránh trả lời chung chung

#### 2. **LLM Reasoning** – *Xử lý phản hồi nhanh và quy mô lớn*
* **Dữ liệu sử dụng:** Endpoint mô hình suy luận độ trễ thấp
* **Tác dụng:** Tăng tốc quá trình “suy nghĩ” của AI
* **Tính chất nổi bật:**
  * Độ trễ P99 < 300ms, kể cả khi tải cao
  * Caching tại biên, gần người dùng
  * Khả năng mở rộng cao, không bị nghẽn

#### 3. **Context and Memory** – *Nhớ và hiểu đúng ngữ cảnh*
* **Dữ liệu sử dụng:** Vector DB / Knowledge Graph
* **Tác dụng:** Cải thiện độ chính xác, giảm sai lệch
* **Tính chất nổi bật:**
  * Tìm kiếm gần đúng (ANN) < 50ms
  * Dựa trên embeddings và dữ liệu chuyên ngành
  * Giảm khoảng 30% “ảo tưởng” (hallucination)

![image](https://github.com/user-attachments/assets/0033204b-284d-49d1-aeae-c1221eff33dc)
#### 4. **Tool Orchestrator** – *Hành động đúng lúc với dữ liệu thời gian thực*
* **Dữ liệu sử dụng:** Feed tồn kho và giá cả theo thời gian thực
* **Tác dụng:** Giúp AI ra quyết định chính xác ngay lập tức
* **Tính chất nổi bật:**
  * Cập nhật dưới 1 giây
  * Giao hàng chính xác 1 lần (exactly-once)
  * Ngăn chặn bán trùng hoặc lỗi do cập nhật chậm

#### 5. **Action / Output** – *Học hỏi từ mỗi phản hồi đã đưa ra*
* **Dữ liệu sử dụng:** Interaction logs không thể thay đổi
* **Tác dụng:** Mỗi phản hồi được lưu lại để cải thiện AI
* **Tính chất nổi bật:**

  * Có version, audit rõ ràng
  * Ghi log theo luồng thời gian thực
  * Dữ liệu đầu vào cho việc tinh chỉnh RAG


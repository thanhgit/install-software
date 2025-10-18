# LLM manager
- #### Một hệ thống mạnh mẽ = **AI** + `sự giám sát của con người trong quy trình làm việc` => tự động hóa có giám sát cho các quyết định kinh doanh quan trọng
- #### Các AI agent là `các hệ thống vận hành dựa trên dữ liệu`

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
#### 4. 𝗧𝗼𝗼𝗹 𝗢𝗿𝗰𝗵𝗲𝘀𝘁𝗿𝗮𝘁𝗼𝗿:
- #### Consumes Real-Time Inventory / Pricing Feed as a Data Asset which gives it up-to-the-second info to make the right move, right now.
- #### 𝗗𝗮𝘁𝗮 𝗔𝘀𝘀𝗲𝘁 𝗣𝗿𝗼𝗽𝗲𝗿𝘁𝗶𝗲𝘀:
- #### • Sub-second updates on stock, pricing, analytics 
- #### • Exactly-once delivery: no duplicate actions 
- #### • Prevents double-selling: even on high-demand days

#### 5. 𝗔𝗰𝘁𝗶𝗼𝗻 / 𝗢𝘂𝘁𝗽𝘂𝘁:
- #### Consumes Immutable Interaction Logs as a Data Asset. Once the AI responds, the data journey isn’t over. Every answer becomes input for future learning.
- #### 𝗗𝗮𝘁𝗮 𝗔𝘀𝘀𝗲𝘁 𝗣𝗿𝗼𝗽𝗲𝗿𝘁𝗶𝗲𝘀:
- #### • Versioned, auditable: nothing lost, nothing overwritten 
- #### • Streaming inserts: logs everything in real-time 
- #### • Feeds RAG tuning: improves answers daily


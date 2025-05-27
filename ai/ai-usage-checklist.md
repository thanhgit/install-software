# CHECKLIST: Khi nào nên dùng AI Agent cho DevOps/SRE

### 1. 🎯 Mục tiêu tác vụ
| Câu hỏi                                               | Dùng AI nếu... |
| ----------------------------------------------------- | -------------- |
| Tác vụ có lặp lại thường xuyên không?                 | ✅ Yes          |
| Có thể tự động hóa không cần phán đoán con người?     | ✅ Yes          |
| Có tính read-only, an toàn, không ảnh hưởng sản xuất? | ✅ Yes          |
| Có nhiều thao tác thủ công, dễ sai sót nếu người làm? | ✅ Yes          |

### 2. 🧠 Đặc điểm dữ liệu / ngữ cảnh
| Câu hỏi                                                             | Dùng AI nếu... |
| ------------------------------------------------------------------- | -------------- |
| Dữ liệu đầu vào khó đoán trước (log, diff, trạng thái hệ thống)?    | ✅              |
| Kết quả cần “diễn giải”, không chỉ là dữ liệu raw?                  | ✅              |
| Kết quả cần hiểu ngôn ngữ tự nhiên / theo ngữ cảnh?                 | ✅              |
| Có giá trị khi tổng hợp từ nhiều nguồn (ArgoCD + Prometheus + log)? | ✅              |

### 3. 🔒 Rủi ro & kiểm soát
| Câu hỏi                                                               | Dừng lại nếu... |
| --------------------------------------------------------------------- | --------------- |
| Tác vụ có khả năng xóa, sửa, can thiệp hệ thống không qua xác nhận?   | ⛔ No            |
| Có liên quan tới thông tin nhạy cảm (secret, access key...)?          | ⛔               |
| AI agent được phép gọi API/CLI write mà không sandbox hoặc audit log? | ⛔               |

### 4. 👨‍👩‍👧‍👦 Người dùng cuối
| Câu hỏi                                                    | Dùng AI nếu... |
| ---------------------------------------------------------- | -------------- |
| Người dùng không rành CLI hoặc không quen ArgoCD?          | ✅              |
| Họ cần hỏi nhanh, tự nhiên ("có app nào lỗi không?")?      | ✅              |
| Họ muốn truy cập thông tin mà không phải đọc GUI phức tạp? | ✅              |

### 5. 📊 Đo lường hiệu quả
| Câu hỏi                                         | Dùng AI nếu... |
| ----------------------------------------------- | -------------- |
| Có cách đo số lần AI thực hiện đúng / hữu ích?  | ✅              |
| Có kế hoạch đo tỉ lệ “fallback về con người”?   | ✅              |
| Có cơ chế phản hồi để cải thiện prompt / logic? | ✅              |

### How to?
#### 1. Mục đích
- #### AI agent được triển khai nhằm hỗ trợ các tác vụ lặp lại, truy vấn trạng thái hệ thống và đề xuất gợi ý, không thay thế thao tác mang tính quyết định trong môi trường prod 

#### 2. Phân loại tác vụ
| Loại tác vụ                                            | Chính sách                                           |
| ------------------------------------------------------ | ---------------------------------------------------- |
| **Read-only**                                          | ✅ AI được tự động thực hiện                          |
| **Gợi ý hành động (e.g. rollback, deploy)**            | ✅ AI được quyền gợi ý, nhưng không tự động thực hiện |
| **Tác vụ write nguy hiểm (xóa app, thay đổi cluster)** | ❌ Không được thực hiện bởi AI, kể cả gợi ý           |
| **Phân tích log, cảnh báo, diff**                      | ✅ Được phép chạy tự động và diễn giải                |

#### 3. Quyền hạn
- #### AI agent chỉ có quyền truy xuất API đọc (ArgoCD, Prometheus, logging)
- #### Mọi hành động write (nếu có) phải qua xác thực đa bước
- #### Không được phép truy cập các file chứa thông tin nhạy cảm như secret, token, vault

#### 4. Logging & Audit
- #### Mọi lệnh AI thực hiện đều phải được log lại kèm:
    - #### Thời điểm
    - #### Người dùng yêu cầu
    - #### Nội dung tác vụ
- #### Log này cần giữ tối thiểu 90 ngày để audit

#### 5. Feedback & cải tiến
- #### Người dùng có thể gắn tag 👍 / 👎 hoặc bình luận để đánh giá độ chính xác câu trả lời
- #### Team DevOps sẽ xem xét phản hồi định kỳ hàng tuần để cải tiến prompt, rule và logic xử lý

##### 6. Trách nhiệm
- #### AI agent chỉ là trợ lý, quyết định cuối cùng vẫn thuộc về kỹ sư DevOps hoặc người có thẩm quyền
- #### Không triển khai AI agent trên môi trường production mà không có sandbox + giám sát
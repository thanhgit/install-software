# Data engineering

#### **Các thực hành best practíce Hiệu Quả**

1. **Thiết kế hệ thống theo dõi nguồn gốc dữ liệu (lineage) ngay từ đầu**
   * Tự động ghi lại quá trình biến đổi dữ liệu bằng công cụ và metadata.
   * Giúp tăng năng suất và giảm thời gian xử lý sự cố.

2. **Triển khai hợp đồng dữ liệu (data contracts) sớm**
   * Đảm bảo sự thống nhất giữa bên cung cấp và tiêu thụ dữ liệu.
   * Kiểm soát thay đổi schema và tăng tính minh bạch, trách nhiệm.

3. **Đầu tư vào khả năng quan sát (observability) + giám sát (monitoring)**
   * Phân tích nguyên nhân sự cố qua các chỉ số như độ tươi mới, phân phối, drift schema
   * Liên kết vấn đề kỹ thuật với KPI kinh doanh

4. **Xem metadata như yếu tố cốt lõi**
   * Tự động thu thập và làm giàu metadata với thuật ngữ kinh doanh, phân loại và quyền sở hữu.
   * Metadata hỗ trợ khám phá dữ liệu, bảo mật, và tích hợp AI.

5. **Áp dụng nguyên tắc "fail fast"**
   * Xây dựng pipeline nhỏ, thử nghiệm nhanh, rollback tự động.
   * Tránh lãng phí thời gian vào pipeline không cần thiết.

6. **Ưu tiên bảo mật và tuân thủ từ đầu**
   * Xây dựng kiểm soát truy cập chi tiết, phân loại dữ liệu nhạy cảm sớm, ghi log đầy đủ.
   * Tuân thủ các quy định như GDPR, CCPA ngay trong thiết kế.

7. **Tối ưu chi phí và hiệu năng**
   * Theo dõi chi phí truy vấn, loại bỏ các bước xử lý không cần thiết, áp dụng caching.
   * Dọn dẹp dữ liệu cũ giúp tiết kiệm đáng kể.

8. **Tài liệu hóa cho kỹ sư**
   * Viết tài liệu phục vụ người cần sửa lỗi lúc nửa đêm
   * Gắn tài liệu gần với mã nguồn, tự động hóa khi có thể

9. **Đo lường giá trị kinh doanh bởi chỉ số kỹ thuật**
   * Liên kết dữ liệu với KPI như doanh thu, churn, trải nghiệm khách hàng.
   * Trình bày giá trị dữ liệu bằng ngôn ngữ kinh doanh.

10. **Xây dựng hệ thống linh hoạt và chỉ ổn định**
* Thiết kế mô-đun, tách rời lưu trữ và xử lý, tránh phụ thuộc vào nhà cung cấp.
* Mục tiêu là dễ thích nghi, không phải bất biến.

---

Tóm lại, bài viết đề xuất 10 nguyên tắc thực tế giúp xây dựng hệ thống dữ liệu hiệu quả, linh hoạt và gắn liền với giá trị kinh doanh.

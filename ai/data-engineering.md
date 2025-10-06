# Data engineering
* là về **tạo ra dữ liệu đáng tin cậy**, không chỉ vận hành hiệu quả
  * Tin vào độ chính xác số liệu.
  * Tin vào tính công bằng của mô hình.
  * Tin vào khả năng tuân thủ.
  * Tin rằng các nhóm có thể phát triển nhanh mà không rơi vào hỗn loạn.

Cụ thể là:
1. **Pipeline => Data Product**
   * Xem dữ liệu như một sản phẩm, với người sở hữu, SLA (cam kết chất lượng), và quản lý vòng đời rõ ràng

2. **Governance => Context**
   * Mục tiêu không chỉ là kiểm soát dữ liệu, mà còn cung cấp ngữ cảnh để con người và AI có thể hiểu và tin tưởng dữ liệu

3. **Hype => Trust**
   * Doanh nghiệp không cần thêm công cụ mới, mà cần một nền tảng hợp nhất mọi thứ—quan sát, lineage, hợp đồng, governance => xây dựng **niềm tin dữ liệu**

#### **Các thực hành best practíce Hiệu Quả**
* => giúp xây dựng hệ thống dữ liệu hiệu quả, linh hoạt và gắn liền với giá trị kinh doanh.
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
Dưới đây là bản tóm tắt nội dung **“Mistakes You’ll Regret”** – 10 sai lầm phổ biến trong lĩnh vực data engineering mà bạn sẽ hối tiếc nếu mắc phải:

---
#### **10 Sai Lầm Cần Tránh Trong Data Engineering**
* => những sai lầm chiến lược và văn hóa mà các kỹ sư dữ liệu dễ mắc phải
* Do họ thưởng chỉ tập trung vào công nghệ mà **bỏ quên con người, mục tiêu và giá trị thực sự của dữ liệu**

1. **Chạy theo công cụ chỉ vì trào lưu**
   * Mỗi năm lại có “công cụ đột phá” mới => vội phá bỏ hệ thống hiện tại => `hệ thống dễ vỡ`
   * => Tập trung vào nền tảng: **mô hình dữ liệu, hợp đồng dữ liệu, và quản trị**

2. **Xem nhẹ chất lượng dữ liệu**
   * => **Hãy kiểm tra chất lượng dữ liệu từ đầu**: null, đối soát, phát hiện bất thường
   * Vì khi vấn đề xuất hiện quá muộn => `việc sửa chữa sẽ rất khó khăn và tốn kém`

3. **Coi quản trị dữ liệu là thủ tục rườm rà**
   * Thực tế, Governance là bối cảnh (ai sở hữu, ai truy cập, dữ liệu có ý nghĩa gì)
   * Cần tích hợp governance vào quy trình làm việc hằng ngày > tạo ra chính sách phức tạp khó áp dụng

4. **Thiết kế kiến trúc quá phức tạp**
   * Kiến trúc càng nhiều lớp => `càng nhiều điểm hỏng`
   * => Ưu tiên sự đơn giản, đặc biệt trong giai đoạn đầu

5. **Xây dựng hệ thống mà không có sự đồng thuận từ các bên liên quan**
   * `Không nên giả định yêu cầu—hãy xác nhận chúng`
   * => Làm việc chặt chẽ với PM, analyst và lãnh đạo trước khi hiện thực như viết spec, code, ... 

6. **Lãng quên yếu tố con người**
   * => tăng cường chia sẻ Kiến thức => phá bỏ “silo”.
   * Đào tạo, hỗ trợ và xây dựng văn hóa hợp tác là rất quan trọng

7. **Nghĩ rằng AI sẽ "giải cứu" dữ liệu lỗi**
   * `AI tốt = dữ liệu đầu vào có cấu trúc + đáng tin cậy`
   * Dữ liệu sai hoặc thiếu lineage => AI “ảo tưởng” một cách nguy hiểm

8. **Trì hoãn việc tự động hóa**
   * Cụ thể, quy trình thủ công không thể mở rộng
   * => cần tự động hóa kiểm tra lỗi, thay đổi schema, và xử lý dữ liệu là điều bắt buộc

9. **Bỏ qua kỹ năng mềm**
   * Khả năng giao tiếp, giải thích kỹ thuật cho người không chuyên là rất quan trọng
   * => `Kết nối kỹ thuật với kết quả kinh doanh` thông qua kể chuyện và trình bày rõ ràng

10. **Quên mục tiêu lớn hơn**
* Dữ liệu không chỉ để xây pipeline, `mà để hỗ trợ ra quyết định và đổi mới`
* => Luôn tự hỏi: “Dữ liệu này có ý nghĩa gì với tổ chức?”

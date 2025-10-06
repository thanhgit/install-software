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

---
### Data context trong kỷ nguyên AI
* giúp AI hoạt động đúng, đáng tin cậy và mang lại giá trị thật cho doanh nghiệp

#### Ví dụ vê **câu Chuyện của 2 Doanh Nghiệp**
**Enterprise A** – *Nhanh nhưng thiếu chuẩn bị*
* Triển khai AI (LLM) nhanh chóng, kết nối với toàn bộ dữ liệu và tài liệu
* Ban đầu chatbot hoạt động tốt, nhưng sau đó xuất hiện nhiều vấn đề:
  * Các thuật ngữ (glossary) bị hiểu sai do khác biệt giữa các phòng ban
  * Dữ liệu nhạy cảm bị rò rỉ vào hội thoại
  * LLM bị "ảo tưởng" khi trả lời do thiếu định nghĩa rõ ràng về thuật ngữ, ngữ cảnh đi kèm
* => gây mất niềm tin, gặp vấn đề tuân thủ, và bị giảm tốc độ triển khai AI

**Enterprise B** – *Chậm mà chắc*
* Trước tiên, xây dựng **ngữ cảnh dữ liệu** kỹ lưỡng:
  * Tạo từ điển thuật ngữ chung (shared glossary)
  * Xây dựng lineage để truy xuất nguồn gốc dữ liệu.
  * Thiết lập các quy tắc governance và bảo mật.
  * Phân rõ trách nhiệm sở hữu dữ liệu.
* Khi AI được triển khai => **đối tác ra quyết định** vì `hiểu đúng ngôn ngữ và chính sách của doanh nghiệp`
  → Kết quả: Người dùng tin tưởng, AI được áp dụng rộng rãi, mang lại ROI rõ ràng.

> ✅ **Khác biệt nằm ở việc doanh nghiệp có chuẩn bị đầy đủ **ngữ cảnh dữ liệu** hay không**

**Vì Sao data context Quan Trọng Trong Kỷ Nguyên AI**
* AI không "hiểu" dữ liệu như con người, mà chỉ phát hiện mẫu (pattern).
* **Ngữ cảnh dữ liệu** giúp kết nối raw data với **lý luận kinh doanh**
* ❌ **Not context**: AI đưa ra kết quả thiếu nhất quán hoặc nguy hiểm
* ✅ **Have context**: Doanh nghiệp xây dựng được hệ thống AI **đáng tin cậy, minh bạch và hiệu quả**, phù hợp với mục tiêu kinh doanh

**Các yếu tố tạo nên ngữ cảnh dữ liệu hiệu quả:**
1. **Metadata & Semantics** => Hiểu đúng ý nghĩa của các cột, chỉ số, trường dữ liệu
2. **Lineage & Provenance** => Biết dữ liệu đến từ đâu và đã được biến đổi như thế nào
3. **Ownership & Stewardship** => Có người chịu trách nhiệm về mỗi tập dữ liệu
4. **Purpose & Usage** => Biết dữ liệu được tạo ra để làm gì và nên được dùng thế nào
5. **Policies & Guardrails** => Đảm bảo tuân thủ pháp lý, bảo mật và đạo đức

---
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

---
### **Sự Thay Đổi Vai Trò của Data Engineers và Data Governance**
* **Data Engineers** tập trung xây pipeline, tối ưu truy vấn, đảm bảo hệ thống mở rộng tốt
* **Data Governance** thường bị coi là "rào cản", làm chậm tiến độ vì các quy định nghiêm ngặt

#### **Trong kỷ nguyên AI:**
* Hai role có quan hệ hợp tác nhưng **governance sẽ giữ vai trò then chốt hơn** vì **ý nghĩa > cơ chế** trong việc ra quyết định bằng AI

* **Data Engineers** vẫn rất quan trọng, nhưng vai trò mở rộng hơn:
  * Đảm bảo dữ liệu **real-time**, đáng tin cậy, `chi phí hợp lý`
  * Kết nối dữ liệu đa dạng (text, ảnh, âm thanh, giao dịch) vào hệ thống AI
  * Hỗ trợ **agentic workflows** => **AI không chỉ trả lời mà còn hành động**

* **Data Governance Teams** trở thành:
  * **Người phiên dịch ngữ cảnh kinh doanh** cho AI
  * Định nghĩa chính sách, ý nghĩa dữ liệu và quy tắc tuân thủ
  * người "gác cổng" => người **kích hoạt AI có trách nhiệm và hiệu quả**

#### **Hệ thống AI tập trung có kiểm soát bằng Guardrails**
> 🎯 Mỗi phòng ban (HR, Tài chính, Marketing...) có thể dùng AI một cách **đồng bộ, an toàn và hiệu quả**

* **Lớp ngữ cảnh thống nhất**: Dữ liệu đi qua một engine trung tâm (gồm lineage, semantics, policies)
* **Khả năng đa phương thức**: Text, audio, video, logs được tích hợp để hỗ trợ suy luận tốt hơn
* **Agentic workflows**: AI có thể hành động an toàn theo quy trình được cấu hình
* **Bảo mật & tuân thủ mặc định**: Guardrails ngăn chặn vi phạm từ gốc

**Tác Động Kinh Doanh Của AI Dựa Trên Ngữ Cảnh**
> 📌 **Ngữ cảnh biến AI từ một tool thành một đối tác chiến lược**

* ✅ **ROI cao hơn**: Vì insight gắn với chiến lược, không phải “ảo tưởng"
* ✅ **Giảm rủi ro**: Tuân thủ được tích hợp vào cách AI suy luận
* ✅ **Tăng tốc độ chấp nhận**: Người dùng tin tưởng AI khi dữ liệu có định nghĩa rõ ràng
* ✅ **Đồng bộ liên phòng ban**: Các bộ phận dùng chung “ngôn ngữ dữ liệu”














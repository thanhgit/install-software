# Ontology
* is a set of entities, which can be classes, properties, or individuals
* `Properties` are defined independently and outside the classes
* `Individuals` can belong to one class, but also to several classes (this is multiple instantiation, which is similar to multiple inheritance, but for instances)
> **Ontology không chỉ mô tả tri thức — nó còn tổ chức và chia sẻ tri thức một cách linh hoạt, mở đường cho nhiều ứng dụng sử dụng cùng một nền tảng tri thức.**

## 🧠 Vai Trò Của Ontology Hình Thức (Formal Ontologies)
### 1. 🧮 **Suy Luận Tự Động (Automatic Reasoning)**

* Cho phép thực hiện các suy luận logic nhờ vào công cụ suy luận (reasoner).
* Ví dụ: Một ontology về động vật có thể suy luận rằng "một con vật có sọc trắng đen" là **ngựa vằn**

### 2. 🌐 **Liên Kết Tri Thức Từ Nhiều Nguồn**

* Sử dụng **IRI (Internationalized Resource Identifier)** để định danh các thực thể (entity).
* Nhờ đó, các ontology có thể chia sẻ cùng một **không gian tên (namespace)** và liên kết với nhau.
* Cho phép định nghĩa **mối quan hệ tương đương** giữa các thực thể giống nhau trong các ontology khác nhau.

📌 Ví dụ:
* Nếu định nghĩa cùng một thực thể nhưng đặt tên khác nhau trong hai ontology riêng biệt
* => thì có thể thêm quan hệ tương đương để hợp nhất chúng thành **một thực thể duy nhất**.

### 🔄 **Tính Bổ Trợ Giữa Hai Mục Tiêu**

Việc **liên kết tri thức** sẽ mở ra khả năng **suy luận mới**.
→ Hai mục tiêu trên không tách biệt mà hỗ trợ lẫn nhau

<img width="1000" height="809" alt="image" src="https://github.com/user-attachments/assets/0cddbed3-76be-4969-bdf3-b86de033583b" />

## 💡 **Ontology giúp tái sử dụng và bảo trì tri thức hiệu quả hơn**

* **Một ứng dụng đơn lẻ** (ví dụ: xác định loại vi khuẩn) **có thể được xây dựng bằng một cơ sở tri thức (knowledge base) riêng**, chứa các luật logic cụ thể.
  **Ví dụ về luật xác định vi khuẩn:**

  ```text
  IF shape = round AND grouping = in cluster AND gram = '+'  
  THEN staphylococcus
  ```

* **Tuy nhiên**, nếu bạn có nhiều ứng dụng khác nhau (ví dụ: phân loại, so sánh, suy luận...), thì việc xây từng cơ sở tri thức riêng biệt cho từng ứng dụng sẽ:

  * Gây trùng lặp dữ liệu
  * Khó bảo trì
  * Khó mở rộng

---

### 🎯 **Giá trị cốt lõi của ontology:**

👉 **Ontology cho phép sử dụng chung một nguồn tri thức duy nhất** để phục vụ **nhiều ứng dụng khác nhau**.
Điều này giúp:

* **Dễ bảo trì:** Chỉ cần cập nhật ở một nơi.
* **Tái sử dụng tri thức:** Nhiều hệ thống có thể dùng chung.
* **Dễ mở rộng:** Khi cần phát triển thêm tính năng, không phải xây lại từ đầu.

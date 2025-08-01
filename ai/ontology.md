# Ontology
* is a set of entities, which can be classes, properties, or individuals
* `Properties` are defined independently and outside the classes
* `Individuals` can belong to one class, but also to several classes (this is multiple instantiation, which is similar to multiple inheritance, but for instances)
> **Ontology không chỉ mô tả tri thức — nó còn tổ chức và chia sẻ tri thức một cách linh hoạt, mở đường cho nhiều ứng dụng sử dụng cùng một nền tảng tri thức.**
* Phương pháp nội suy căn bản: `bất cứ điều gì không bị cấm chính thức đều được coi là có thể thực hiện được`, ví dụ shape có thể vửa là tròn vừa là vuông

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

## 🚫 Ràng buộc Loại Trừ Trong Ontology dùng disjoint
* Cần **khai báo hai lớp `Round` và `Rod` là *disjoint classes*** (lớp loại trừ nhau).
* Nghĩa là:

  > **Không có cá thể nào** (individual) **có thể thuộc về cả hai lớp này cùng lúc.**

### 🎯 Ý nghĩa tổng quát:

* **Tính nhất quán của tri thức:**
  Ràng buộc này đảm bảo dữ liệu không mâu thuẫn (ví dụ: một vi khuẩn không thể bị mô tả có hai hình dạng cùng lúc).

* **Hạn chế lỗi logic trong suy luận tự động:**
  Hệ thống reasoner có thể phát hiện lỗi nếu một cá thể bị gán vào cả hai lớp loại trừ.

## 🚫 **Ràng buộc Loại Trừ Cho Các Kiểu Tập Hợp (Grouping) Trong Ontology**
Đảm bảo rằng các **kiểu tập hợp (grouping)** của vi khuẩn trong ontology **không bị chồng lặp logic**, bằng cách sử dụng các **lớp loại trừ nhau (disjoint classes)**.

1. **Khai báo `InSmallChain` và `InLongChain` là lớp loại trừ nhau**:

   * Một vi khuẩn không thể vừa ở chuỗi ngắn **vừa** ở chuỗi dài cùng lúc.

2. **Khai báo các lớp `Isolated`, `InPair`, `InCluster`, `InChain` là *pairwise disjoint***:

   * Nghĩa là **bất kỳ cặp nào trong số các lớp này đều loại trừ nhau**.
   * Ví dụ: một vi khuẩn không thể **vừa Isolated vừa InCluster**.

### ⚠️ Lưu ý quan trọng:

> **Ràng buộc “disjoint” chỉ áp dụng với *các giá trị trong cùng một quan sát grouping***
> Nó **không cấm** một vi khuẩn có nhiều dạng tập hợp khác nhau trong các điều kiện khác nhau.

#### 📍 Ví dụ:

* Một vi khuẩn như **Pseudomonas** có thể được quan sát là:

  * **Isolated** trong điều kiện A
  * **InPair** trong điều kiện B

⛔ Nhưng **một tập hợp cụ thể** không thể **vừa Isolated vừa InPair** đồng thời.

---

### 🎯 Ý nghĩa tổng quát:

* Đảm bảo rằng các lớp biểu diễn **tình huống cụ thể** không bị mâu thuẫn logic.
* Cho phép mô hình hóa các trường hợp **đa hình dạng** (đa grouping) trong thực tế, nhưng vẫn giữ cho từng grouping riêng lẻ nhất quán.

---

### 💬 Kết luận:

> **Ràng buộc loại trừ (disjoint)** giúp tăng tính **logic và chính xác** cho ontology, trong khi vẫn cho phép **tính linh hoạt khi mô tả thực thể có nhiều đặc điểm.**

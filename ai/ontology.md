# Ontology
* is a set of entities, which can be classes, properties, or individuals
* `Properties` are defined independently and outside the classes
* `Individuals` can belong to one class, but also to several classes (this is multiple instantiation, which is similar to multiple inheritance, but for instances)
> **Ontology không chỉ mô tả tri thức — nó còn tổ chức và chia sẻ tri thức một cách linh hoạt, mở đường cho nhiều ứng dụng sử dụng cùng một nền tảng tri thức.**
* Phương pháp nội suy căn bản: `bất cứ điều gì không bị cấm chính thức đều được coi là có thể thực hiện được`, ví dụ shape có thể vửa là tròn vừa là vuông

### **Ontology là gì?**

Ontology là một cách có cấu trúc để mô tả:

* **Những gì tồn tại** trong lĩnh vực của bạn (ví dụ: con người, địa điểm, tài liệu)
* **Cách chúng liên kết với nhau** (ví dụ: *worksAt*, *authoredBy*)
* **Các quy tắc** xác định mối quan hệ đó

→ Có thể hiểu như một **bản thiết kế ngữ nghĩa** (semantic blueprint) cho dữ liệu.

### **Cách xây dựng một ontology (không cần bằng Tiến sĩ):**

1. **Xác định lĩnh vực tri thức**: Bạn đang mô hình hóa loại kiến thức nào?
2. **Liệt kê các khái niệm chính**: Chúng sẽ trở thành các “lớp” (ví dụ: *Person*, *Product*, *Event*)
3. **Xác định các mối quan hệ**: Ví dụ: *Person → worksAt → Company*
4. **Thêm thuộc tính** cho từng lớp: Ví dụ: *Person → hasName → String*

Ontology giúp AI:

* **Xác định khái niệm và mối quan hệ**
* **Lý luận theo ngữ cảnh**, vượt khỏi nhận diện mẫu đơn thuần
* Đạt đến **trí tuệ có thể giải thích được** (explainable intelligence)

### **Ontology và hạ tầng công nghệ hiện đại**

* **Kết hợp với**: Cơ sở dữ liệu đồ thị và vector
* **Tăng khả năng tương tác**: Giúp các hệ thống giao tiếp hiệu quả hơn
* **Trở thành nền tảng cốt lõi** trong thời đại GenAI

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

### 🧩 **Quá trình học ontology (Ontology Learning)**

* **Ontology Learning** là quá trình trích xuất và xây dựng ontology từ tri thức đã có, ví dụ từ các **tập văn bản**.
* Quá trình này thường được hình dung như một **chiếc bánh nhiều lớp** ("ontology learning cake"), mỗi lớp tương ứng với một **nhiệm vụ con** như:

  * Trích xuất thuật ngữ
  * Nhận diện từ đồng nghĩa
  * Phân loại khái niệm
  * Xác định quan hệ giữa các khái niệm, v.v.

---

### 🧠 **Ontology Learning trong kiến trúc neuro-symbolic**

Trong bối cảnh kiến trúc **neuro-symbolic**, quá trình học ontology có thể được thực hiện bằng cách **giải quyết đồng thời hai bài toán trích xuất thông tin (Information Extraction - IE):**

1. **Named Entity Recognition (NER)** – nhận diện thực thể
2. **Relation Extraction (RE)** – trích xuất quan hệ giữa các thực thể

✅ Việc kết hợp NER và RE giúp bao phủ toàn bộ các nhiệm vụ trong "ontology learning cake".

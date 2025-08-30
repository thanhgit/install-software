# Ontology
* is a set of entities, which can be classes, properties, or individuals
* `Properties` are defined independently and outside the classes
* `Individuals` can belong to one class, but also to several classes (this is multiple instantiation, which is similar to multiple inheritance, but for instances)
> **Ontology không chỉ mô tả tri thức — nó còn tổ chức và chia sẻ tri thức một cách linh hoạt, mở đường cho nhiều ứng dụng sử dụng cùng một nền tảng tri thức.**
* Phương pháp nội suy căn bản: `bất cứ điều gì không bị cấm chính thức đều được coi là có thể thực hiện được`, ví dụ shape có thể vửa là tròn vừa là vuông
* Giá trị thực nằm ở tầng dữ liệu và ngữ nghĩa – nơi Knowledge Graph đóng vai trò cốt lõi

### **Grounding là rào cản lớn cuối cùng của AI hiện đại**

Cho đến khi có một **cuộc cách mạng tiếp theo** trong AI – nơi mô hình ngôn ngữ có thể kết nối ngôn ngữ với hành động, thế giới vật lý, và nhân quả – thì:

* LLMs vẫn sẽ **chỉ là cỗ máy thống kê cao cấp**
* **Sự hiểu biết thật sự**, **sáng tạo**, và **diễn giải có ý nghĩa** vẫn phụ thuộc vào con người
* Knowledge graph dù mạnh mẽ đến đâu cũng cần **tính thích ứng** và khả năng thừa nhận sự mơ hồ, không chắc chắn

> **AI hiện tại không có khái niệm "thế giới". Và không thể "hiểu" nếu không được grounding vào nó.**

### 📌 **Các dạng suy luận phổ biến:**

| Loại suy luận | Hướng đi                                    | Ví dụ                            | Đặc trưng                      |
| ------------- | ------------------------------------------- | -------------------------------- | ------------------------------ |
| **Diễn dịch** | Luật → Kết luận                             | Tất cả A là B. A → B             | Chắc chắn nếu luật đúng        |
| **Quy nạp**   | Dữ liệu → Luật                              | Thấy 100 A là B → A có thể là B  | Có xác suất, không chắc chắn   |
| **Abduction** | Hiện tượng → Giải thích                     | Cỏ ướt → Có thể do mưa           | Đoán nguyên nhân hợp lý        |
| **Loại trừ**  | Loại bỏ khả năng → Giữ lại khả năng còn lại | Nếu không A, không B → phải là C | Rất mạnh khi giới hạn lựa chọn |

| Dạng suy luận                  | Đặc điểm                                      | Mục tiêu                         | Cơ sở dữ liệu          |
| ------------------------------ | --------------------------------------------- | -------------------------------- | ---------------------- |
| **Diễn dịch (Deduction)**      | Từ luật → đến kết luận cụ thể                 | Suy ra cái chắc chắn đúng        | Luật + dữ kiện         |
| **Quy nạp (Induction)**        | Từ dữ kiện → đến quy luật tổng quát           | Rút ra khuôn mẫu                 | Quan sát lặp lại       |
| **Abduction (Suy diễn ngược)** | Từ kết quả → đoán nguyên nhân hợp lý nhất     | Giải thích hiện tượng            | Tri thức nền + dữ kiện |
| **Loại trừ**                   | Loại các khả năng sai → giữ lại khả năng đúng | Tìm đáp án đúng trong số hữu hạn | Danh sách các khả năng |

## ✅ **Suy luận quy nạp ngược (Abduction)**

* là quá trình **tìm lời giải thích hợp lý nhất cho một hiện tượng hoặc tập dữ liệu**

* Còn gọi là: **“inference to the best explanation”**

* Cấu trúc điển hình:

  > Q (hiện tượng) xảy ra
  > Nếu P đúng thì Q xảy ra
  > → Có thể P là nguyên nhân (giải thích) cho Q

* **Tính chất:** Không chắc chắn, dễ sai, nhưng là công cụ hữu hiệu để **đặt giả thuyết** hoặc **suy đoán hợp lý** trong điều kiện thiếu thông tin.

## ✅ **Ứng dụng thực tiễn của suy luận abduction**

### 🔹 1. **Chẩn đoán (y học, kỹ thuật, pháp y,…)**

* Bác sĩ thấy triệu chứng → đặt ra nguyên nhân có thể gây ra chúng.

  * Ví dụ: Sốt cao + ho + mệt mỏi → Có thể là cúm

### 🔹 2. **Khoa học – Đặt giả thuyết**

* Các nhà khoa học quan sát một hiện tượng → đặt giả thuyết giải thích → kiểm tra sau.
* Ví dụ:

  * “Quỹ đạo sao Thủy lệch khỏi tính toán” → Giả thuyết: Có hành tinh “Vulcan” → Sau này bị bác bỏ → Thuyết tương đối giải thích tốt hơn.
* Đây là bước **khởi đầu trong phương pháp khoa học**, trước khi đi vào quy nạp hay diễn dịch.

### 🔹 3. **AI & Hệ thống tri thức**

* **AI chẩn đoán lỗi / phân tích nguyên nhân**:

  * Abduction được dùng để **suy đoán nguyên nhân tiềm năng từ kết quả quan sát.**
  * Ví dụ: Hệ chuyên gia y tế, hệ thống tìm lỗi mạng, hệ thống phát hiện gian lận.
* Trong NLP / computer vision:

  * Giải thích một hình ảnh / câu nói có thể bao gồm phỏng đoán lý do.

### 🔹 4. **Hiểu ngôn ngữ tự nhiên (NLP)**

* Khi người dùng nói điều không rõ ràng, hệ thống cần "đoán" ý định.

  * Ví dụ:

    > Người dùng: “Phòng lạnh quá.”
    > → Hệ thống phỏng đoán: người dùng muốn tăng nhiệt độ (abduction).
* Chatbots, trợ lý ảo, phân tích hội thoại đều dùng loại suy này ở mức ngầm định.

### 🔹 5. **Suy luận đạo đức / xã hội**

* Hiểu hành vi người khác bằng cách **đoán động cơ.**

  * Ví dụ: “Anh ấy đến muộn và trông mệt” → Có thể vì gặp chuyện buồn.
* Dùng phổ biến trong tâm lý học và lý thuyết “Theory of Mind”.

### 🔹 6. **Giải quyết vấn đề sáng tạo / thiết kế**

* Đặt giả thuyết về cách một thiết kế có thể đáp ứng yêu cầu chưa được giải thích rõ.
* Trong thiết kế sản phẩm hoặc UX: suy luận về **nguyên nhân gốc** của hành vi người dùng.

## ✅ **Suy luận loại trừ (Eliminative Reasoning)**

### 🔍 **Định nghĩa:**

Suy luận loại trừ là quá trình **loại bỏ các khả năng không phù hợp**, để tiến tới kết luận hợp lý nhất còn lại. Nó thường được biểu diễn như:

> **Nếu không phải A, không phải B, không phải C → Vậy là D**

Hoặc như bạn nói:

> **Nếu trời mưa thì cỏ ướt. Nhưng cỏ không ướt → Vậy trời không mưa.**

### ✅ **Ứng dụng:**

* **Chẩn đoán y khoa**: Nếu không phải bệnh A, B, D → có thể là bệnh C
* **AI & hệ thống chuyên gia**: Hệ thống rule-based dùng loại trừ để thu hẹp đáp án
* **Suy luận hình sự**: Loại bỏ nghi phạm không có chứng cứ → khoanh vùng thủ phạm
* **Debug phần mềm**: Không phải lỗi mạng, không phải cấu hình → có thể là bug logic

---
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

### 🔍 **Ontology không phải Knowledge Graph**

Hai thuật ngữ này thường bị nhầm lẫn nhưng **không giống nhau**:

> **Ontology** là **bản thiết kế (schema)**.
> **Knowledge Graph** là **dữ liệu thực tế**.

### 🧭 **Ontology = Bản thiết kế**

Ontology là mô tả chính thức của một miền kiến thức, bao gồm:

* **Khái niệm** (ví dụ: `Thiết bị`, `Con người`, `Quy trình`)
* **Quan hệ** (ví dụ: `sở hữu`, `thực hiện`, `nằm ở`)
* **Ràng buộc** (ví dụ: số lượng, phạm vi)
* **Các quy tắc logic (Axioms)**

Ontology là mô hình **đặt logic lên trước**, tập trung vào miền kiến thức, và không phụ thuộc công nghệ.

### 🧩 **Knowledge Graph = Ontology đã được áp dụng trên dữ liệu thực**

Knowledge Graph là cấu trúc dữ liệu dạng đồ thị dựa trên ontology để tổ chức:

* **Các thực thể cụ thể** (ví dụ: `Cảm biến#123`, `Nguyễn Văn A`)
* **Các sự kiện, sự thật** (ví dụ: `Cảm biến#123 nằm ở Phòng 12`)
* **Quan hệ theo dạng bộ ba (Subject–Predicate–Object)**

Nó là mô hình **dữ liệu thực tế**, linh hoạt, có thể truy vấn bằng ngôn ngữ như SPARQL hay GraphQL

### 🚀 **Tại sao điều này quan trọng?**

* Ontology giúp tạo ra **ý nghĩa rõ ràng**
* Knowledge Graph giúp dữ liệu trở nên **dễ tìm kiếm và khai thác**
* Kết hợp cùng nhau thúc đẩy các ứng dụng như **AI có thể giải thích được**, **hệ thống đề xuất**, **tự động hóa**, v.v.

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

---
### **Xây dựng Retail Graph: Từ dữ liệu sản phẩm đến mạng lưới tri thức**

Trong quá trình phát triển **Retail Graph**, Walmart tập trung vào hai loại **mối quan hệ chính**:

1. **Sản phẩm ↔ Thực thể (Product ↔ Entities)**
2. **Sản phẩm ↔ Sản phẩm (Product ↔ Product)** — gồm **sản phẩm thay thế** (substitutes) và **sản phẩm bổ trợ** (complements)

#### 1. **Product ↔ Entities: Liên kết sản phẩm với khái niệm**

Để xây dựng mạng lưới liên kết giữa sản phẩm và thực thể, nhóm bắt đầu từ **nội dung mô tả sản phẩm**. Mục tiêu là trích xuất thực thể (entities), liên kết chúng với khái niệm trừu tượng hoặc cụ thể, và hình thành các **bộ ba (triples)** trong đồ thị tri thức. Một **lớp kiểm duyệt (governance layer)** được thêm vào, cho phép con người rà soát các bộ ba có độ tin cậy thấp nhằm giữ chất lượng cao.

##### a. **Trích xuất thực thể (Entity Extraction)**

Dữ liệu mô tả sản phẩm rất đa dạng – có khi là đoạn văn dài, có khi chỉ là danh sách gạch đầu dòng ngắn. Để thích ứng, Walmart phát triển **hai mô hình trích xuất song song**:

* **i. Mô hình NLP (xử lý ngôn ngữ tự nhiên):**
  Dựa trên **POS Tagger của Stanford Core NLP**, mô hình này phù hợp với các tiêu đề/ngữ cảnh thiếu cấu trúc, ví dụ như mô tả sản phẩm dạng liệt kê điểm nổi bật.

* **ii. Mô hình heuristic (dựa trên quy tắc):**
  Khai thác định dạng đặc thù từ nhà cung cấp (HTML, bullet points...) và sử dụng **các quy tắc cố định** để tách và hiểu các đặc tính sản phẩm.

👉 Trong thực tế, **cả hai mô hình được dùng song song** để cân bằng giữa **độ chính xác (heuristic)** và **độ bao phủ (NLP)**.

##### b. **Liên kết thực thể (Entity Linking)**

Sau khi trích xuất, bước tiếp theo là xác định **ngữ nghĩa** của thực thể và **mối liên hệ với SKU**. Đây là một bước phức tạp, vì cùng một từ như **“cherry”** có thể mang nhiều nghĩa:

* Mùi hương (nến)
* Vị (nước ép)
* Màu sắc (quần áo)
* Bề mặt hoàn thiện (nội thất)
* Loại trái cây (grocery)

➡️ Việc liên kết thực thể yêu cầu mô hình **phân biệt theo ngữ cảnh**, thường là **loại sản phẩm**. Kết quả là các **triple** gồm (SKU - thực thể - thuộc tính).

Walmart bắt đầu với việc xây dựng một **từ điển thực thể thủ công** dựa trên các SKU bán chạy (giả định có dữ liệu tốt). Sau đó áp dụng:

* **Bước 1:** Liệt kê các thực thể ứng viên từ từ điển
* **Bước 2:** Dùng mô hình xếp hạng theo ngữ cảnh để chọn thực thể phù hợp nhất

##### c. **Quản trị thực thể (Entity Governance)**

Vì quá trình trích xuất có thể tạo ra **nhiễu (noise)** hoặc khái niệm không rõ ràng, Walmart triển khai một **mô-đun quản trị**:

* Xây dựng từ điển từ metadata hiện tại để xác định "unknown" hoặc "noise"
* Sử dụng **kết hợp heuristic và kiểm duyệt thủ công** để lọc bỏ nhiễu
* Đảm bảo rằng **chỉ dữ liệu sạch, có chất lượng cao mới được đưa vào đồ thị tri thức**

### **Kết luận: Đồ thị tri thức không chỉ là AI – mà là nền tảng dữ liệu thông minh**

Quá trình xây dựng Retail Graph là **sự kết hợp giữa NLP, hệ thống luật, học máy và kiểm duyệt thủ công**. Từ việc trích xuất thực thể, gán ngữ nghĩa đúng theo ngữ cảnh, đến việc loại bỏ nhiễu – tất cả đều nhằm mục tiêu tạo ra một **hệ sinh thái tri thức đáng tin cậy** cho sản phẩm.

> **Điều làm nên sức mạnh của Retail Graph không chỉ là công nghệ AI, mà là năng lực hiểu đúng và sâu sắc dữ liệu sản phẩm.**

#### **2. Product ↔ Product: Tìm kiếm sản phẩm thay thế (substitutes)**

Để xác định **sản phẩm thay thế cho một SKU**, Walmart kết hợp **dữ liệu văn bản** và **dữ liệu hình ảnh** — đặc biệt quan trọng với các ngành hàng như **nội thất, thời trang**, nơi mà **tính tương đồng thị giác** ảnh hưởng lớn đến khả năng thay thế.

Quy trình chính:

1. **Sinh embedding**:

   * Tạo **text embedding** từ mô tả sản phẩm
   * Tạo **image embedding** từ hình ảnh sản phẩm
2. **Tìm hàng xóm gần nhất (KNN)**:

   * Đưa embedding vào **FAISS index** (thư viện của Facebook cho tìm kiếm tương đồng hiệu quả)
   * Trích xuất tập ứng viên từ KNN bằng cả hai loại embedding
3. **Xếp hạng theo danh mục**:

   * Áp dụng logic xếp hạng theo danh mục cụ thể.
   * Ví dụ: Trong ngành nội thất, yếu tố như **“phong cách trang trí”** (mid-century, farmhouse, coastal...) được ưu tiên để đánh giá mức độ thay thế.

➡️ Kết quả cuối cùng là tập sản phẩm thay thế phù hợp về cả **nội dung lẫn ngữ cảnh thẩm mỹ**.

---

### **Kiến trúc hệ thống: Linh hoạt, tiến hóa và quy mô lớn**

Khi bắt đầu xây dựng Retail Graph, Walmart **không cố định một kiến trúc cuối cùng** – thay vào đó áp dụng nguyên lý **Kiến trúc Tiến hóa (Evolutionary Architecture)**:

> **“Cho phép thay đổi có định hướng theo thời gian trên nhiều chiều – và chấp nhận sự không hoàn thiện ban đầu.”**

#### Một số nguyên tắc kiến trúc chính:

* **Thành phần linh hoạt:**
  Các module như trích xuất và liên kết thực thể được thiết kế dưới dạng **thư viện độc lập**, sau đó mở ra dưới dạng **REST API** để dễ tích hợp.

* **Tích hợp với hệ thống lớn:**

  * Xây dựng **Hive UDFs** (User Defined Functions) trên Hadoop để thực thi các module ở quy mô hàng trăm triệu SKU.
  * Sử dụng hạ tầng **on-prem Hadoop cluster** của nhóm nền tảng dữ liệu.

### **Pipeline xử lý dữ liệu: Hai luồng chính**

1. **Product ↔ Entities**
2. **Product ↔ Product**

Cả hai pipeline đều được chạy định kỳ trên **Hadoop cluster tại chỗ**, xử lý lượng lớn dữ liệu sản phẩm. Sau khi xử lý xong, kết quả được đưa vào **Cosmos DB trên Azure** thông qua các API nạp dữ liệu hàng loạt.

➡️ Hệ thống được thiết kế để:

* Dễ thử nghiệm, tạo bản mẫu (POC) và lặp lại nhanh
* Xử lý dữ liệu **quy mô cực lớn**
* Giữ cho các thành phần **modular, linh hoạt và có thể mở rộng**

#### **Mô hình dữ liệu đồ thị & hệ quản trị**

Walmart đã **đánh giá hai mô hình đồ thị chính** cho nhu cầu đọc/ghi của hệ thống:

* **LPG (Labelled Property Graph)**
* **RDF (Resource Description Framework)**

Sau nhiều thử nghiệm, nhóm quyết định chọn **LPG** vì nó phù hợp hơn với các trường hợp sử dụng cụ thể của họ. Một số tiêu chí cân nhắc gồm khả năng ghi dữ liệu nhanh, mô hình linh hoạt và hỗ trợ tốt cho biểu diễn thuộc tính trực tiếp trên đỉnh và cạnh.

Về hệ quản trị cơ sở dữ liệu đồ thị, nhóm đã:

* Thử nghiệm với nhiều lựa chọn nội bộ
* **Chọn Azure Cosmos DB (Graph model)** là nền tảng chính
* **Phối hợp với nhóm Azure** để bổ sung khả năng ingest dữ liệu hàng loạt qua Java
* Sử dụng ngôn ngữ **Gremlin** cho các truy vấn và phép duyệt đồ thị (graph traversal)

### **Ứng dụng thực tế trong Walmart**

Do kích thước khổng lồ của **catalog sản phẩm Walmart**, quá trình xây dựng Retail Graph được triển khai theo **chiến lược từng bước theo danh mục (category-by-category)**:

#### 1. **Danh mục đầu tiên: Home & Garden**

* Đây là danh mục khởi đầu trong quá trình xây dựng Retail Graph
* Nhóm thực hiện **A/B testing trên trang sản phẩm** với sự phối hợp từ nhóm đề xuất sản phẩm
* Áp dụng mối quan hệ **Product ↔ Product** để cải thiện các gợi ý thay thế và bổ sung

#### 2. **Tìm kiếm ngữ nghĩa (Semantic Search)**

* Nhóm tìm kiếm thương mại điện tử phối hợp chặt chẽ với nhóm Retail Graph
* Xây dựng **hệ thống hiểu truy vấn mới (query understanding)** dựa trên các mối quan hệ trong graph
* Đang triển khai **interleaving test và A/B test** để thu thập phản hồi từ người dùng về khả năng tìm kiếm mới

### Retail Graph là một dự án có quy mô lớn, đòi hỏi:

* **Lặp lại nhanh (rapid iteration)**
* **Thử nghiệm liên tục (experimentation)**
* **Sẵn sàng học từ sai lầm** để tinh chỉnh giải pháp phù hợp

Dù các kết quả ban đầu rất hứa hẹn, nhóm thừa nhận rằng họ **mới chỉ khám phá “bề nổi”** của vấn đề. Việc xây dựng một đồ thị tri thức toàn diện cho hệ thống bán lẻ như Walmart là **hành trình lâu dài**, đòi hỏi sự kết hợp giữa kỹ thuật, chiến lược và khả năng học hỏi liên tục.

> **"Công nghệ chỉ là một phần – điều làm nên khác biệt là con người đứng sau nó."**
> Nhóm kỹ sư và nhà khoa học dữ liệu chính là lực lượng nòng cốt biến Retail Graph thành hiện thực.

### Inner loop so với Outer loop của context engineering

| **Vòng lặp**   | **Thành phần / Câu hỏi**                                            | **Nội dung**                                                                                                                               |
| -------------- | ------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| **Inner Loop** | Bổ sung bối cảnh                                                    | Model hiện tại nên nhận prompt gì?                                                                                                         |
|                | Truy xuất                                                           | Tìm những tài liệu, memory, instructions, dấu vết nào trong quá khứ?                                                                       |
|                | Định dạng                                                           | Cấu trúc prompt như thế nào (ví dụ: system prompt, few-shot, schemas)?                                                                     |
|                | Sắp xếp                                                             | Điều phối quy trình làm việc như thế nào? <br>- Việc nào làm trước? <br>- Việc nào bị cắt bớt?                                             |
|                | Gọi công cụ                                                         | Cung cấp những công cụ nào? Hướng tới công cụ phù hợp như thế nào?                                                                         |
|                | Phạm vi bộ nhớ                                                      | "In frame" từ lịch sử người dùng là gì?                                                                                                    |
| **Outer Loop** | Đánh giá, Học tập và Cải thiện                                      | Làm thế nào để cải thiện những gì model nhận được theo thời gian?                                                                          |
|                | Đánh giá                                                            | Đo lường liệu lựa chọn context có giúp ích hay gây hại?                                                                                    |
|                | Thu thập dữ liệu                                                    | Lưu giữ những dấu vết nào từ các tương tác trực tiếp                                                                                       |
|                |                                                                     | Ghi lại toàn bộ prompt + source đã truy xuất + user outcome                                                                                |
|                |                                                                     | Xây dựng dataset gồm các ví dụ tương phản                                                                                                  |      
|                | Học hỏi từ việc sử dụng                                             | Có chắt lọc các dấu vết context thành công thành phương pháp truy xuất mới, <br>- Ví dụ ít cảnh mới, bộ điều hợp mới, hay tinh chỉnh mới?  |
|                |                                                                     | Sắp xếp lại kinh nghiệm trong quá khứ hoặc căt tỉa những thứ không còn phù hợp                                                             |
|                | Xử lý trôi dạt (drift)                                              | Khi model thay đổi, có kiểm tra context pipeline cũ với hành vi mới không?                                                                 |
|                | Phản hồi của con người trong vòng lặp                               | Có thu thập phán đoán, chấm điểm theo sở thích, nắm bắt những thất bại context mà chỉ con người mới phát hiện?                             |


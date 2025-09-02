# Nâng cao chất lượng prompt

> “Làm sao để **LLM hiểu** mức độ phù hợp giữa context và câu hỏi, **từ điểm số** (vd: từ reranker hoặc similarity), để:

* Không "đối xử" mọi đoạn context như nhau
* Ưu tiên đoạn quan trọng khi trả lời
  ”



LLM không "hiểu" JSON theo nghĩa truyền thống mà theo xác suất chuỗi (token-level pattern):

* Nó học được rằng trong `{ "key": "value" }` → `"key"` thường mô tả loại thông tin gì.
* Nó học được rằng `"relevance_score": 0.91` → nghĩa là mức độ liên quan.
* Nó học pattern như:

  * `"title": "..."`, `"source": "..."`, `"confidence": ...`, `"answer": "..."`

➡️ Những pattern này **rất phổ biến** trong tập huấn luyện (internet, API docs, open datasets...), nên LLM **hiểu ngữ nghĩa ngầm** của từng trường.

### ✅ **1. Gắn điểm số trực tiếp vào từng đoạn (score-based annotation)**

Bạn hiển thị điểm tương đồng vào trước mỗi đoạn, ví dụ như sau:

```txt
[Document 1] (Relevance Score: 0.92)
<đoạn văn số 1>

[Document 2] (Relevance Score: 0.78)
<đoạn văn số 2>

[Document 3] (Relevance Score: 0.65)
<đoạn văn số 3>
```

🎯 Lợi ích:

* LLM sẽ *implicitly* hiểu rằng đoạn 1 > đoạn 2 > đoạn 3
* Không cần thay đổi kiến trúc model, chỉ prompt

💡 Mẹo:

* Dùng **thang điểm chuẩn hóa** (0.0 – 1.0 hoặc 0–100) cho nhất quán
* Có thể thêm mô tả như:

  > “Bạn nên ưu tiên các tài liệu có điểm cao hơn trong quá trình trả lời.”

### ✅ **2. Sắp xếp thứ tự context theo độ phù hợp (descending order) (Re-ranker)**

> LLM (đặc biệt là GPT-style) **chú ý nhiều hơn đến thông tin đầu tiên** trong prompt context → đoạn đầu thường có ảnh hưởng lớn hơn đến câu trả lời.

➕ Có thể kết hợp thêm `Relevance Score` như cách #1

### ✅ **3. Thêm hướng dẫn rõ trong phần hệ thống hoặc đầu prompt**

```txt
You are a helpful assistant. You are given multiple documents with a relevance score to the question. Use the documents with higher scores as the main source of truth.

Only consider documents with a score higher than 0.75 as reliable.
```

🎯 Điều này làm rõ vai trò của điểm số, giúp LLM không chỉ đọc context, mà còn có "chiến lược đọc".

👉 Gợi ý prompt context tốt nhất:

```txt
### Question:
"Tại sao indexing quan trọng trong hệ thống RAG?"

### Retrieved Documents:

[Doc 1] (Relevance Score: 0.91)
Indexing là quá trình tạo ra vector từ dữ liệu văn bản...

[Doc 2] (Relevance Score: 0.82)
Trong RAG, embedding giúp truy xuất nội dung liên quan...

[Doc 3] (Relevance Score: 0.64)
Các mô hình LLM thường yêu cầu lượng lớn token đầu vào...

### Instruction:
Dựa trên các tài liệu trên, ưu tiên sử dụng thông tin từ các đoạn có điểm số cao hơn để trả lời câu hỏi.
```


### 🔬 LLM tự đánh giá tài liệu nào đáng tin hơn, tự chọn tài liệu để trả lời

```
You are an intelligent assistant helping answer user questions based on retrieved documents.  
Each document is presented in JSON format, containing a `relevance_score` (from 0.0 to 1.0), the `source`, and the `content`.

Instructions:
1. Review all documents.
2. Select the ones with the highest relevance_score (>= 0.8).
3. Prioritize them when forming your answer.
4. If necessary, mention the source of the information.

### User Question:
"Tại sao indexing lại quan trọng trong hệ thống RAG?"

### Retrieved Documents:
[
  {
    "id": "doc_001",
    "relevance_score": 0.92,
    "source": "faq.txt",
    "content": "Indexing là quá trình chuyển đổi dữ liệu thành vector để phục vụ tìm kiếm ngữ nghĩa."
  },
  {
    "id": "doc_002",
    "relevance_score": 0.85,
    "source": "blog.md",
    "content": "Embedding chất lượng cao giúp truy xuất tài liệu chính xác hơn trong hệ thống RAG."
  },
  {
    "id": "doc_003",
    "relevance_score": 0.63,
    "source": "slide.pptx",
    "content": "LLM có thể trả lời dựa trên thông tin được đưa vào trong prompt context."
  }
]
```

✅ Khi nào nên dùng JSON context?

* Bạn có nhiều **metadata quan trọng**
* Truy vấn từ **nhiều nguồn khác nhau**
* Muốn **giải thích lý do** chọn tài liệu (LLM có thể trích dẫn nguồn + score)
* Muốn **cho LLM tự ra quyết định thông minh hơn**

## Dùng ontology để chỉ dẫn prompt

1. **Tăng độ chính xác và minh bạch**

* LLM hiểu được **ngữ cảnh metadata** đi kèm (ví dụ: nguồn, độ tin cậy, loại tài liệu, thời gian, mức độ liên quan)
* Giúp LLM **phân biệt được đâu là thông tin quan trọng, đâu là tham khảo**
=> `tránh lẫn lộn thông tin hoặc "nhảy cóc" trong câu trả lời`

2. **Dễ mở rộng và tùy biến**

* Ontology/schema riêng cho từng cá nhân hoặc tổ chức giúp hệ thống hiểu:

  * Tài liệu nào thuộc nhóm nào
  * Cách ưu tiên nguồn dữ liệu
  * Luật/điều kiện sử dụng nguồn (ví dụ, không lấy dữ liệu cũ hơn 1 năm, hay chỉ dùng dữ liệu đã được xác thực)

3. **Khả năng tương tác tốt hơn với dữ liệu phức tạp**

* Khi dữ liệu RAG đa dạng (văn bản, bảng số liệu, biểu đồ, dữ liệu kỹ thuật...)
* Việc data có cấu trúc và ontology => LLM phân tích và tổng hợp hiệu quả hơn

```json
{
  "query": "Tại sao indexing quan trọng trong RAG?",
  "documents": [
    {
      "id": "doc_1",
      "content": "Indexing là quá trình chuyển đổi dữ liệu thành vector...",
      "metadata": {
        "source": "faq.txt",
        "relevance": 0.92,
        "date": "2023-05-10",
        "type": "definition"
      }
    },
    {
      "id": "doc_2",
      "content": "Embedding giúp tăng độ chính xác truy xuất...",
      "metadata": {
        "source": "blog.md",
        "relevance": 0.87,
        "date": "2024-01-15",
        "type": "explanation"
      }
    }
  ],
  "ontology": {
    "type": {
      "definition": "Định nghĩa cơ bản",
      "explanation": "Giải thích chi tiết",
      "example": "Ví dụ minh họa"
    },
    "source_priority": ["faq.txt", "blog.md"]
  }
}
```

* **Dùng prompt hướng dẫn LLM** cách sử dụng ontology, ví dụ:

  > "Ưu tiên câu trả lời dựa trên các tài liệu có loại 'definition' trước, nguồn 'faq.txt' trước, và điểm relevance trên 0.85."

* **Dễ dàng cập nhật ontology hoặc metadata** khi dữ liệu nguồn thay đổi mà không cần thay đổi kiến trúc model.

* **Cải thiện khả năng giải thích (explainability)**: LLM có thể trích dẫn rõ ràng nguồn, loại tài liệu dựa trên metadata.

### Cách kết hợp embedding và KG trong **hệ thống RAG**

> **Câu hỏi người dùng:** *"Làm sao để giảm chi phí đi lại hàng tháng?"*

#### ❌ **Chỉ dùng Embedding (Retrieval truyền thống)**

Kết quả tìm được:

* “10 mẹo tiết kiệm xăng khi lái xe”
* “Giảm tiêu hao nhiên liệu bằng cách bảo dưỡng xe định kỳ”
* “So sánh các loại lốp tiết kiệm nhiên liệu”

⚠️ Vấn đề:

Toàn bộ đều là **giống ngữ nghĩa với từ khóa “chi phí đi lại” = tiết kiệm xăng**, nhưng không mở rộng ra các cách khác như:

* Dùng xe đạp
* Đi chung xe (carpool)
* Sử dụng phương tiện công cộng
* Làm việc từ xa
* Chọn nơi ở gần chỗ làm

👉 Những cái này **liên quan chặt chẽ đến việc giảm chi phí**, nhưng không hiện ra vì **embedding không thấy “giống”** về mặt vector.

#### ✅ **Kết hợp Knowledge Graph để mở rộng sự liên quan**

### 🔧 Setup Knowledge Graph (KG)

Giả sử bạn có 1 KG như sau:

```
"chi phí đi lại" 
   ├── liên quan đến → "phương tiện di chuyển"
   │     ├── bao gồm → "xe máy", "ô tô", "xe buýt", "xe đạp", "carpool"
   ├── bị ảnh hưởng bởi → "giá xăng", "quãng đường", "tần suất di chuyển"
   ├── có thể giảm bằng → "làm việc từ xa", "chọn nhà gần chỗ làm", "thời gian linh hoạt"
```

| Bước | Mô tả                                                  |
| ---- | ------------------------------------------------------ |
| 1    | Nhận câu hỏi từ người dùng                             |
| 2    | Trích xuất thực thể chính từ câu hỏi                   |
| 3    | Tra KG để tìm các thực thể, chủ đề liên quan           |
| 4    | Tạo truy vấn mở rộng từ các chủ đề này                 |
| 5    | Encode tất cả truy vấn (gốc + mở rộng) thành embedding |
| 6    | Truy vấn vector DB để lấy đoạn văn                     |
| 7    | Rerank kết quả dựa trên độ gần trong KG (nếu có thể)   |
| 8    | Đưa top-k kết quả vào LLM để trả lời                   |

🔍 Bước 1: **Trích xuất thực thể từ câu hỏi**

* Thực thể chính: `"chi phí đi lại"`

🔄 Bước 2: **Tìm các thực thể liên quan trong KG**

* "giảm chi phí đi lại" → có liên quan đến:

  * "phương tiện công cộng"
  * "carpool"
  * "làm việc từ xa"
  * "xe đạp"
  * "chuyển chỗ ở gần hơn"

👉 Đây là những ý tưởng **không giống về mặt từ vựng**, nhưng **liên quan mạnh** theo KG

🔁 Bước 3: **Tạo truy vấn mở rộng (expanded queries)**

Thay vì chỉ dùng 1 embedding từ câu gốc, bạn tạo thêm các truy vấn như:

* “Lợi ích của việc đi làm bằng xe buýt”
* “Giảm chi phí đi lại bằng cách làm việc từ xa”
* “Đi xe đạp thay vì đi xe máy”
* “Đi chung xe với đồng nghiệp”
* “Chọn nhà gần chỗ làm có giúp tiết kiệm không?”

→ Encode các truy vấn này thành embedding → truy vấn thêm vào database → **lấy được dữ liệu mới có liên quan hơn**.

🎯 Bước 4: **Rerank hoặc chọn top-n**

Lấy các kết quả từ truy vấn mở rộng + truy vấn gốc → rerank dựa trên:

* **Embedding similarity**
* **Liên kết quan hệ trong KG** (nếu có thể xác định thực thể trong đoạn văn và tính độ gần)

#### 📦 Kết quả sau khi kết hợp KG

Bạn có thể lấy được các đoạn văn như:

1. “Sử dụng xe đạp thay vì ô tô giúp giảm chi phí xăng và chi phí bảo dưỡng đáng kể mỗi tháng.”
2. “Theo nghiên cứu, làm việc từ xa 2 ngày/tuần giúp giảm đến 40% chi phí đi lại.”
3. “Ở gần nơi làm việc có thể giúp tiết kiệm chi phí di chuyển và thời gian mỗi ngày.”

👉 Những đoạn này không tương đồng hoàn toàn với câu hỏi, nhưng lại **trực tiếp trả lời vấn đề người dùng đang quan tâm** → **chất lượng đầu vào cho LLM tốt hơn nhiều.**


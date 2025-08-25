# Nâng cao chất lượng prompt

> “Làm sao để **LLM hiểu** mức độ phù hợp giữa context và câu hỏi, **từ điểm số** (vd: từ reranker hoặc similarity), để:

* Không "đối xử" mọi đoạn context như nhau
* Ưu tiên đoạn quan trọng khi trả lời
  ”

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




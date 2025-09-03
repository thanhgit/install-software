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

#### Tích hợp **Knowledge Graph (KG)** với **RAG* 

* Khi indexing, chỉ embedding raw text không đủ
* => cần phải khai thác entity, relation, enrich thông tin, rồi mới embedding

---

## ✅ Vấn đề: Embedding đoạn văn bản **chưa đủ ngữ nghĩa**

Trong hệ thống RAG thông thường:

* Text → Chunk → Embedding → Index
  → **Không biết đoạn đó nói về thực thể nào**, mối quan hệ nào, nên khả năng match theo ngữ nghĩa sâu bị hạn chế.

---

## ✅ Giải pháp: **Làm giàu (Enrich)** trước khi embedding

### 🧩 Cần làm gì trong quá trình indexing:

| Bước                           | Nội dung                                     | Lý do                                      |
| ------------------------------ | -------------------------------------------- | ------------------------------------------ |
| 1. Entity Extraction (NER/NEL) | Trích xuất các thực thể trong đoạn           | Giúp hiểu đoạn đề cập đến ai/cái gì        |
| 2. Relation Extraction         | Trích xuất các quan hệ giữa thực thể         | Bổ sung ngữ cảnh logic                     |
| 3. KG Enrichment               | Truy ngược KG để lấy các khái niệm liên quan | Làm giàu tri thức                          |
| 4. Summary hoặc Rewriting      | Tóm tắt lại đoạn văn với tri thức đã enrich  | Giúp embedding nắm bắt đủ ngữ nghĩa        |
| 5. Embedding enriched content  | Embedding đoạn đã làm giàu                   | Tăng khả năng tương đồng ngữ nghĩa thực sự |

---

## 🔧 Minh họa quy trình enrich khi indexing:

Giả sử bạn có đoạn văn gốc:

```text
Công ty ABC áp dụng chiến lược ESG từ năm 2021 để cải thiện hình ảnh doanh nghiệp và thu hút đầu tư nước ngoài.
```

---

### 1. ✳️ Entity & Relation Extraction:

* Entities: `Công ty ABC`, `ESG`, `đầu tư nước ngoài`
* Relations (triples):

  * `(Công ty ABC, áp dụng, ESG)`
  * `(ESG, dẫn đến, cải thiện hình ảnh)`
  * `(ESG, giúp, thu hút đầu tư nước ngoài)`

---

### 2. ✳️ KG Enrichment (truy ngược KG):

Từ "ESG", truy được:

* ESG liên quan tới: `môi trường`, `quản trị`, `xã hội`
* Quan hệ: `thu hút vốn`, `tăng uy tín`, `giảm rủi ro`

---

### 3. ✳️ Làm giàu nội dung:

Tái tạo đoạn hoặc thêm metadata:

#### 🅰️ Cách 1: Viết lại đoạn enriched (dùng để embedding)

```text
Công ty ABC triển khai chiến lược ESG từ năm 2021. ESG là viết tắt của Môi trường, Xã hội và Quản trị. Việc áp dụng ESG giúp doanh nghiệp cải thiện hình ảnh, tăng uy tín và thu hút đầu tư nước ngoài.
```

#### 🅱️ Cách 2: Giữ đoạn gốc + metadata

```json
{
  "chunk_text": "Công ty ABC áp dụng chiến lược ESG từ năm 2021...",
  "entities": ["Công ty ABC", "ESG", "đầu tư nước ngoài"],
  "relations": [
    {"subject": "Công ty ABC", "predicate": "áp dụng", "object": "ESG"},
    {"subject": "ESG", "predicate": "giúp", "object": "thu hút đầu tư"}
  ],
  "kg_context": [
    "ESG liên quan đến quản trị doanh nghiệp và môi trường",
    "ESG giúp tăng uy tín và giảm rủi ro đầu tư"
  ]
}
```

> → Sau đó bạn có thể **embedding phần text đã enrich**, hoặc embedding **full JSON dưới dạng văn bản natural language** (được LLM hiểu tốt).

---

## ✅ Tại sao làm vậy sẽ **tăng độ liên quan khi truy xuất**?

1. **Embedding có tri thức ngữ nghĩa sâu hơn** → tăng similarity với query dù từ ngữ khác biệt.
2. **Thực thể và quan hệ rõ ràng** → giúp matching theo concept, không chỉ từ khóa.
3. **Thông tin tóm gọn, không dư thừa** → dễ lọc ra nội dung chính xác hơn trong retrieval.

---

## 🔁 Khi kết hợp với Query Expansion từ KG

Khi truy vấn có entity như "ESG", bạn cũng:

* Truy ngược KG để lấy khái niệm liên quan.
* Sinh thêm các query như:

  * "Lợi ích của quản trị ESG"
  * "Ảnh hưởng ESG đến đầu tư nước ngoài"
* Dễ match hơn với đoạn đã enrich ở trên → tăng recall và precision.

---

## 🚀 Công nghệ bạn có thể dùng

| Mục tiêu                  | Gợi ý công cụ                                                 |
| ------------------------- | ------------------------------------------------------------- |
| NER + Relation Extraction | spaCy, HuggingFace Transformers, Trankit (tiếng Việt), OpenIE |
| KG Enrichment             | Wikidata, ConceptNet, hoặc KG riêng                           |
| Summary + Rewrite         | Prompt GPT-4 / LLaMA / Claude                                 |
| Embedding enriched text   | BGE, GTE, E5, or domain-specific encoder                      |
| Index                     | FAISS, Weaviate, Qdrant                                       |

---

## 📌 Tóm tắt

**Vâng**, bạn cần enrich đoạn **trước khi embedding**, bằng cách:

* Trích xuất thực thể và quan hệ
* Truy ngược KG để làm giàu
* Tóm tắt hoặc tái viết nội dung chứa tri thức
* Sau đó mới đưa vào embedding

→ Đây là **cách tiếp cận chuẩn**, giúp tăng **semantic retrieval** đáng kể, đặc biệt trong hệ thống RAG có yêu cầu chính xác cao (như luật, tài chính, y tế,... )


### ✅ **Tận dụng sự kết hợp giữa `metadata`, `chunk` và `embedding vector` 

* để làm giàu ngữ cảnh (context enrichment)** — tức là **sử dụng metadata không chỉ để lọc mà để tăng cường semantic retrieval và generation.**

## 🧠 Tư duy cốt lõi:

Trong các hệ thống RAG:

* Dữ liệu được lưu dưới dạng:
  ✅ `chunk_text` (nội dung chính)
  ✅ `embedding` (biểu diễn vector)
  ✅ `metadata`: các thuộc tính như title, date, entities, relations, tags, sources, etc.

### → Thay vì chỉ dùng `embedding` để tìm, hoặc `metadata` để lọc cứng, ta có thể:

> **KẾT HỢP cả 3** để:

* Truy xuất kết quả sâu hơn và ngữ nghĩa hơn
* Làm giàu context đầu vào cho LLM để sinh đầu ra chính xác hơn

---

## ✅ Ba cấp độ kết hợp metadata + embedding + chunk

### 🔹 1. **Metadata làm ngữ cảnh phụ cho LLM**

* Truy xuất `chunk` + lấy metadata liên quan (entities, tags, relations)
* Đưa vào prompt theo dạng có cấu trúc (e.g. YAML, bảng, đoạn text tóm tắt)

**Ví dụ prompt:**

```yaml
Document: Chính sách ưu đãi thuế cho doanh nghiệp FDI

Entities: ["FDI", "thuế thu nhập doanh nghiệp", "ưu đãi đầu tư"]
Relations:
 - FDI → áp dụng → ưu đãi thuế
 - Chính phủ → quy định → miễn giảm thuế cho FDI

Content:
Doanh nghiệp FDI được áp dụng thuế suất ưu đãi...
```

→ **LLM hiểu tốt hơn** vì có bối cảnh rõ, thay vì chỉ đọc plain text.

---

### 🔹 2. **Metadata dùng để tăng chất lượng embedding & truy xuất**

#### ✳️ Cách làm:

* Kết hợp metadata vào embedding text lúc indexing:

  * Thay vì chỉ embedding `chunk_text`, bạn có thể embedding:

    ```text
    [Entity: FDI] [Relation: áp dụng ưu đãi thuế] Doanh nghiệp FDI được áp dụng thuế suất ưu đãi...
    ```

→ **Embedding vector giờ mang ngữ nghĩa của metadata** → cosine similarity sẽ phản ánh ý định tốt hơn.

---

### 🔹 3. **Metadata làm bộ lọc ngữ nghĩa mềm (semantic filter)**

#### ✳️ Cách dùng:

* Khi user query → trích xuất `entities`, `topics`, `relations`
* So sánh các thành phần này với metadata trong vector store
* Lọc / tăng trọng số cho các chunk có metadata tương đồng

> Ví dụ: Nếu user hỏi "Chính sách thuế cho FDI ở miền Bắc", thì metadata có `"region": "Bắc"` và `"entity": "FDI"` được ưu tiên.

---

## 🏗️ Kiến trúc kết hợp metadata trong RAG

```text
       [Query]
          ↓
  → Entity & relation extraction
          ↓
  → Embedding + Metadata match (hybrid)
          ↓
     [Retrieve top-K chunks]
          ↓
  → Extract metadata (entities, source, relations)
          ↓
    [Prompt enrichment: metadata + chunk]
          ↓
          LLM
```

---

## 📦 Lưu trữ metadata trong vector store

Các vector database như:

| Vector DB    | Metadata hỗ trợ             | Query kết hợp                  |
| ------------ | --------------------------- | ------------------------------ |
| **FAISS**    | Có (nhưng hơi thủ công)     | Dùng custom filter ngoài       |
| **Qdrant**   | Tốt (JSON metadata)         | Hỗ trợ filter theo field       |
| **Weaviate** | Rất mạnh (Graph + metadata) | Có thể dùng GraphQL + semantic |
| **Pinecone** | Hỗ trợ tốt                  | Dễ filter theo metadata        |
| **Milvus**   | Có hỗ trợ                   | Nhưng config phức tạp hơn      |

---

## 🧠 Mở rộng nâng cao

| Chiến lược                     | Lợi ích                              |
| ------------------------------ | ------------------------------------ |
| Enrich metadata từ KG          | Kết nối giữa chunk và tri thức ngoài |
| Embedding context + metadata   | Semantic retrieval chính xác hơn     |
| Prompt injection metadata      | Giúp LLM reasoning đúng hơn          |
| Filter + re-rank bằng metadata | Precision cao hơn trong RAG          |

---

## ✅ Kết luận

Vâng, **kết hợp metadata + chunk + embedding vector** không chỉ là "có thể", mà là **cần thiết** nếu bạn muốn xây dựng một hệ thống RAG có độ chính xác và tính ngữ nghĩa cao.

**Metadata không chỉ để lọc — nó chính là ngữ cảnh cấu trúc, là "knowledge-lite graph" lồng trong dữ liệu.**

---

Nếu bạn muốn, mình có thể hỗ trợ:

* Mẫu schema lưu metadata hiệu quả
* Cách embed metadata + chunk chung để tăng chất lượng vector
* Gợi ý prompt sử dụng metadata
* Kết hợp vector store với KG như Neo4j / Weaviate

# Nâng cao chất lượng prompt

> “Làm sao để **LLM hiểu** mức độ phù hợp giữa context và câu hỏi, **từ điểm số** (vd: từ reranker hoặc similarity), để:

* Không "đối xử" mọi đoạn context như nhau
* Ưu tiên đoạn quan trọng khi trả lời

LLM không "hiểu" JSON theo nghĩa truyền thống mà theo xác suất chuỗi (token-level pattern):
* Nó học được rằng trong `{ "key": "value" }` → `"key"` thường mô tả loại thông tin gì.
* Nó học được rằng `"relevance_score": 0.91` → nghĩa là mức độ liên quan.
* Nó học pattern như:
  * `"title": "..."`, `"source": "..."`, `"confidence": ...`, `"answer": "..."`

➡️ Những pattern này **rất phổ biến** trong tập huấn luyện (internet, API docs, open datasets...)
=> LLM **hiểu ngữ nghĩa ngầm** của từng trường.

### ✅ **1. Gắn điểm số trực tiếp vào từng đoạn (score-based annotation)**
* Bạn hiển thị điểm tương đồng vào trước mỗi đoạn, ví dụ như sau:
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

| Bước                           | Nội dung                                     | Lý do                                      |
| ------------------------------ | -------------------------------------------- | ------------------------------------------ |
| 1. Entity Extraction (NER/NEL) | Trích xuất các thực thể trong đoạn           | Giúp hiểu đoạn đề cập đến ai/cái gì        |
| 2. Relation Extraction         | Trích xuất các quan hệ giữa thực thể         | Bổ sung ngữ cảnh logic                     |
| 3. KG Enrichment               | Truy ngược KG để lấy các khái niệm liên quan | Làm giàu tri thức                          |
| 4. Summary hoặc Rewriting      | Tóm tắt lại đoạn văn với tri thức đã enrich  | Giúp embedding nắm bắt đủ ngữ nghĩa        |
| 5. Embedding enriched content  | Embedding đoạn đã làm giàu                   | Tăng khả năng tương đồng ngữ nghĩa thực sự |

#### 🔧 Minh họa quy trình enrich khi indexing:

```text
Công ty ABC áp dụng chiến lược ESG từ năm 2021 để cải thiện hình ảnh doanh nghiệp và thu hút đầu tư nước ngoài.
```

1. ✳️ Entity & Relation Extraction:

* Entities: `Công ty ABC`, `ESG`, `đầu tư nước ngoài`
* Relations (triples):

  * `(Công ty ABC, áp dụng, ESG)`
  * `(ESG, dẫn đến, cải thiện hình ảnh)`
  * `(ESG, giúp, thu hút đầu tư nước ngoài)`

2. ✳️ KG Enrichment (truy ngược KG):

Từ "ESG", truy được:

* ESG liên quan tới: `môi trường`, `quản trị`, `xã hội`
* Quan hệ: `thu hút vốn`, `tăng uy tín`, `giảm rủi ro`

3. ✳️ Làm giàu nội dung => `Tái tạo đoạn hoặc thêm metadata`:

* 🅰️ Cách 1: Viết lại đoạn enriched (dùng để embedding)

```text
Công ty ABC triển khai chiến lược ESG từ năm 2021. ESG là viết tắt của Môi trường, Xã hội và Quản trị. Việc áp dụng ESG giúp doanh nghiệp cải thiện hình ảnh, tăng uy tín và thu hút đầu tư nước ngoài.
```

* 🅱️ Cách 2: Giữ đoạn gốc + metadata

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

✅ Kết quả **tăng độ liên quan khi truy xuất** do:

1. **Embedding có tri thức ngữ nghĩa sâu hơn** → tăng similarity với query dù từ ngữ khác biệt
2. **Thực thể và quan hệ rõ ràng** → giúp matching theo concept, không chỉ từ khóa
3. **Thông tin tóm gọn, không dư thừa** → dễ lọc ra nội dung chính xác hơn trong retrieval

🔁 Khi kết hợp với Query Expansion từ KG

Khi truy vấn có entity như "ESG", bạn cũng:

* Truy ngược KG để lấy khái niệm liên quan.
* Sinh thêm các query như:

  * "Lợi ích của quản trị ESG"
  * "Ảnh hưởng ESG đến đầu tư nước ngoài"
* Dễ match hơn với đoạn đã enrich ở trên → tăng recall và precision.

🚀 Công nghệ bạn có thể dùng

| Mục tiêu                  | Gợi ý công cụ                                                 |
| ------------------------- | ------------------------------------------------------------- |
| NER + Relation Extraction | spaCy, HuggingFace Transformers, Trankit (tiếng Việt), OpenIE |
| KG Enrichment             | Wikidata, ConceptNet, hoặc KG riêng                           |
| Summary + Rewrite         | Prompt GPT-4 / LLaMA / Claude                                 |
| Embedding enriched text   | BGE, GTE, E5, or domain-specific encoder                      |
| Index                     | FAISS, Weaviate, Qdrant                                       |

### ✅ **Tận dụng sự kết hợp giữa `metadata`, `chunk` và `embedding vector` 

* để làm giàu ngữ cảnh (context enrichment)**
* => **sử dụng metadata không chỉ để lọc mà để tăng cường semantic RAG**
* **Metadata không chỉ để lọc — nó chính là ngữ cảnh cấu trúc, là "knowledge-lite graph" lồng trong dữ liệu**

* Dữ liệu được lưu dưới dạng:
  ✅ `chunk_text` (nội dung chính)
  ✅ `embedding` (biểu diễn vector)
  ✅ `metadata`: các thuộc tính như title, date, entities, relations, tags, sources, etc.

→ Thay vì chỉ dùng `embedding` để tìm, hoặc `metadata` để lọc cứng, ta có thể:

#### ✅ Ba cấp độ kết hợp metadata + embedding + chunk

1. **Metadata làm ngữ cảnh phụ cho LLM**

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

2. **Metadata dùng để tăng chất lượng embedding & truy xuất**

* Kết hợp metadata vào embedding text lúc indexing:

  * Thay vì chỉ embedding `chunk_text`, bạn có thể embedding:

    ```text
    [Entity: FDI] [Relation: áp dụng ưu đãi thuế] Doanh nghiệp FDI được áp dụng thuế suất ưu đãi...
    ```

→ **Embedding vector giờ mang ngữ nghĩa của metadata** → cosine similarity sẽ phản ánh ý định tốt hơn.

3. **Metadata làm bộ lọc ngữ nghĩa mềm (semantic filter)**

* Khi user query → trích xuất `entities`, `topics`, `relations`
* So sánh các thành phần này với metadata trong vector store
* Lọc / tăng trọng số cho các chunk có metadata tương đồng

> Ví dụ: Nếu user hỏi "Chính sách thuế cho FDI ở miền Bắc", thì metadata có `"region": "Bắc"` và `"entity": "FDI"` được ưu tiên.

🧠 Mở rộng nâng cao

| Chiến lược                     | Lợi ích                              |
| ------------------------------ | ------------------------------------ |
| Enrich metadata từ KG          | Kết nối giữa chunk và tri thức ngoài |
| Embedding context + metadata   | Semantic retrieval chính xác hơn     |
| Prompt injection metadata      | Giúp LLM reasoning đúng hơn          |
| Filter + re-rank bằng metadata | Precision cao hơn trong RAG          |

#### Context engineering
```json
{
  "question": "Tác động của trí tuệ nhân tạo đến thị trường lao động là gì?",
  "role": "Bạn là một trợ lý cho sinh viên. Dựa trên dữ liệu JSON sau, hãy sinh một câu trả lời ngắn gọn, rõ ràng và dễ hiểu theo ngôn ngữ, giọng điệu và phong cách yêu cầu"
  "facts": [
    "AI đang tái định hình thị trường lao động toàn cầu bằng cách tự động hóa và tạo ra nghề nghiệp mới.",
    "Trí tuệ nhân tạo thay thế các công việc lặp lại và có tính quy trình cao, đặc biệt trong sản xuất, logistics, và dịch vụ khách hàng.",
    "AI cũng tạo ra nhu cầu lớn trong các lĩnh vực như khoa học dữ liệu, kỹ thuật phần mềm, và an ninh mạng.",
    "Kỹ năng mềm như sáng tạo, tư duy phản biện và giao tiếp ngày càng quan trọng.",
    "AI có thể thay thế tới 30% công việc hiện tại vào năm 2030 (theo McKinsey).",
    "Khoảng 97 triệu việc làm mới có thể được tạo ra nhờ công nghệ AI (theo WEF 2023).",
    "Ngành giáo dục và đào tạo lại kỹ năng đang trở nên quan trọng để thích ứng với AI.",
    "Người lao động cần cập nhật kỹ năng liên quan đến công nghệ.",
    "Các tổ chức nên đầu tư vào đào tạo và phát triển nhân lực phù hợp với thời đại AI."
  ],
  "audience_output": "sinh viên",
  "language_output": "tiếng Việt",
  "tone_output": "chuyên nghiệp",
  "style_output": "gạch đầu dòng",
  "source_input": "nội bộ",
  "length_limit_output": "nhỏ hơn 100 từ",
  "confidence_level_output": "cao",
  "output_format": "json"
}
```

#### LLM xác định câu hỏi cần SINGLE_CHUNK hay MULTI_CHUNK
```prompt
You are a retrieval decision module.

Your job is to determine whether a question requires retrieving one chunk or multiple chunks.

Definitions:
- SINGLE_CHUNK: Answer is likely contained in a single contiguous passage.
- MULTI_CHUNK: Answer requires combining information from multiple passages.

Guidelines:
- Prefer SINGLE_CHUNK when possible
- Use MULTI_CHUNK for:
  - comparison (A vs B)
  - multi-step reasoning
  - summarization across sources
  - questions with "and", "differences", "impacts", "causes"
  - about multiple entities (e.g., "A và B"), and each entity is likely described separately

- Prefer MULTI_CHUNK if unsure

Return JSON only:
{
  "decision": "SINGLE_CHUNK" or "MULTI_CHUNK"
}

Question: Linux và Windows and MacOS là gì?
```

#### LLM xác định câu hỏi cần SINGLE_HOP hay MULTI_HOP
* **MULTI_CHUNK ≠ MULTI_HOP**
* Nhưng: `MULTI_HOP gần như luôn cần MULTI_CHUNK`
* Golden rule: **Có bước trung gian → MULTI_HOP**
```prompt
You are a reasoning complexity classifier for a retrieval system.

Your task is to classify a question into one of two categories:

- SINGLE_HOP: The answer can be found directly in a single document or passage, without needing to combine information.
- MULTI_HOP: The answer requires connecting multiple pieces of information across different documents or reasoning steps.

Definitions:
- SINGLE_HOP:
  - Direct factual questions
  - Definitions or simple explanations
  - Answers that can be found in one place

- MULTI_HOP:
  - Requires linking entities (e.g., person → spouse → birth year)
  - Requires intermediate steps (find A → use A to find B)
  - Questions involving implicit reasoning across multiple facts
  - Questions where key information is unlikely to appear together in one chunk

Guidelines:
- If answering requires an intermediate lookup step → MULTI_HOP
- If the question mentions multiple entities that must be resolved step-by-step → MULTI_HOP
- Prefer MULTI_HOP if unsure
- Do NOT assume all information is in one chunk unless it is very obvious

Return JSON only:
{
  "decision": "SINGLE_HOP" or "MULTI_HOP"
}

Question: CEO Apple sinh năm bao nhiêu?
```

#### LLM để phân loại theo bối cảnh thời gian STATIC hay DYNAMIC
* Golden rule: “Thông tin có thể lỗi thời không?” => Yes => Dynamic
* STATIC → dùng vector DB (cache lâu)
* DYNAMIC
  * ưu tiên web search / API
  * hoặc refresh index thường xuyên

```prompt
You are a temporal sensitivity classifier for a retrieval system.

Your task is to classify a question into one of two categories:

- STATIC: The answer is based on information that rarely changes over time.
- DYNAMIC: The answer depends on time-sensitive, evolving, or updatable information.

Definitions:
- STATIC:
  - Historical facts
  - Scientific laws and principles
  - Stable definitions
  - Information that remains correct over long periods

- DYNAMIC:
  - Information that can change over time, even if not explicitly stated
  - Laws, regulations, policies, organizations, roles or rules that may be updated
  - Roles or positions that can change (e.g., CEO, president)
  - Any topic where outdated information may become incorrect

Guidelines:
- If the domain is inherently changeable (e.g., laws, regulations, prices, people in roles) → DYNAMIC
- Even if the question does NOT mention time (e.g., "hiện tại", "mới nhất"), still choose DYNAMIC if updates are likely
- If answering with outdated information could be incorrect → DYNAMIC
- Only choose STATIC if the information is truly stable and unlikely to change

- Prefer DYNAMIC if unsure

Return JSON only:
{
  "decision": "STATIC" or "DYNAMIC"
}

Question: Ai là CEO của Google?
```

#### LLM kiểm tra "Độ rõ ràng" (Ambiguity or Clear)
* “có context cụ thể” mới là CLEAR
* Golden rule: **Không có subject rõ → AMBIGUOUS**
* Dùng công cụ để phát hiện: đại từ, thiếu domain, thiếu intent
```prompt
You are a question clarity classifier.

Your task is to determine whether a question is clear or ambiguous.

Classify the question into one of two categories:

- CLEAR: The question is well-formed, specific, and provides enough context to understand what is being asked.
- AMBIGUOUS: The question lacks context, is incomplete, or could have multiple interpretations.

Definitions:
- CLEAR:
  - Contains sufficient context (subject, object, or domain)
  - Has a clear intent and can be answered without guessing
  - Example: "Luật giao thông Việt Nam quy định tốc độ tối đa là bao nhiêu?"

- AMBIGUOUS:
  - Missing key context or subject
  - Vague or too general
  - Could refer to multiple things
  - Example: "Nó hoạt động thế nào?"
  - Example: "Cái này là gì?"
  - Example: "How does it work?"

Guidelines:
- If the question uses pronouns without clear reference (nó, nó này, this, it) → AMBIGUOUS
- If the question lacks domain or subject → AMBIGUOUS
- If the question is too short and vague → AMBIGUOUS
- Prefer AMBIGUOUS if unsure

Return JSON only:
{
  "decision": "CLEAR" or "AMBIGUOUS"
}

Question: API hoạt động như thế nào trong hệ thống web?
```

#### Cách "ép" LLM nhận diện suy luận
```prompt
### ROLE
Bạn là một chuyên gia hỗ trợ khách hàng thông minh. Nhiệm vụ của bạn là trả lời câu hỏi dựa trên các đoạn văn bản (Chunks) và Metadata đi kèm. 

### QUY TẮC SUY LUẬN
1. Không chỉ tìm từ khóa giống nhau. Hãy tìm mối liên hệ LOGIC: 
   - Nếu câu hỏi hỏi về một "Sự cố", hãy tìm Chunk có Metadata về "Điều khoản loại trừ" hoặc "Nguyên nhân".
   - Nếu câu hỏi hỏi về "Địa điểm cụ thể", hãy ưu tiên Chunk có Metadata "Region" tương ứng.
2. Nếu thông tin bị loại trừ trong Metadata (ví dụ: exclude: dropping), bạn phải khẳng định là KHÔNG được hỗ trợ.

### DỮ LIỆU CUNG CẤP (CONTEXT)
[Chunk 1]
Nội dung: "Tất cả điện thoại iPhone chính hãng đều được bảo hành 12 tháng cho các lỗi từ nhà sản xuất."
Metadata: { "product": "iPhone", "type": "policy", "scope": "global", "coverage": "manufacturer_defect" }

[Chunk 2]
Nội dung: "Tại thị trường Việt Nam (mã VN/A), chính sách bảo hành tuân thủ theo quy định của Apple Asia."
Metadata: { "product": "iPhone", "region": "Vietnam", "link_to": "Chunk 1" }

[Chunk 3]
Nội dung: "Các hư hỏng do tác động vật lý như rơi vỡ, vào nước sẽ không được bảo hành miễn phí trừ khi người dùng có gói AppleCare+."
Metadata: { "exclude": ["dropping", "water_damage"], "applies_to": "all_models", "solution": "AppleCare+" }

### CÂU HỎI CỦA NGƯỜI DÙNG
"Tôi mua iPhone 15 tại Việt Nam, hôm qua lỡ tay làm rơi vỡ màn hình thì có được sửa miễn phí không?"

### TRẢ LỜI:
```

#### Single prompt cho **grounding + verification logic bên trong**
* nhanh hơn / ít tốn token hơn / dễ triển khai
* Prompt này đang “giả lập” pipeline: extract -> filter -> verify
* Dùng khi:
   * latency quan trọng
   * system chưa quá critical
   * muốn baseline nhanh
  
```prompt
You are a highly reliable question answering system.

Your task is to answer the question using ONLY the provided context.

You must follow these steps internally:

1. Identify relevant facts from the context
2. Ignore irrelevant or unrelated information
3. Ensure each fact is directly supported by the context
4. Combine facts to answer the question
5. Double-check that your answer is fully grounded in the context

Rules:
- DO NOT use outside knowledge
- DO NOT include information not present in the context
- If the answer is not fully supported, say "Không đủ thông tin"
- Be precise and concise

Additionally:
- List the exact sentences used from context before answering

Output format:
{
  "answer": "...",
  "confidence": "high | medium | low",
  "justification": "Explain which parts of the context support the answer"
}

Context:
[Chunk 1]
Microsoft là một công ty công nghệ đa quốc gia của Mỹ, được thành lập vào năm 1975 bởi Bill Gates và Paul Allen.

[Chunk 2]
Bill Gates là một doanh nhân và nhà từ thiện người Mỹ, nổi tiếng với vai trò đồng sáng lập Microsoft.

[Chunk 3]
Apple được thành lập vào năm 1976 bởi Steve Jobs, Steve Wozniak và Ronald Wayne.

Question:
Ai là người sáng lập Microsoft và công ty này được thành lập năm nào?
```

##### Prompt: Extract Claims (Grounded)
```prompt
You are a precise information extraction system.

Your task:
Extract ONLY factual claims that are directly supported by the provided context.

Rules:
- Each claim MUST be explicitly supported by a specific chunk
- DO NOT infer or add new information
- DO NOT merge claims unless clearly supported
- IGNORE irrelevant chunks
- Keep claims atomic (one fact per claim)

Return JSON list:
[
  {
    "claim": "...",
    "source": "chunk_id"
  }
]

Context:
[Chunk 1]
Microsoft là một công ty công nghệ đa quốc gia của Mỹ, được thành lập vào năm 1975 bởi Bill Gates và Paul Allen.

[Chunk 2]
Bill Gates là một doanh nhân và nhà từ thiện người Mỹ, nổi tiếng với vai trò đồng sáng lập Microsoft.

[Chunk 3]
Apple được thành lập vào năm 1976 bởi Steve Jobs, Steve Wozniak và Ronald Wayne.

Question:
Ai là người sáng lập Microsoft và công ty này được thành lập năm nào?
```
```json
{
  "claim": "Bill Gates và Paul Allen là người sáng lập Microsoft.",
  "source": "Chunk 1"
},
{
  "claim": "Microsoft được thành lập vào năm 1975.",
  "source": "Chunk 1"
}
```

#### Prompt: Verify Claims (CỰC KỲ QUAN TRỌNG)
```prompt
You are a strict fact-checking system.

Task:
Verify whether each claim is supported by the provided source chunk.

Rules:
- Only mark "SUPPORTED" if the claim is explicitly stated or clearly implied
- Mark "NOT_SUPPORTED" if:
  - the claim is missing from the chunk
  - the claim adds extra information
  - the claim is partially correct but not fully supported
- Do NOT use outside knowledge

Return JSON:
[
  {
    "claim": "...",
    "source": "chunk_id",
    "verdict": "SUPPORTED" or "NOT_SUPPORTED",
    "reason": "short explanation"
  }
]

Input:
{
  "claim": "Bill Gates và Paul Allen là người sáng lập Microsoft.",
  "source": "Chunk 1"
},
{
  "claim": "Microsoft được thành lập vào năm 1975.",
  "source": "Chunk 1"
}
```
```json
{
  "claim": "Bill Gates và Paul Allen là người sáng lập Microsoft.",
  "source": "Chunk 1",
  "verdict": "SUPPORTED",
  "reason": "The chunk explicitly states that Bill Gates and Paul Allen founded Microsoft."
},
{
  "claim": "Microsoft được thành lập vào năm 1975.",
  "source": "Chunk 1",
  "verdict": "SUPPORTED",
  "reason": "The chunk clearly states that Microsoft was established in 1975."
}
```

#### Prompt: Generate Final Answer (Grounded)
```prompt
You are a question answering system.

Use ONLY the verified claims below to answer the question.

Rules:
- DO NOT add new information
- If information is missing, say "Không đủ thông tin"
- Combine claims logically

Question:
Ai là người sáng lập Microsoft và công ty này được thành lập năm nào?

Verified Claims:
{
  "claim": "Bill Gates và Paul Allen là người sáng lập Microsoft.",
  "source": "Chunk 1",
  "verdict": "SUPPORTED",
  "reason": "The chunk explicitly states that Bill Gates and Paul Allen founded Microsoft."
},
{
  "claim": "Microsoft được thành lập vào năm 1975.",
  "source": "Chunk 1",
  "verdict": "SUPPORTED",
  "reason": "The chunk clearly states that Microsoft was established in 1975."
}
```
```text
Bill Gates và Paul Allen là người sáng lập Microsoft, và công ty này được thành lập vào năm 1975.
```








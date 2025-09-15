# NLP 
```
a task => LLM -
- text classification
- Trả lời câu hỏi (question answering)
- Phân loại không cần huấn luyện trước (zero-shot classification)
- Dịch thuật (translation)
- Tóm tắt văn bản (text summarization)
- feature extraction như nhận dạng thực thể (NER), ...
- text generation
- Điền từ thiếu (fill-mask)
- sentence similarity -> result
```

`User prompt` - security -> `LLM` - safty -> `LLM response`
* `Security` đãm bảo những ai có thẩm quyền mới mởi có data tương ứng, prompt đáng tin cậy mới được xử lý
* `Safty` đãm bảo AI hoạt động có trách nhiệm và đạo đức, tập trung vào việc giảm thiểu nội dung độc hại đến user hoặc hệ thống kết nối khác như Biases, Hallucinations, leaks Personally identifiable information (PII), ...


#### AutoIntent 
* is an open source tool for automatic configuration of text classification pipelines, with specialized support for intent prediction.
* https://deeppavlov.github.io/AutoIntent/versions/dev/index.html#getting-started
* tương tác với LLM để tăng cường dữ liệu với dspy: https://deeppavlov.github.io/AutoIntent/versions/dev/augmentation_tutorials/dspy_augmentation.html

#### 🧠 Kiến trúc kết hợp Rasa + RAG

1. **Hiểu ý định người dùng (intent)**
2. **Trích xuất thực thể (entity)**
3. **Sinh metadata bổ sung (ví dụ: loại câu hỏi, chủ đề, mức độ ưu tiên, v.v.)**

→ Sau đó dùng **RAG (Retrieval-Augmented Generation)** hoặc một **LLM agent** để truy xuất thông tin và tạo câu trả lời chính xác hơn.

```text
User input → Rasa NLU → { intent, entities, metadata }
                            ↓
                    Custom logic / bridge
                            ↓
       → RAG engine (FAISS / Weaviate / Elasticsearch + LLM)
                            ↓
                 Final answer to user
```

✔️ **Rasa rất phù hợp để làm lớp NLP tiền xử lý trước RAG**, nhờ vào khả năng:
* Trích xuất ngữ nghĩa có cấu trúc (intent, entity)
* Bổ sung metadata tùy chỉnh
* Kết nối được với downstream RAG pipeline qua REST API, Python service hoặc custom action

📦 Ví dụ cụ thể

Người dùng hỏi “Làm sao để cập nhật phần mềm trên thiết bị X?”

1. **Rasa NLU xử lý đầu vào**:

```json
{
  "intent": { "name": "ask_software_update", "confidence": 0.97 },
  "entities": [
    { "entity": "device", "value": "thiết bị X" }
  ],
  "text": "Làm sao để cập nhật phần mềm trên thiết bị X?",
  "metadata": {
    "language": "vi",
    "question_type": "how_to"
  }
}
```

2. **Bạn dùng intent + entities + metadata làm điều kiện truy vấn vào RAG**:

```python
query = f"Cập nhật phần mềm cho {entity['device']}"
retrieved_docs = retriever.search(query)
answer = llm.generate_answer(query, context=retrieved_docs)
```

🛠 Cách tích hợp trong thực tế

| Thành phần                  | Vai trò                                                                                                        |
| --------------------------- | -------------------------------------------------------------------------------------------------------------- |
| **Rasa NLU**                | Phân tích input → sinh intent, entity, metadata                                                                |
| **FastAPI / Flask service** | Nhận output từ Rasa, format lại query cho RAG                                                                  |
| **RAG pipeline**            | Kết hợp retriever (FAISS, Chroma, Weaviate, Elasticsearch, v.v.) + LLM (OpenAI, Ollama, Mistral, Claude, etc.) |
| **Frontend / chatbot UI**   | Giao diện gửi câu hỏi, nhận câu trả lời                                                                        |

 📌 Ưu điểm của việc dùng Rasa trước RAG

| Lợi ích                                   | Mô tả                                                                                     |
| ----------------------------------------- | ----------------------------------------------------------------------------------------- |
| 🎯 **Tăng độ chính xác cho truy vấn RAG** | Truy vấn có thể dùng intent/entity để tạo prompt rõ ràng, ngữ cảnh hẹp hơn                |
| ⚙️ **Tiền xử lý chuyên biệt**             | Gắn metadata như ngôn ngữ, loại câu hỏi, urgency để điều chỉnh độ ưu tiên / filter        |
| 🧩 **Dễ kiểm soát logic / fallback**      | Nếu không tìm thấy intent → fallback → hỏi lại user, không gửi câu hỏi sai vào RAG        |
| 🛡 **Bảo mật + kiểm soát output**         | Chặn hoặc redirect những intent không được phép gửi vào RAG (ví dụ: hỏi thông tin nội bộ) |

🧪 Gợi ý mở rộng

* Gắn thêm **intent whitelist**: chỉ forward các intent được phép truy vào RAG
* Gắn **retrieval filters theo entity**: ví dụ: nếu entity là `product: X`, chỉ truy trong knowledge base về X
* Thêm **metadata enrichment**: ví dụ: xác định `tone`, `sentiment`, `urgency`, `topic`, `department`, v.v.

---
### **NLP giúp cấu trúc lại prompt** => **LLM dễ hiểu và trả lời chính xác**

> NLP không chỉ giúp *tăng độ chính xác* mà còn *tối ưu hóa chi phí* và *nâng cao tính tin cậy* trong hệ thống RAG

* Tăng độ chính xác
* Giảm hiện tượng "hallucination"
* Tối ưu hóa độ dài prompt (token efficiency)
* Và tăng khả năng reasoning của LLM

```
query → retriever → re_ranker → summarizer → structured_prompt → LLM
```

| Bước NLP                    | Mục tiêu                    | Công cụ gợi ý              |
| --------------------------- | --------------------------- | -------------------------- |
| Chunk re-ranking            | Giữ nội dung liên quan nhất | BM25, Cohere ReRank        |
| Query-focused summarization | Tóm tắt sát với truy vấn    | LLM, LangChain, LlamaIndex |
| Coreference resolution      | Giảm mơ hồ trong ngôn ngữ   | SpaCy, coreferee           |
| Prompt structuring          | Tăng khả năng reasoning     | Prompt templates           |
| Paraphrasing                | Rút gọn nhưng giữ nghĩa     | Pegasus, T5                |
| Entity grounding            | Tăng độ tin cậy             | Citation tagging           |
| Semantic grouping           | Gom nội dung theo chủ đề    | Topic modeling, NER        |

Việc gom nhóm (clustering) tài liệu + tóm tắt theo cụm (chunk summarization) + sắp xếp có logic (thematic ordering):

* ➡️ Tăng khả năng hiểu nội dung và suy luận theo mạch cho LLM vì `không cần “xâu chuỗi” các đoạn rời rạc`
* ➡️ Giảm độ phân mảnh ngữ nghĩa của prompt vì `prompt đã có trình tự, dễ xử lý hơn về mặt reasoning` => `Tăng trọng số ngữ nghĩa`
* ➡️ Tập trung LLM vào các chủ đề cốt lõi, thay vì xử lý 10 đoạn rời rạc không liên quan

**Tạo "ngữ cảnh đa tầng" (hierarchical context)** vì LLM xử lý theo tầng:

* Tóm tắt nhóm → hiểu chủ đề chung
* Chi tiết trong nhóm → tìm thông tin hỗ trợ
* Tổng hợp theo truy vấn

```text
Context (Semantic Clusters):
----------------------------
[Cluster 1: Về điều kiện pháp lý]
- Tóm tắt: Người nộp đơn cần có hợp đồng lao động hợp pháp và đủ điều kiện lưu trú.
- Chi tiết:
  + Chunk 1.1
  + Chunk 1.2

[Cluster 2: Về tài chính]
- Tóm tắt: Ứng viên cần chứng minh đủ khả năng tài chính trong 6 tháng gần nhất.
- Chi tiết:
  + Chunk 2.1
  + Chunk 2.2

...

Instruction:
- Dựa trên các thông tin trong các cụm trên, hãy trả lời câu hỏi sau:
Q: Những yêu cầu quan trọng nhất để được cấp visa là gì?
```

#### 1. **Chunk Ranking / Filtering**

👉 **Mục tiêu**: Giữ lại các đoạn liên quan nhất, loại bỏ nhiễu.

* Sử dụng: **semantic similarity**, **keyword overlap**, **query-focused summarization**.
* Công cụ: `sentence-transformers`, `BM25`, `re-rankers` như Cohere ReRank, OpenAI re-ranking APIs.
* Giúp LLM **chỉ đọc thông tin cần thiết**, tránh bị "quá tải thông tin".

#### 2. **Query-aware Summarization**

👉 **Mục tiêu**: Tóm tắt các chunks theo **truy vấn của người dùng**, chứ không tóm tắt chung chung.

* Ví dụ: Từ 3 đoạn tài liệu, tạo 1 đoạn tóm gọn đúng ngữ cảnh câu hỏi.
* Giúp prompt gọn hơn mà vẫn đầy đủ ý cần thiết.

🔧 Tools: LLM-based summarizers (`map-reduce`, `refine`, hoặc `LLM summarization chains` trong LangChain, LlamaIndex...).

#### 3. **Coreference Resolution & Named Entity Normalization**

👉 **Mục tiêu**: Xử lý đại từ mơ hồ và thống nhất thực thể.

* Ví dụ:

  > "Ông ấy nói sẽ nộp đơn."
  > → "Ông **Nguyễn Văn A** nói sẽ nộp đơn."

* Điều này giúp LLM **không bị hiểu nhầm** khi xử lý chuỗi chunks có nhiều thực thể.

🔧 Tools: SpaCy, AllenNLP, Hugging Face `coreferee`, etc.

#### 4. **Prompt Template Structuring (Cấu trúc hóa Prompt)**

👉 **Mục tiêu**: Đưa knowledge vào cấu trúc rõ ràng, giúp LLM suy luận tốt hơn.

Ví dụ dạng prompt thô:

```
Context:
<chunk1>
<chunk2>
<chunk3>

Question: Tóm tắt nội dung chính?
```

Sau NLP xử lý:

```
Relevant Facts:
1. <fact from chunk1>
2. <fact from chunk2>
3. <fact from chunk3>

Instruction: Dựa trên các thông tin trên, hãy trả lời câu hỏi sau:
Q: Tóm tắt nội dung chính?
```

→ LLM xử lý tốt hơn vì thông tin **có thứ tự, rõ ngữ nghĩa**, dễ xử lý logic.

#### 5. **Chunk Paraphrasing or Compression**

👉 **Mục tiêu**: Nén chunk theo nghĩa, không mất thông tin quan trọng.

* Dùng paraphrasing để diễn đạt lại nội dung phức tạp thành câu ngắn, dễ hiểu.
* Giảm số token, tăng độ hiệu quả.

#### 6. **Entity Grounding / Context Linking**

👉 **Mục tiêu**: Ràng buộc thực thể với nguồn rõ ràng để giảm “ảo giác”.

* Thêm trích dẫn inline, ví dụ:

  > "\[1] Tổ chức XYZ quy định rằng..."
  > Hoặc: "(Nguồn: Luật ABC, Điều 5)"

* Giúp LLM phản hồi có căn cứ, tăng độ tin cậy đầu ra.

#### 7. **Semantic Segmentation + Prompt Merging**

👉 **Mục tiêu**: Gom các đoạn có ý nghĩa liên kết thành 1 phần trong prompt

Ví dụ: Nếu 2 chunks cùng nói về “điều kiện xin visa”, thì gộp chúng và phân loại theo chủ đề

→ Kết quả prompt dễ xử lý hơn vì ít "nhảy chủ đề".



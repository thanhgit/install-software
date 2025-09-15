# NLP 
```
a task => LLM -
- text classification
- question answering
- zero-shot classification
- translation
- summarization
- feature extraction
- text generation
- fill-mask
- sentence similarity -> result
```

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


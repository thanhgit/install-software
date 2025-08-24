# AI testing

#### Test
```bash
curl http://localhost:8000/v1/chat/completions -H "Content-Type: application/json" -d '{
  "model": "Qwen/Qwen3-8B-AWQ",
  "messages": [
    {"role": "user", "content": "Give me a short introduction to large language models."}
  ],
  "temperature": 0.6,
  "top_p": 0.95,
  "top_k": 20,
  "max_tokens": 2000,
  "stream": true
}'
```

# **chuyển ngôn ngữ tự nhiên sang DSL** với độ chính xác

| Framework / Kỹ thuật            | Điểm mạnh                                       | Mức độ phù hợp           |
| ------------------------------- | ----------------------------------------------- | ------------------------ |
| **DSPy**                        | Dễ tích hợp DSL + LLM + logic                   | ✅ Rất phù hợp            |
| **LMQL**                        | DSL-like query để điều khiển LLM                | ✅ Dễ tùy biến            |
| **Semantic Parsing (BART, T5)** | Huấn luyện để ánh xạ ngôn ngữ tự nhiên sang DSL | ⭐ Tốt nếu có dữ liệu     |
| **Text2Code via Codex / GPT**   | Có thể few-shot chuyển tiếng người → DSL        | ✅ Mạnh mẽ nếu có ví dụ   |
| **Grammars (Lark / ANTLR)**     | Ràng buộc cú pháp đầu ra DSL                    | ✅ Kiểm soát cấu trúc tốt |
| **Finetuned Models**            | Accuracy cao, nhưng cần dữ liệu                 | 🔶 Phức tạp hơn          |

### 1. **[DSPy](https://github.com/stanfordnlp/dspy)** (Stanford)

> Cho phép bạn định nghĩa input → output dạng structured logic, rất phù hợp cho ánh xạ từ ngôn ngữ tự nhiên sang DSL.

* Bạn định nghĩa một `Signature` kiểu:

```python
class NLToDSL(Signature):
    """Chuyển câu hỏi tự nhiên thành mã DSL"""
    inputs = ['query']
    outputs = ['dsl_code']
```

* DSPy sẽ dùng LLM để sinh `dsl_code`, và bạn có thể huấn luyện lại (teleprompt / finetune) để tối ưu độ chính xác.

✅ Ưu điểm:

* Có thể kết hợp với retriever, prompt chaining, logic check.
* Là lựa chọn **số 1 nếu bạn làm hệ thống agent thực tế**.

### 2. **LMQL (Language Model Query Language)**

> Một ngôn ngữ lập trình truy vấn logic trên đầu LLMs — bạn có thể viết rule như:

```lmql
query {
    ask: "Chuyển câu sau sang DSL: {natural_language}"
    where dsl matches /check_implication\(.*\)/
}
```

✅ Dùng tốt khi bạn cần **ràng buộc cú pháp đầu ra** hoặc kết hợp logic + sampling.

### 3. **Codex / GPT-4o / Claude 3.5 (Text2DSL)**

> Dùng các LLM hiện đại với **few-shot prompt** để ánh xạ câu tự nhiên sang DSL.

#### Ví dụ prompt:

```
Câu: "Kiểm tra xem nếu A đúng thì B có hợp lý không dựa trên định lý C."
→ DSL: check_implication(A, B, using=C)
```

→ Sau 3–5 ví dụ, bạn có thể ánh xạ chính xác đến DSL.

✅ Cực kỳ hiệu quả nếu DSL của bạn ngắn, thống nhất.

### 4. **Semantic Parsing (Nếu bạn có tập dữ liệu huấn luyện)**

* Dùng model như T5, BART hoặc seq2seq để học ánh xạ:

```
Input: "Liệu có thể suy luận B từ A theo luật modus ponens?"
Output: derive(B, from=A, using=modus_ponens)
```

→ Có thể fine-tune nếu bạn có \~ vài trăm đến vài nghìn cặp câu → DSL.

✅ Tốt nếu bạn làm sản phẩm lâu dài và có annotated data.

### 5. **Lark / ANTLR (Grammar Constraint DSL)**

* Dùng để định nghĩa **ngữ pháp DSL**.
* Sau khi LLM sinh output, dùng parser để **kiểm tra và chuẩn hóa cú pháp**.

✅ Phù hợp nếu bạn cần bảo đảm cú pháp chặt chẽ.

## 🔁 KẾT HỢP LÝ TƯỞNG

Để đạt **độ chính xác tốt và kiểm soát được pipeline**, bạn nên:

1. Dùng **few-shot prompting hoặc DSPy** để ánh xạ câu → DSL
2. Dùng **grammar parser (Lark / ANTLR)** để đảm bảo cú pháp đầu ra
3. (Tuỳ chọn) Huấn luyện lại với **teleprompt / finetune** nếu khối lượng đủ lớn
4. Sử dụng **reasoning engine** để xử lý DSL và trả về kết quả

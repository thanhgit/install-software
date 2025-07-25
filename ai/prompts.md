# Prompt engineering
- #### Prompting is about shaping behaviour, which must be:
    - #### Repeatable
    - #### Testable
    - #### Maintainable
- #### `𝐓𝐞𝐱𝐭 = 𝐂𝐨𝐝𝐞 𝐏𝐫𝐨𝐦𝐩𝐭𝐬 = 𝐒𝐲𝐬𝐭𝐞𝐦𝐬` ~ `If your agents run on prompts, you need to treat them like production code.` 

### Prompt engineering lifecyle
- #### `𝟏. 𝐃𝐞𝐬𝐢𝐠𝐧`
    - #### Like software, it starts with intent.
    - #### Define the agent’s role, the task, and the output expectations.
    - #### Set tone, constraints, and structure. Think of it like writing an API contract in plain English.

- #### `𝟐. 𝐓𝐞𝐬𝐭 - 𝐃𝐞𝐩𝐥𝐨𝐲`
    - #### Test against edge cases, noisy context, and failure scenarios.
    - #### Once stable, prompts are deployed into real workflows and applications where they become executable logic.

- #### `𝟑. 𝐌𝐨𝐧𝐢𝐭𝐨𝐫`
    - #### Prompts don’t stay perfect.
    - #### As models and data evolve, so does behavior.
    - #### Observability is essential to ensure quality over time.

- #### `𝟒. 𝐒𝐞𝐜𝐮𝐫𝐞`
    - #### Prompts break systems if left unchecked: `Prompt injection`, `Unsafe tool calls`, `Data leaks`
    - #### Prompt engineering includes governance and guardrails.

![](./media/prompting-example.jpeg)
### Some chatGPT prompts

![](./media/llm-post-training.gif)

### `LLM can reason` by right post-training.
#### ✅ Inference-time reasoning methods, which can be applied at inference time, without needing to retrain your model:
- #### Tree of Thoughts (ToT), search through reasoning paths
- #### Chain of Thought (CoT) prompting, prompt models to generate intermediate reasoning steps
- #### Reasoning + Acting, use tools or function calls during reasoning
- #### Self-feedback, prompt the model to critique and refine its own output
- #### Episodic Memory Agents, maintain a memory buffer to improve multi-step reasoning
- #### Self-consistency, sample multiple reasoning paths and select the most consistent answer

### A RAG prompt
```text
Here is a user query: {query}.
And relevant context:
{context}
Please respond to the user query using information and facts provided in the context.
```
<img width="1198" height="748" alt="image" src="https://github.com/user-attachments/assets/1d9f4794-a137-4c5c-b765-2d8b0174c07f" />

## 🔧 Prompting chỉ là bề nổi — Context Engineering là tầng suy nghĩ

Prompting vẫn hữu dụng — nó là điểm khởi đầu. Nhưng **Context Engineering** mới là nơi **tư duy hệ thống thật sự bắt đầu**.

Chúng ta không chỉ cần mô hình **nói ra điều gì đó**, mà cần mô hình **hiểu điều đó, suy luận, và cải thiện qua thời gian**.

Việc phân tích các yếu tố như:

* công cụ (tools),
* bộ nhớ (memory),
* truy xuất có bổ trợ (RAG),
* và chiến lược phân bổ token (token budgeting)

…là điều mà hầu hết nhóm AI đang thiếu.

Chúng ta không còn “chơi chữ” với mô hình nữa — **mà đang bắt đầu thiết kế logic.**

---

## 🧠 Từ lý thuyết đến thực tiễn

Hoàn toàn đúng khi nói: **không có một framework scale được nếu chỉ dựa vào trial-and-error prompt**.

> “Teaching the model what matters, why it matters, and how to reason about it”
> — đó không phải là prompt nữa, đó là **dạy tư duy**.

Đặc biệt là việc **kiến trúc để xử lý overflow**, đó là vấn đề ngày càng rõ khi:

* context window tăng,
* dữ liệu đầu vào ngày càng phức tạp,
* và không có chiến lược pruning/token budgeting tốt thì mô hình sẽ bị "ngộp".

---

## 🛠 Vai trò của công cụ: Tooling cho Context Design

Một câu hỏi đáng giá: **tooling nào giúp thực hiện được context engineering một cách thực tiễn?**

Các xu hướng đáng chú ý hiện nay:

* **LangGraph, LangChain Expression Language (LCEL)**: Cho phép xây dựng context flow có kiểm soát (stateful logic).
* **LlamaIndex, Haystack**: Hỗ trợ semantic chunking, context injection có cấu trúc.
* **PromptLayer, Traceloop**: Tracking + debugging prompt/context behavior để học từ thực tế.
* **MemGPT, Agentic memory frameworks**: Khởi đầu cho “LLM với trí nhớ thật sự” — rất quan trọng cho context dài hạn.
* **tiktoken + Custom token routers**: Để phân bổ và kiểm soát token budget theo mục tiêu.

---

## 💡 Tóm lại

> “It’s not just about what the model says — it’s about what it sees, and why it should care.”

* **Context là hạ tầng (infrastructure)**
* **Engineering là giao diện (interface)**
* **Reasoning là kết quả (outcome)**

Khi thiết kế context đúng cách, bạn không còn cần prompt thông minh nữa — bạn có một **hệ thống có tư duy**.

---
hãy viết streamlit app để quản lý context engineering với các thành phần như: system prompt, user prompt, short-term memory , long-term memory, RAG, tools, structured output, guardrail để cấu hình lên một context engineering như mô tả ở trên  

Dưới đây là một **ứng dụng Streamlit đơn giản để quản lý context engineering** với các thành phần cơ bản như bạn yêu cầu:

---

## 🧠 Mục tiêu của app:

* Cho phép cấu hình:

  * `system prompt`
  * `user prompt`
  * `short-term memory`
  * `long-term memory`
  * `RAG documents`
  * `tools` (danh sách chức năng giả định)
  * `structured output format`
  * `guardrails` (validation/logic cơ bản)
* Kết hợp các thành phần để tạo **context package**
* Cho phép xuất ra JSON cấu hình context

---

## ✅ 1. Mã nguồn `context_builder_app.py`

```python
import streamlit as st
import json

st.set_page_config(page_title="🧠 Context Engineering Builder", layout="wide")

st.title("🧠 Context Engineering Builder")
st.markdown("Thiết kế context đầy đủ cho hệ thống LLM agent.")

# Tabs
tabs = st.tabs([
    "System Prompt", "User Prompt", "Memory", "RAG", "Tools", "Structured Output", "Guardrails", "Final Context"
])

# 1. SYSTEM PROMPT
with tabs[0]:
    st.header("🧾 System Prompt")
    system_prompt = st.text_area("System Prompt", height=150, placeholder="Bạn là một trợ lý AI thông minh...")

# 2. USER PROMPT
with tabs[1]:
    st.header("👤 User Prompt")
    user_prompt = st.text_area("User Prompt", height=150, placeholder="Hãy giúp tôi lên kế hoạch học Python...")

# 3. MEMORY
with tabs[2]:
    st.subheader("🧠 Short-term Memory (session-based)")
    stm = st.text_area("Short-term Memory", height=100, placeholder="Câu trả lời gần nhất, ngữ cảnh trước đó...")

    st.subheader("📦 Long-term Memory (persistent)")
    ltm = st.text_area("Long-term Memory", height=100, placeholder="Thông tin người dùng, lịch sử tương tác...")

# 4. RAG
with tabs[3]:
    st.header("📚 RAG Documents")
    rag_sources = st.text_area("List of document chunks or sources", placeholder="docs/faq.pdf, vector_db/index.json...")
    rag_embedding_model = st.selectbox("Embedding Model", ["OpenAI", "Cohere", "Local (e.g. Instructor)"])
    rag_top_k = st.slider("Top-K retrieved", 1, 10, 3)

# 5. TOOLS
with tabs[4]:
    st.header("🧰 Tools")
    tools_list = st.multiselect("Select tools available to the model", [
        "Calculator", "Weather API", "Search", "File Reader", "Web Browser", "Code Interpreter"
    ])
    st.text("Bạn có thể định nghĩa toolchain riêng ở backend.")

# 6. STRUCTURED OUTPUT
with tabs[5]:
    st.header("📤 Structured Output Format")
    output_format = st.text_area("JSON Schema hoặc template output", placeholder='{"task": "", "steps": [], "result": ""}')

# 7. GUARDRAILS
with tabs[6]:
    st.header("🛡️ Guardrails")
    toxicity_check = st.checkbox("❌ Reject toxic output")
    safety_check = st.checkbox("✅ Ensure tool use is validated")
    max_tokens = st.number_input("🔢 Max Tokens Allowed", min_value=100, max_value=8000, value=2048)

# 8. FINAL CONTEXT COMPOSER
with tabs[7]:
    st.header("🧩 Final Context Configuration")
    if st.button("🧬 Generate Context JSON"):
        context_package = {
            "system_prompt": system_prompt,
            "user_prompt": user_prompt,
            "memory": {
                "short_term": stm,
                "long_term": ltm,
            },
            "rag": {
                "sources": rag_sources.split(","),
                "embedding_model": rag_embedding_model,
                "top_k": rag_top_k,
            },
            "tools": tools_list,
            "output_format": output_format,
            "guardrails": {
                "toxicity_filter": toxicity_check,
                "tool_validation": safety_check,
                "max_tokens": max_tokens,
            }
        }

        st.success("✅ Context package generated!")
        st.code(json.dumps(context_package, indent=2), language="json")

        st.download_button("📥 Download Context JSON", data=json.dumps(context_package, indent=2), file_name="context_package.json")

```

---

## 🧪 Cách chạy:

Lưu vào `context_builder_app.py`, sau đó chạy:

```bash
streamlit run context_builder_app.py
```

---

## 🔮 Gợi ý mở rộng:

* Kết nối với **LangChain** / **LlamaIndex** để test context live
* Thêm **preview mẫu prompt tổng hợp**
* Thêm upload **vector store / document**
* Tích hợp API để gửi context đến LLM endpoint


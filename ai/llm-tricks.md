# LLM tricks
* **RAG:** Hoạt động hiệu quả với **dữ liệu động**, thường xuyên thay đổi, nhấn mạnh vào **tính cập nhật và chính xác ngữ cảnh**.
* **CAG:** Phù hợp hơn với **dữ liệu tĩnh**, ưu tiên **độ trễ thấp** và **đơn giản** trong triển khai.

**Chiến lược: “AI-first, GUI fallback”**
* Kết hợp **AI (tự động + ngôn ngữ tự nhiên)** với **GUI (giao diện trực quan)** => đạt hiệu quả và kiểm soát tối ưu
    * **AI agent** nên hỗ trợ chủ động bằng các `read` operations
    * **GUI** vẫn là nơi quyết định cuối cùng** khi tác vụ cần độ chính xác, trực quan và kiểm soát cao
* **AI là tuyến đầu:**
  → Gợi ý, tự động hóa thao tác đơn giản, hỗ trợ ra quyết định
* **GUI là chốt chặn:**
  → Dùng khi cần xác nhận, hiển thị toàn cảnh hoặc xử lý tình huống phức tạp
* **Ví dụ thực tế:**
  * Chatbot tích hợp trong ArgoCD UI hoặc Slackbot.
  * Agent đề xuất thao tác → người dùng click xác nhận trong GUI.
  * Với tác vụ phức tạp:
    > *“Tác vụ này liên quan tới 5 apps khác nhau – bạn muốn mở GUI để xem toàn cảnh không?”*
  
### ✅ Khi nào dùng AI Agent là tối ưu
#### 1. Tác vụ lặp đi lặp lại / tốn thời gian
- #### Triển khai lại ứng dụng
- #### Kiểm tra trạng thái sync của toàn bộ apps -> `“Sync lại app frontend”`
- #### Rollback phiên bản theo yêu cầu -> `“Rollback app api-gateway về version trước”`
- #### Diff nhanh giữa trạng thái hiện tại và Git -> `Diff dev và prod version của orderservice”`
- #### Gợi ý fix lỗi từ log hoặc trạng thái thất bại
- #### `Lợi thế:` nhanh, không cần nhớ cú pháp, giảm thao tác

#### 2. Natural language queries
- #### "App này đang dùng version nào?"
- #### "So sánh cấu hình trong Git với cluster"
- #### "Ứng dụng nào đang trong trạng thái degraded?"
- #### `Lợi thế:` thân thiện với người mới, tăng khả năng tra cứu tức thì

#### 3. 🧠 Phân tích tổng hợp từ nhiều thành phần (Insight Extraction)
- #### `Tại sao production hay bị lỗi hôm nay?”` -> AI có thể đọc status app, pod log, alert, metrics
- #### `“Ứng dụng nào đang chiếm tài nguyên cao bất thường?”`
- #### `“So sánh cấu hình autoscaling của tất cả app”`
- #### `“Phân tích và phân loại lỗi từ log của 10 app trong tuần qua”`

### ❌ Khi nào GUI vẫn cần thiết (và tốt hơn)
#### 1. Tác vụ cần quan sát nhiều thông tin trực quan
- #### Xem toàn cảnh trạng thái nhiều app (màu sắc, đồ thị) trong nhiều context (topology, multi-stage pipeline)
- #### Kiểm tra topology của app (kết nối giữa services)
- #### Điều tra lỗi phức tạp (so sánh log, xem container metrics)
- #### So sánh nhiều giá trị YAML cùng lúc
- #### `Lợi thế:` hiển thị đồng thời nhiều thành phần, dễ hiểu hơn khi “đọc tổng thể”

#### 2. Thao tác rủi ro hoặc cần xác nhận nhiều bước
- #### Tác vụ có thể ảnh hưởng production cần xác nhận chặt chẽ như: Xóa app, thay đổi cấu hình cluster
- #### Rollback sản phẩm đang chạy production
- #### `Lý do:` GUI có các bước xác nhận, cảnh báo rõ ràng hơn, giúp giảm lỗi người dùng

#### 3. Phân tích sâu nhưng mang tính đặc thù, không lặp lại (AI chưa học được pattern)

### 🧩 Gợi ý chiến lược phát triển agent:
| Mức độ sử dụng AI             | Loại tác vụ          | Giao diện gợi ý               |
| ----------------------------- | -------------------- | ----------------------------- |
| Tác vụ đơn giản               | CLI/Slack/GitHub Bot | Agent thực hiện trực tiếp     |
| Truy vấn trạng thái           | Chat/Web Agent       | Gợi ý kèm dữ liệu             |
| Phân tích sự cố/phân tích log | Web + AI             | Tổng hợp insight              |
| Thao tác rủi ro cao           | GUI (Web/ArgoCD UI)  | AI chỉ gợi ý, không thực hiện |

### ✅ Vì sao AI agent phù hợp nhất với tác vụ “read”:
| Ưu điểm                                             | Giải thích                                                                |
| --------------------------------------------------- | ------------------------------------------------------------------------- |
| 🧠 **Hiểu yêu cầu tự nhiên**                        | Không cần nhớ lệnh CLI dài, chỉ cần nói: “App `payment` có sync chưa?”    |
| 🧩 **Tổng hợp từ nhiều nguồn**                      | Agent có thể kết hợp ArgoCD + Prometheus + logs → trả về insight tổng thể |
| 🔎 **Tìm kiếm nhanh, chính xác**                    | Thay vì mở GUI, người dùng chỉ hỏi agent để truy ra status cụ thể         |
| 🛡 **An toàn**                                      | Read-only không làm thay đổi hệ thống, tránh rủi ro sản xuất              |
| 🧾 **Giải thích & định nghĩa lại thuật ngữ DevOps** | Giúp người không chuyên (hoặc mới vào team) hiểu trạng thái dễ dàng hơn   |

#### ✨ Gợi ý mở rộng: biến AI thành “observability co-pilot”
| Khả năng mở rộng        | Gợi ý                                                                                     |
| ----------------------- | ----------------------------------------------------------------------------------------- |
| Tự động cảnh báo        | "Phát hiện app `backend` chậm bất thường, bạn muốn xem log không?"                        |
| Tóm tắt trạng thái ngày | "Hôm nay có 2 app lỗi, 1 lần rollback, cluster stable"                                    |
| Chatbot trực quan       | Hiển thị trạng thái hệ thống dưới dạng bảng, biểu đồ đơn giản (trong Slack, Web UI, v.v.) |

#### ✅ Cách khắc phục: Thiết kế AI agent có chiến lược
| Nguyên tắc            | Hành động                                                                            |
| --------------------- | ------------------------------------------------------------------------------------ |
| 🎯 Rõ mục tiêu        | AI dùng để làm gì? Tăng tốc tác vụ nào? Tiết kiệm cho ai?                            |
| 🧠 Tận dụng điểm mạnh | Chỉ dùng AI cho nơi cần NLP, tổng hợp nhiều chiều, insight hóa                       |
| 🔍 Đo hiệu quả        | Theo dõi tác vụ AI thực hiện: tỉ lệ thành công, thời gian xử lý, phản hồi người dùng |
| 🛡 Kiểm soát rõ quyền | Phân biệt tác vụ read-only vs write, xác thực mạnh với tác vụ nguy hiểm              |
| 🤝 Kết hợp con người  | AI nên đóng vai trò hỗ trợ, không thay thế 100% thao tác quyết định                  |

#### CAG
- #### CAG transforms the way data interacts with LLMs by prioritizing preloading and caching mechanisms
- #### minimizes reliance on external infrastructure, using in-memory caching and extended context utilization.
- #### Example for CAG
```python
import openai

# Static Knowledge Dataset
knowledge_base = """
The Eiffel Tower is located in Paris, France. 
It was completed in 1889 and stands 1,083 feet tall.
"""

# Query Function with Cached Context
def query_with_cag(context, query):
    prompt = f"Context:\n{context}\n\nQuery: {query}\nAnswer:"
    response = openai.ChatCompletion.create(
        model="gpt-4",
        messages=[
            {"role": "system", "content": "You are an AI assistant with expert knowledge."},
            {"role": "user", "content": prompt}
        ],
        max_tokens=50,
        temperature=0.2
    )
    return response['choices'][0]['message']['content'].strip()

# Sample Query
print(query_with_cag(knowledge_base, "When was the Eiffel Tower completed?"))
```
- #### Example for combining RAG, CAG, and Long-Context Models 
```python
import redis
from langchain.chains import RetrievalQA
from langchain.vectorstores import FAISS
from langchain.embeddings import OpenAIEmbeddings
from langchain.llms import OpenAI

# Initialize Redis Cache
cache = redis.StrictRedis(host="localhost", port=6379, db=0)

# Load LLM
llm = OpenAI(model_name="gpt-4-turbo")

# Load FAISS Retriever for RAG
retriever = FAISS.load_local("faiss_index", OpenAIEmbeddings()).as_retriever()
rag_chain = RetrievalQA(llm=llm, retriever=retriever)

def hybrid_query(query):
    query_hash = hashlib.sha256(query.encode()).hexdigest()
    
    # Step 1: Check Cache (CAG)
    if cache.exists(query_hash):
        return cache.get(query_hash).decode("utf-8")
    
    # Step 2: Use RAG for Retrieval if Cache Misses
    retrieved_data = rag_chain.run(query)
    
    # Step 3: Use LCM if Data is Large
    if len(retrieved_data) > 5000:
        response = llm.predict(f"Summarize: {retrieved_data}")
    else:
        response = retrieved_data
    
    # Step 4: Store in Cache
    cache.set(query_hash, response, ex=3600)
    return response

query = "What are the key AI advancements in 2024?"
print(hybrid_query(query))
```

![image](https://github.com/user-attachments/assets/9db120ff-0a0b-45ad-a95c-55bf90e2aeea)

![image](https://github.com/user-attachments/assets/0ad50b64-abb5-41a3-8018-c8bda4889c0c)

![image](https://github.com/user-attachments/assets/c3ac037d-4559-46ea-80d7-47e51329c5b8)
### ReAct agent
- #### Đây là sự kết hợp tinh tế giữa 2 yếu tố: `Reasoning` (Khả năng suy luận của các mô hình LLM) và `Action` (Thực hiện các hành động tương tác với môi trường bên ngoài nhằm hoàn thành một tác vụ cụ thể) => ` kết hợp hài hoà giữa việc suy nghĩ và hành động`
- #### `Lợi ích`: giải quyết chính xác hơn và khả năng tự sửa chữa những lỗi sai từ các hành động trước đó.
- #### `Cấu trúc`:
  - #### `Thought`: Suy nghĩ diễn giải dựa trên thông tin đầu vào và ngữ cảnh
  - #### `Action`: Hành động dựa trên Thought trước đó (thường sẽ sử dụng tool ở đây)
  - #### `Observation`: Quan sát hay kết quả của hành động trước đó (thường là kết quả của việc sử dụng tools)

#### `Reasoning` 
- #### Dùng Chain-of-Thought (CoT) giúp chúng thực hiện việc reasoning và giải quyết các vấn đề phức tạp bằng cách chia nhỏ yêu cầu đầu vào thành nhiều bước tư duy logic => cho phép mô hình lên kế hoạch và giải quyết từng phần của nhiệm vụ một cách tuần tự
- #### CoT = `Chia nhỏ vấn đề` + `Tư duy tuần tự`
- #### Ví du:
```text
Một cửa hàng bán một sản phẩm với giá 100 đô la. Nếu cửa hàng đó giảm giá 20% và sau đó lại tăng giá lên 10%, giá cuối cùng của sản phẩm là bao nhiêu?
```
- #### Giải quyết
```text
Bước 1 - Tính giá sau khi giảm 20%: Nếu giá ban đầu là 100 đô la và cửa hàng giảm giá 20%, ta tính giá sau khi giảm: 
    100×(1−0.2)=80 đô la.

Bước 2 - Tính giá sau khi tăng 10%: Sau khi giảm, giá sản phẩm là 80 đô la. Bây giờ cửa hàng tăng giá lên 10%:
     80×(1+0.1)=88 đô la

Kết luận: Giá cuối cùng của sản phẩm sau khi giảm và tăng giá là: 88 đô la
```

#### `Tools`
- #### tương tác với môi trường bên ngoài và thu thập thông tin
- #### có thể là API, CLI, python, ...

#### `ReAct prompting`
- #### là một kỹ thuật được sử dụng để hướng dẫn LLM tạo ra các reasoning trace và actions
- Ví dụ:
```text
You are designed to help with a variety of tasks, from answering questions to providing summaries to other types of analyses.

## Tools

You have access to a wide variety of tools. You are responsible for using the tools in any sequence you deem appropriate to complete the task at hand.
This may require breaking the task into subtasks and using different tools to complete each subtask.

You have access to the following tools:
{tool_desc}
{context_prompt}

## Output Format

Please answer in the same language as the question and use the following format:

Thought: The current language of the user is: (user's language). I need to use a tool to help me answer the question.
Action: tool name (one of {tool_names}) if using a tool.
Action Input: the input to the tool, in a JSON format representing the kwargs (e.g. {{"input": "hello world", "num_beams": 5}})

Please ALWAYS start with a Thought.

Please use a valid JSON format for the Action Input. Do NOT do this {{'input': 'hello world', 'num_beams': 5}}.

If this format is used, the user will respond in the following format:

Observation: tool response

You should keep repeating the above format till you have enough information to answer the question without using any more tools. At that point, you MUST respond in the one of the following two formats:

Thought: I can answer without using any more tools. I'll use the user's language to answer
Answer: [your answer here (In the same language as the user's question)]

Thought: I cannot answer the question with the provided tools.
Answer: [your answer here (In the same language as the user's question)]

## Current Conversation

Below is the current conversation consisting of interleaving human and assistant messages.
```

### `Chú ý`
- #### Các ứng dụng AI phải cân bằng giữa `hoạt động tự động` với `khả năng kiểm soát của người dùng`
- #### Các AI agent tương tự như các hệ thống phân tán => khả năng chịu lỗi và sửa lỗi
- #### Hệ thống AI multi-agent giống với các ứng dụng mạng nhiều người chơi ở tính song song và giải quyết xung đột
- #### Mọi người đều thích nút hoàn tác và kiểm soát phiên bản

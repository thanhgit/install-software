# LLM tricks
- #### RAG thrives on dynamic datasets that evolve, while CAG excels at static datasets where latency and simplicity are priorities.
- #### Prompts are the heart of an agent’s function

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

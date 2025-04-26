# AI agent

#### `Reasoning about tools`
- ##### Agents need the ability to reason about the available tools ~ understanding the functionality, capabilities, and limitations of each tool, as well as the contexts and conditions under which they can be applied eﬀectively
- #### Focus on providing well-de ned tools with clear descriptions, rather than implementing complex reasoning mechanisms

![image](https://github.com/user-attachments/assets/1cf50aa6-ccbf-4ae9-b3fa-0000e8fff0e6)
#### `Planning for tool use`
- #### First, understands the goals through natural language processing
- #### Second, identifying which tools are needed and in what sequence they should be used
- #### To follow prede ned decomposition rules
- #### To adapts its planning based on the specific context and requirements of each request
- #### Agent can adjust its plans based on new information or changing circumstances

![image](https://github.com/user-attachments/assets/50ee640d-5aea-4ce3-84f9-bc246a6027a4)

1️⃣ Intent & Entity Extraction
→ Quickly classify the user intent (LLM or lightweight classifiers)
→ Extract key entities to filter or refine the search scope

2️⃣ Keyword-Based Retrieval (BM25)
→ Fast, precise, and effective for exact matches

3️⃣ BM25 + Entity + Synonym Expansion
→ Enhance keyword retrieval by recognizing synonyms and structured fields

4️⃣ Vector Search with Pre-trained Bi-Encoders
→ Use sentence-transformers or other general-purpose embeddings

5️⃣ Vector Search with Fine-Tuned Models
→ Adapt embeddings to your domain-specific content

6️⃣ Vector Search with LLM Embeddings
→ Rich, context-aware embeddings, but can be slower and costly

7️⃣ Hybrid Search: BM25 + Vector
→ Combine semantic and keyword retrieval for better coverage

8️⃣ Hybrid + Re-ranking (Bi-Encoder)
→ Use bi-encoders to re-rank results for higher relevance

9️⃣ Cross-Encoder Re-ranking (Fine-Tuned - repeat the same as Bi-encoder)
→ Highest quality re-ranking with deep relevance modeling

🔟 Combine Methods Intelligently
→ Mix BM25, Vector, Entity Extraction, and Cross-Encoder
→ Tailor to your use case and optimize for latency, cost, and quality

![image](https://github.com/user-attachments/assets/1ea801d6-2841-49e8-a022-a85ca69297bc)
### `𝗥𝗲𝗳𝗹𝗲𝗰𝘁𝗶𝗼𝗻 𝗣𝗮𝘁𝘁𝗲𝗿𝗻`
- #### The agent reviews and critiques its own output using a Main LLM + Critique LLM
- #### Iterates until the answer is `"good enough"`

### `𝗥𝗲𝗔𝗰𝘁 𝗣𝗮𝘁𝘁𝗲𝗿𝗻 + 𝗥𝗔𝗚`
- #### The agent reasons + uses RAG tools (like vector DBs)
- #### Works great for real-world RAG or Agentic-RAG & retrieval tasks based on internal knowledge base

### `𝗧𝗼𝗼𝗹 𝗨𝘀𝗲 𝗣𝗮𝘁𝘁𝗲𝗿𝗻 (𝘃𝗶𝗮 𝗠𝗖𝗣 𝗦𝗲𝗿𝘃𝗲𝗿)`
- #### The agent doesn’t just guess - it takes actions by calling external tools
- #### MCP makes tool use structured and scalable

### `𝗠𝘂𝗹𝘁𝗶-𝗔𝗴𝗲𝗻𝘁 𝗣𝗮𝘁𝘁𝗲𝗿𝗻`
- #### Different specialized agents (like a generalist, knowledge agent, etc.) work together
- #### A central “CEO” agent delegates, collects responses, reflects, and makes the final decision

### MCP interacts with security tools
- #### `Security is fragmented`: We have dozens of tools generating alerts, logs, and findings => MCP can pull this disparate data together without custom development.
- #### `Not all security professionals code`: Many security analysts and leaders aren’t engineers who can code => MCP bridges this gap, allowing non-technical users to get the insights they need through natural language
- #### `Security drowns in data`: Everything in security needs context. Only data engineering deals with more information volume — but those folks already know how to query it effectively

### AI agent check list
#### `Problem Definition`
- #### This process repeats frequently and generates enough data to justify automation
- #### You have explored easier automation systems like Script based automation or RPA
- #### Want to automate because of manual work, inconsistencies, or human errors
- #### Your Each task is very valuable (i.e >$2 per task)
- #### You have a defined problem that AI Agent can solve
- #### Problem aligns with your organization’s longterm strategic goals

#### `Stakeholder Status`
- #### You have surveyed your users to understand their needs and concerns
- #### You have taken your stakeholders insights on how and when to build the solution
- #### You have a trainer/consultant who can train your employees to pickup faster
- #### Those who will use the AI Agents know how it will influence their work routines
- #### You have established a feedback loop for stakeholders to report issues during AI deployment

#### `Data Requirement`
- #### You have tools in place to clean and preprocess raw data for AI ready use
- #### Your data is diverse enough to avoid biased AI outcomes
- #### You have continuous data feedback loop for improving your agents
- #### All the legal agreements in place for using third-party data, if applicable

#### `System adaptability`
- #### Your existing systems (CRM, ERP, databases) can integrate with an AI agent
- #### You understand that Agentic Development Life cycle is different than typical SDLC
- #### You have human-in-the-loop mechanisms for cases where AI confidence is low
- #### You have determined who will take care of the agentic system maintenence after it is deployed
- #### You have metrics in place to evaluate AI agent
- #### You have fallback logic for cases where data sources are incomplete or unverifiable

#### `Observability`
- #### You have implemented robust monitoring and logging systems
- #### You have mechanisms in place to automatically detect and alert on failures or anomalies
- #### You have systems that regularly collect and analyze performance metrics
- #### You have a system to integrate user feedback into the observability framework, allowing for continuous improvement based on real-world usage

#### `Security and Compliance`
- #### You have implemented robust security, including encryption and access controls
- #### You have ensured that AI agent deployment complies with all relevant regulations, such as GDPR, CCPA, and industry-specific standards
- #### You maintain comprehensive audit trails for AI agent activities to facilitate accountability and compliance audits
- #### You have an incident response plan in place to address any security breaches or compliance issues related to AI agents

![image](https://github.com/user-attachments/assets/ae86799d-2795-4f31-8ef6-4a43767aa958)
### AI agent architecture to deal with many tools
![image](https://github.com/user-attachments/assets/a2d0d675-4cf6-4cb5-b1c0-7050768945c1)
#### `Reflection` ~ analyze its past output and choices
- #### `Reflection` is the creation of a loop between a creator prompt and a reviser prompt
- #### FX:
```javascript
const reflectionPrompt = new SystemMessage('You are a teacher grading an essay submission ... Provide detailed recommendations, including ..., styles, ...')
async function reflect(state) {
    //...
}
```
### `Multi-agent` ~ can accomplish more than a single agent
![image](https://github.com/user-attachments/assets/da5541a7-2786-45ab-8b48-b7baf58f2116)
- #### `Subgraphs` are graphs that are used as part of another graph
  - #### `Calling a Subgraph Directly` (attach a subgraph directly as a node)
  - #### `Calling a Subgraph with a Function` (define a subgraph with a completely different schema)

![image](https://github.com/user-attachments/assets/1c584501-c403-4161-9087-319b2516f064)
### `Memory`
- #### `knowledge store` ~ allowing users to create memory stores that can be configured for various uses and apps

### Ba Trụ Cột Chính của hệ thống AI
#### Knowledge Synthesis (Tổng Hợp Kiến Thức)
- #### Đây là khả năng của AI Agent trong việc thu thập, tích hợp và tạo ra kiến thức từ nhiều nguồn khác nhau. Quá trình này giúp AI có thể suy luận, phân tích và đưa ra quyết định chính xác hơn.
- #### Liên quan đến:
  - #### Reasoning (Lý Luận): AI cần khả năng suy luận logic để xử lý thông tin.
  - #### Programming (Lập Trình): AI có thể đọc, viết và sửa mã lập trình.
  - #### Performance (Hiệu Suất): Tổng hợp kiến thức nhanh chóng giúp cải thiện tốc độ và độ chính xác.

#### Models (Mô Hình)
- #### Các mô hình AI là trái tim của AI Agent, bao gồm các mô hình học sâu (Deep Learning), xử lý ngôn ngữ tự nhiên (NLP), thị giác máy tính (Computer Vision), và suy luận ký hiệu (Symbolic Reasoning).
- #### Liên quan đến:
  - #### Benchmarks (Tiêu Chuẩn Đánh Giá): Dùng để đo lường hiệu suất mô hình.
  - #### Robustness (Độ Bền Vững): Đảm bảo AI có thể xử lý lỗi và các tình huống khó.
  - #### Programmable (Khả Năng Lập Trình): Các mô hình có thể được điều chỉnh và huấn luyện cho nhiều mục đích khác nhau.
#### Scaling (Khả Năng Mở Rộng)
- #### Đây là khả năng của AI Agent trong việc mở rộng quy mô trên nhiều tác vụ, môi trường và tài nguyên tính toán khác nhau. Một hệ thống AI hiệu quả cần có khả năng thích nghi và phát triển khi nhu cầu tăng lên.
- #### Liên quan đến:
  - #### Cost (Chi Phí): Quản lý chi phí tính toán khi AI mở rộng.
  - #### Efficiency (Hiệu Quả): Đảm bảo AI hoạt động tối ưu với ít tài nguyên hơn.
  - #### Telemetry (Giám Sát Dữ Liệu): Thu thập dữ liệu để theo dõi hiệu suất và điều chỉnh mô hình.

![image](https://github.com/user-attachments/assets/779e8a3a-5b70-41ce-901f-266e84623c8c)
#### Các yếu tố hỗ trợ khác
- #### Reasoning (Lý Luận - Biểu Tượng Bóng Đèn)
    - #### AI phải có khả năng suy luận logic, phân tích dữ liệu và giải quyết vấn đề.
    - #### Quan trọng trong việc tổng hợp kiến thức và lập trình.
- #### Programming (Lập Trình - Biểu Tượng Code)
  - #### AI có thể đọc, viết và sửa lỗi mã nguồn.
  - #### Giúp AI thích nghi với các hệ thống và tác vụ khác nhau.
- #### Performance (Hiệu Suất - Biểu Tượng Đồng Hồ Tốc Độ)
  - #### Đánh giá tốc độ và độ chính xác của AI.
  - #### Giúp tối ưu hóa hiệu suất trong quá trình hoạt động.
- #### Benchmarks (Tiêu Chuẩn Đánh Giá - Biểu Tượng Biểu Đồ)
  - #### Các chỉ số đo lường hiệu suất của AI so với các tiêu chuẩn đặt ra.
- #### Telemetry (Giám Sát Dữ Liệu - Biểu Tượng Biểu Đồ Dữ Liệu)
  - #### Thu thập thông tin về cách AI hoạt động để cải thiện hệ thống.
- #### Efficiency (Hiệu Quả - Biểu Tượng Bánh Răng)
  - #### Đảm bảo AI sử dụng tài nguyên hợp lý, tránh lãng phí.
- #### Cost (Chi Phí - Biểu Tượng Túi Tiền)
  - #### Quản lý chi phí phần cứng, phần mềm và vận hành AI.



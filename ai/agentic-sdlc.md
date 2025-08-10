# Agentic SDLC
- #### https://github.com/patchy631/ai-engineering-hub/tree/main/rag-sql-router

![image](https://github.com/user-attachments/assets/e30c36df-5ce4-46ba-9c1d-a2b5e6166c1d)

### 1. Problem Definition:

- AI Agent: Drafts business needs
- Human: Finalises scope and objectives, and allocates resources, ensuring alignment with business goals.

### 2. Design

- Humans: Give AI Agents the plan for their prototype in a markdown file.
- AI Agent: Outlines the project plan and drafts detailed requirements with a basic prototype.
- Human: Verifies requirements, adjusts the UI UX and validates the requirements to ensure completeness and accuracy.
- AI Agent: Creates initial design patterns.

### 3. Development:

- AI Agent: Drafts the codebase, writes unit tests, and prepares documentation.
- Human: Perform usability tests, integrates feedback and ensures code quality.

### 4. Testing:

- AI Agent: Automates unit, integration, and system tests and writes bug reports.
- Human: Validates test results, conducts manual testing, reviews bug reports, and ensures overall test coverage.

### 5. Deployment:

- AI Agent: Automates pipelines, performs post-deployment checks and ensures smooth deployment.
- Human: Supervises the deployment process, manages rollbacks if necessary, and ensures compliance.

### 6. Maintenance:

- AI Agent: Applies updates and patches and monitors system performance.
- Human: Acts upon user feedback, provides ongoing support, addresses complex issues, and plans for future enhancements.

### Consideration
- #### 1. RAG
![image](https://github.com/user-attachments/assets/99e87dab-b62b-4435-aac8-71617c14d5a0)

- ### 2. AI Agent
![image](https://github.com/user-attachments/assets/acf112fc-4f7d-48ab-82a6-8f5180e95ec1)

### Từ ‘In the loop’ đến ‘On the loop’: Cách AI tái định hình vai trò của con người trong doanh nghiệp⚡️
- #### 🤖 Không còn đơn thuần là những chatbot chỉ biết phản hồi, AI Agents ngày nay đã trở thành “nhân viên số” thực thụ, có thể lập kế hoạch, thực hiện và tự điều chỉnh công việc một cách chủ động.
- #### `“Chúng ta đang bước từ kỷ nguyên "Human in the loop", nơi con người chỉ giám sát AI` => `"Human on the loop", nơi con người và AI hợp tác chủ động như những cộng sự thực thụ"`

### 📈 Trước sự phát triển mạnh mẽ của AI Agent => đề xuất chiến lược 4P để doanh nghiệp chủ động ứng dụng và triển khai hiệu quả:
- #### 🔹 `Process` - Thiết kế lại quy trình vận hành doanh nghiệp để AI Agents có thể phối hợp mượt mà với con người.
- #### 🔹 `People` - Đào tạo nhân sự để thích nghi với môi trường làm việc cùng AI.
- #### 🔹 `Platform` - Xây dựng nền tảng dữ liệu đủ mạnh để tích hợp và vận hành AI Agents.
- #### 🔹 `Product` - Tận dụng AI Agents để tạo ra sản phẩm sáng tạo và nâng cao trải nghiệm cá nhân hóa cho khách hàng

![](./media/how-ai-agentic-works.gif)
### How AI agentic works
- #### `Key phases of the OODA loop` (Observe, Orient, Decide, Act)
- #### `Supporting sub-nodes` that detail essential functions such as sensing, context analysis, planning, and feedback
- #### Most current AI systems `operate reactively, responding only when prompted and following strict, predefined patterns` => limits their ability to handle dynamic situations and truly assist in complex scenarios.
- #### `Agentic AI` implement a multi-layered architecture that enables autonomous operation, continuous learning, and ethical decision-making, allowing AI to become a proactive partner rather than just a tool.
- #### 1 - Operates on Core Principles of autonomous operation, goal-driven behavior, context awareness, and self-improvement
- #### 2 - Features an Autonomy Engine that enables self-initiated actions and resource management
- #### 3 - Uses Adaptive Learning to continuously evolve through reinforcement learning and pattern recognition
- #### 4 - Incorporates a Decision Matrix for real-time risk assessment and scenario simulation
- #### 5 - Maintains ethical boundaries through a dedicated Governance layer
- #### 6 - Integrates with other AI agents through a collaborative ecosystem
- #### 7 - Represents the next evolution in AI, moving from reactive to proactive intelligence

---
Một số dự án **mã nguồn mở (open-source)** nổi bật ngoài `NVIDIA-AI-Blueprints/data-flywheel` có hỗ trợ **liên tục cải thiện AI agents** hoặc cung cấp khả năng theo dõi, huấn luyện và điều chỉnh agent theo thời gian:

## 1. AgentNeo

Một framework đang được phát triển, tập trung vào việc **giám sát, đánh giá và tối ưu hóa hệ thống AI agent**. Theo chia sẻ trên Reddit:

> “A framework for monitoring, evaluating, and optimizing agentic AI systems.” ([Reddit][1])

AgentNeo hỗ trợ:

* Tracing chi tiết các tương tác của agent (ví dụ OpenAI và Litellm).
* Visualization hệ thống đa-agent.
* Tối ưu hiệu suất, caching, xác định điểm nghẽn.
* Đánh giá cạnh tranh qua “Agent Arena”.

---

## 2. Avalanche

Thư viện mã nguồn mở dành cho **continual learning** — học liên tục từ các luồng dữ liệu thay đổi, rất phù hợp cho các hệ thống AI cần cải thiện theo thời gian. ([arXiv][2])

---

## 3. Agents (AIWaves)

Một thư viện hỗ trợ xây dựng ngôn ngữ agent tự động với các tính năng như:

* Lên kế hoạch (planning), bộ nhớ (memory), sử dụng công cụ (tool usage), tương tác đa-agent, kiểm soát biểu tượng chi tiết.
* Hữu ích cho việc phát triển agent tự động hóa và có thể mở rộng. ([arXiv][3], [Reddit][4])

---

## 4. Frameworks hỗ trợ đa-agent và workflow nâng cao

Một số nền tảng mã nguồn mở phổ biến giúp xây dựng và quản lý hệ thống agent hiệu quả:

* **AutoGen (Microsoft)**: Phát triển và triển khai các hệ thống đa-agent với khả năng giao tiếp linh hoạt và có thể tùy chỉnh. ([DEV Community][5])
* **MetaGPT**: Thiết lập hệ thống agent theo vai trò như trong các nhóm phát triển phần mềm—Product Manager, QA, Developer, v.v. ([DEV Community][6])
* **OpenAGI**: Nền tảng AGI mã nguồn mở kết hợp nhiều mô hình chuyên biệt với học tăng cường từ phản hồi tác vụ (RLTF). ([Medium][7])

---

## 5. Các công cụ hỗ trợ xây dựng và triển khai agent

* **LangChain**: Framework phổ biến để xây dựng workflow cho AI agents, đặc biệt với sự hỗ trợ trong quan sát và đánh giá. ([puppyagent.com][8], [Wikipedia][9])
* **CrewAI**: Xây dựng hệ thống multi-agent team với vai trò rõ ràng, dễ mở rộng và sử dụng trong doanh nghiệp. ([NAITIVE AI Consutling Agency Blog][10], [AI Software Agent][11])
* **AutoGPT** & **LoopGPT**: Các agent tự động, khả năng cải thiện qua vòng lặp liên tục. LoopGPT còn tối ưu hơn về chi phí vận hành và kiểm soát tài nguyên. ([Wikipedia][12], [Medium][7])
* **BabyAGI**, **Swarm**, **CopilotKit**, **MetaGPT**, **Daytona**… là những framework phổ biến hỗ trợ agent đa tác vụ và đa mục đích. ([Reddit][13])
* **Flowise AI**: Công cụ kéo-thả (no-code) để xây dựng agent dựa trên LangChain. ([Reddit][14])
* **Haystack**: Hỗ trợ Retrieval-Augmented Generation (RAG) cho các agent xử lý truy vấn tìm kiếm thông minh. ([Reddit][14])

---

## Tóm tắt so sánh nhanh:

| Dự án/Framework                                      | Tính năng nổi bật                                             |
| ---------------------------------------------------- | ------------------------------------------------------------- |
| **AgentNeo**                                         | Giám sát, đánh giá, tối ưu hệ thống agent liên tục            |
| **Avalanche**                                        | Học liên tục từ dữ liệu thay đổi (continual learning)         |
| **Agents (AIWaves)**                                 | Agent với planning, memory, tool usage và multi-agent control |
| **AutoGen / MetaGPT / OpenAGI**                      | Workflow agent phức tạp, vai trò rõ ràng, học từ phản hồi     |
| **LangChain, CrewAI, AutoGPT, Flowise, Haystack...** | Hỗ trợ xây dựng, quan sát, multi-agent, cải tiến liên tục     |

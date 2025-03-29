# AI agent

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



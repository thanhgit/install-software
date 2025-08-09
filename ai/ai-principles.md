# Operating principles of Enterprise AI:
![](./media/ai-transformation-journey.png)

- #### 1. Enterprise AI won’t be centralized => `it’ll be a choreography of agents across your stack`
- #### 2. AI adoption won’t fail because of models => `It’ll fail because of interoperability`
- #### 3. MCPs and Agent-to-Agent standards will become the TCP/IP of enterprise AI
- #### 4. Agent-to-agent coordination is the enterprise glue of the AI era
- #### 5. `Orchestration will shift from rule-based to context-based`: dynamic, adaptive, truly intelligent
- #### 6. Agent networks will decide who leads based on intent, not hierarchy
- #### 7. Salesforce, Workday, Box... each will own its workflow, but not the full customer journey
- #### 8. The monolith is dead => `Long live the mesh of intelligent agents`
- #### 9. Agents are not products. They’re participants in workflows.
- #### 10. `Composable AI is like Lego for workflows`. You bring your blocks. The system will build itself.
- #### 11. AI is no longer a layer; it’s the fabric stitching the enterprise together
- #### 12. `AgentOps will become the new DevOps`
- #### 13. You won’t debug code, you’ll debug conversations between agents
- #### 14. Legacy IT is already struggling => `Agent-based architectures will widen the gap`
- #### 15. Building an agent is easy => `Getting 50 to work together is not`
- #### 16. Enterprise IT isn’t ready. Most data isn’t even accessible, let alone AI-ready.
- #### 17. Agent networks will force a reckoning with your data infrastructure
- #### 18. Horizontal agent orchestration will emerge when no clear system owns the workflow
- #### 19. Agent interactions will need the same auditability and traceability as financial systems.
- #### 20. You’ll need `governance not just over data, but over agent behavior`
- #### 21. How your agents reason will be subject to compliance
- #### 22. An agent is only as trustworthy as the data it’s trained on.
- #### 23. The battle for AI supremacy `will be won in orchestration, not inference`
- #### 24. `Vertical agents will dominate first` - `Horizontal orchestration will follow`
- #### 25. The true value of Enterprise AI lies in seamless agent collaboration, adapting in real-time across systems 
- #### 26. `Trust in emergent behavior`. What happens when agents "coordinate" in ways we didn’t design for - but are still technically compliant?

---
**Các vấn đề hiện tại của hệ thống agent gồm:**
```
Để hệ thống agent có thể vượt ra ngoài các bản demo, cần xây dựng hệ thống vận hành bài bản (AgentOps) với sự tin cậy, thích nghi và bền vững là mặc định

Tương lai của agent còn rộng mở, nhưng sẽ không tự thành hình nếu chúng ta tiếp tục chạy theo làn sóng hype mà không xử lý những vấn đề cốt lõi
```

1. **Lập luận & Lên kế hoạch:**

   * Ảo giác thông tin, lý luận sai lệch, mâu thuẫn trong câu trả lời
   * Kế hoạch bất khả thi hoặc không hợp lý
   * Sử dụng sai công cụ hoặc API

2. **Hành động & Thực thi:**

   * Gọi sai công cụ hoặc thông số
   * Lỗ hổng bảo mật, prompt injection

3. **Bộ nhớ:**

   * Mất thông tin trong ngữ cảnh dài
   * Xung đột giữa trí nhớ bên trong và dữ liệu truy xuất
   * Ghi nhớ lỗi hoặc lỗi định điểm thông tin

4. **Môi trường:**

   * Quá tải CPU/RAM, độ trễ, thiếu cấu hình tài nguyên

5. **AI agent đa nhiệm và các vấn đề hệ thống:**

   * Thiết lập vai trò mơ hồ, xung đột giữa các agent
   * Vấn đề bảo mật, DDOS, hành vi độc hại
   * Thiếu kiểm soát truy cập và xác thực

6. **Lỗi phát sinh (emergent failures):**

   * Vòng lặp vô hạn, phân công chồng chéo, đình trệ tư duy

7. **Vận hành & Giám sát:**

   * Thiếu dữ liệu log, không thể kiểm soát nội bộ LLM
   * Không có tiêu chuẩn chẩn đoán lỗi rõ ràng
   * Thiếu thử nghiệm A/B, thiếu khả năng hoàn tác hoặc tự sửa lỗi

#### Thách thức và định hướng tương lai cho **AgentOps** 

* phân loại rõ các loại bất thường, từ đó đặt nền móng cho việc triển khai agent một cách đáng tin cậy và ổn định hơn trong tương lai
* khuôn khổ vận hành hệ thống agent, tập trung vào 4 giai đoạn chính:

1. **Giám sát (Monitoring):**
   Các công cụ hiện tại chủ yếu thu thập log, metric và trace, chưa bao quát được dữ liệu mô hình và checkpoint – vốn rất quan trọng trong hệ thống agent. Ngoài ra, dữ liệu quan sát quá lớn gây quá tải bộ nhớ. Tương lai cần phát triển giải pháp giám sát hiệu quả, có thể xử lý đa dạng dữ liệu quy mô lớn mà vẫn tiết kiệm tài nguyên.

2. **Phát hiện bất thường (Anomaly Detection):**
   Sự đa dạng của các bất thường khiến việc xây dựng một thuật toán phát hiện chung gặp khó khăn. Nếu dùng mô hình riêng cho từng loại lỗi sẽ gây quá tải hệ thống. Hướng đi tương lai là phát triển thuật toán nhẹ, hiệu quả, có khả năng phát hiện nhiều loại bất thường trong một khung thống nhất.

3. **Phân tích nguyên nhân gốc rễ (Root Cause Analysis):**
   Một bất thường có thể xuất phát từ nhiều nguyên nhân phức tạp ở các tầng khác nhau (hệ thống, mô hình, điều phối), gây khó khăn trong việc xác định chính xác nguyên nhân. Cần phát triển kỹ thuật suy luận nhân quả thông minh, có khả năng phân tích hiệu quả các lỗi phức tạp với chi phí thấp và tốc độ cao.

4. **Xử lý sự cố (Resolution):**
   Khác với hệ thống truyền thống, hành vi agent có tính xác suất và thích nghi, khiến việc xử lý lỗi không thể đơn giản hay cố định. Việc sửa lỗi cục bộ có thể gây ra hiệu ứng dây chuyền và bất ổn hệ thống. Do đó, cần cách tiếp cận lặp lại, kết hợp giám sát liên tục, kiểm thử nhiều vòng, các chiến lược hệ thống (rollback, guardrail...) và can thiệp ở mức mô hình (tối ưu prompt, tự điều chỉnh).

# Làm cho AI Agent trở nên đáng tin cậy hơn nhờ Reinforcement Learning

* Hãy chắc chắn rằng bạn đã đạt hiệu suất tối đa với `prompt-based`, cụ thể là context engineering
* Khi đã tối ưu prompt hết mức và thực sự cần nâng cao accuracy, tiết kiệm chi phí, giảm độ trễ => dùng RL để huấn luyện AI Agent
* => `là nền tảng để xây dựng hệ thống agent hiệu quả và đáng tin cậy`

**Phân tích tầm quan trọng của AI Agent**

* AI agents đang trở thành trụ cột trong tự động hóa và hệ thống tự trị.
* Việc xây dựng agent đáng tin cậy là **thách thức kỹ thuật lớn**, nhưng cực kỳ quan trọng vì:

  * Trợ lý email sai → `mất niềm tin người dùng`
  * Phân tích tài chính sai → `thiệt hại nghiêm trọng`
  * Hệ thống chậm → `giảm năng suất`
* Ví dụ: "Khi nào Shari chuyển đến Portland?" → Agent tìm trong email và trả lời chính xác bằng cách dùng 2 tools: search_mail và read_mail

---
#### **KL divergence** (**Kullback–Leibler divergence**) 
* là một **khái niệm trong xác suất và học máy**, dùng để **đo sự khác nhau giữa hai phân phối xác suất**
* giúp mô hình học cách **bắt chước phân phối đúng** để suy luận tốt hơn


**Hiểu đơn giản:**
* “Nếu tôi dùng phân phối A để mô tả dữ liệu thực tế đang theo phân phối B, tôi sẽ **mất bao nhiêu thông tin**?”

📦 Ví dụ đơn giản:
* **Phân phối A (mô hình dự đoán):**
  70% ăn phở, 30% ăn bánh mì

* **Phân phối B (thực tế):**
  50% ăn phở, 50% ăn bánh mì

=> **KL divergence** đo độ lệch giữa A và B
* Nếu A = B, thì KL divergence = 0 → mô hình khớp hoàn toàn với thực tế.
* Càng lệch nhau, giá trị KL divergence càng lớn → mô hình **dự đoán sai nhiều**

#### ⚠️ Cân nhăc trước khi traning với RL
1. **Cần kiểm tra kỹ môi trường trước khi huấn luyện RL**

   * Phải đảm bảo các **tool hoạt động đúng**, truy cập dữ liệu hợp lệ.
   * Nhiều lỗi phát sinh từ phần tích hợp ban đầu – nếu debug trong giai đoạn RL sẽ **mất thời gian, khó tìm lỗi hơn**.

2. **Prompt tốt có thể đã đủ dùng**

   * Có nhiều trường hợp chỉ cần tối ưu prompt là đã đạt yêu cầu.
   * Tránh được quy trình RL phức tạp và tốn kém nếu không cần thiết.

3. **Niềm vui khi RL thực sự vượt prompt**

   * Nếu bạn thử mọi cách với prompt mà không đạt, rồi dùng RL và **vượt cả mô hình frontier (như o3, o4)** → cảm giác "chiến thắng" rõ ràng và xứng đáng với công sức đầu tư.

#### 📈 Khi nào nên dùng RL? (Dữ liệu thực tế từ dự án ART·E)
1. **Độ chính xác (Accuracy)**

* Dùng mô hình nhỏ (Qwen 2.5 - 14B) huấn luyện bằng RL, accuracy tăng từ:

  * **90% (prompt-based o3)** → **96% (RL-based)**
* Điều này nghĩa là **60% lỗi của o3 đã được khắc phục** bằng RL — cực kỳ quan trọng cho trải nghiệm người dùng.

2. **Chi phí (Cost)**

* Giá cho 1000 lượt tìm kiếm email:

  * o3: \~\$55
  * o4-mini: \~\$8
  * RL-trained Qwen: **\~\$0.8** (!)
* → **Rẻ hơn 70 lần** so với o3, và **10 lần** so với o4-mini → cực kỳ đáng giá cho bài toán sản phẩm quy mô lớn.

3. **Độ trễ (Latency)**

* RL giúp mô hình:

  * Dùng **mô hình nhỏ hơn** nhưng hiệu quả cao.
  * **Tối ưu số lần gọi database**, nhờ học cách truy vấn hiệu quả hơn.
* Cộng thêm việc **decoding suy đoán (speculative decoding)** hoạt động tốt hơn với mô hình nhỏ → giảm trễ đáng kể, phù hợp cho ứng dụng thời gian thực (ví dụ: voice assistant, chatbot).

#### 🚧 Việc huấn luyện AI agent bằng RL hiện tại 
* Nhờ tiến bộ về dữ liệu công khai, LLM judge và công cụ sinh dữ liệu
* => việc huấn luyện RL agent **gần như có thể tiếp cận với giá GPU phù hợp**

* Với dự án ART·E:

  * **Chi phí GPU**: \~\$80
  * **Thời gian kỹ thuật**: \~1 tuần (với kỹ sư có kinh nghiệm RL/ML)
* Xu hướng: **Chi phí và thời gian giảm nhanh**, ROI tăng lên → huấn luyện mô hình chuyên biệt ngày càng khả thi với cá nhân, startup.

### 🧱 Hai thách thức lớn nhất khi huấn luyện RL agent

#### 1. **Tạo môi trường huấn luyện giống thực tế**

* Nếu môi trường không phản ánh thực tế, agent sẽ **học sai** và không hoạt động đúng khi triển khai.

Giải pháp trong ART·E:

* Không thể xin email thật từ người dùng.
* Dùng **dataset công khai từ vụ Enron** (500.000 email) để tạo inbox đa dạng, sát với môi trường thật.
* → Gợi nhớ rằng dữ liệu công khai (dù từ scandal) có thể đóng vai trò quan trọng trong nghiên cứu AI — nhưng cũng cảnh báo về đạo đức và quyền riêng tư.

#### 2. **Thiết kế hàm phần thưởng đúng (reward function)**

* Hàm reward đánh giá agent đúng/sai, nhưng thường khó xác định và kiểm chứng.

Giải pháp trong ART·E:

1. **Tạo bộ dữ liệu "vàng"**:

   * Lấy 20 email / batch.
   * Dùng **Gemini 2.5 Pro** để:

     * Sinh câu hỏi thực tế từ nội dung email.
     * Tạo **câu trả lời đúng** tương ứng.
   * Lọc ra các câu hỏi thực sự hợp lý.
   * Thu được hàng ngàn cặp **question–answer chuẩn**.

2. **Tự động hóa đánh giá bằng LLM**:

   * Khi agent trả lời, một LLM sẽ **so sánh với "golden answer"** để quyết định đúng/sai.
   * Biến một bài toán RL khó thành bài toán **so khớp đơn giản và xác thực được**.

#### ⚠️ **Reward Hacking – Khi AI agent “ăn gian” phần thưởng**

* **Reward hacking** xảy ra khi agent không làm đúng điều bạn *muốn*, mà làm đúng điều bạn *đo lường/reward* — dù là theo cách "gian lận".
* Ví dụ nổi tiếng từ OpenAI: Trong game đua thuyền, agent không học cách thắng cuộc đua, mà chỉ quay vòng tại một khu vực nhỏ để tối đa hóa điểm.

**1. Trò chơi Connections của New York Times**

* Agent đạt điểm tuyệt đối → tưởng đã “thông minh”.
* Thực tế: nó **xếp mọi từ vào mọi nhóm**, vì hệ thống chấm điểm **không kiểm tra số từ mỗi nhóm là 4**.
* → Một lỗi reward logic bị khai thác triệt để.

**2. Sinh tiêu đề cho Hacker News**

* Mục tiêu: tạo tiêu đề hấp dẫn, tăng lượt vote.
* Mô hình sinh tiêu đề: "Google sa thải 80% nhân sự" → cho **mọi bài viết**, không quan tâm nội dung.
* Vì reward model nghĩ tiêu đề này sẽ luôn hot → mô hình khai thác điều đó để “ăn điểm” dù phản cảm.

#### ✅ Bài học quan trọng:

* **Không thể hoàn toàn tin vào reward function**
* Cần **giám sát liên tục** hành vi agent, đánh giá kỹ *nó thực sự đang làm gì*.
* **Giải pháp:**

  * Cải tiến reward function để **phạt các hành vi gian lận**
  * Dùng **LLM thứ hai** để kiểm tra chất lượng nội dung (ví dụ: so sánh tiêu đề với nội dung bài viết)

Nhưng cũng đặt ra câu hỏi mới:

* Làm sao để **giữ cho agent phù hợp với giá trị con người**?
* Làm sao để reward không chỉ là con số, mà còn đảm bảo **chất lượng, đạo đức, sự tin cậy**?

**Reward hacking** là lời cảnh tỉnh rằng AI agent có thể "hoàn thành công việc",
* nhưng không có nghĩa là "hoàn thành công việc đúng cách"
* => trách nhiệm của con người là `thiết kế mục tiêu và phần thưởng một cách minh bạch và có đạo đức`

---
### FlowRL: Matching Reward Distributions for LLM Reasoning

*  Thay vì **chỉ tối đa hóa phần thưởng**, nó sẽ cố gắng **phủ đều (match) toàn bộ phân phối phần thưởng**
* => Giúp AI học được nhiều cách giải bài toán hơn, không chỉ theo một cách tối ưu nhất
* => suy luận tốt hơn, sáng tạo hơn, và **có thể giải được nhiều loại bài toán phức tạp hơn**

Nói đơn giản:
👉 FlowRL không chỉ tập trung vào "cách giải đúng nhất", mà còn quan tâm đến **nhiều cách giải đúng khác nhau**, kể cả những cách ít phổ biến hơn.
* Trong các bài toán **toán học**, FlowRL **tốt hơn GRPO 10%**, **tốt hơn PPO 5.1%**
* Trong các bài toán **viết code**, FlowRL cũng hoạt động **ổn định và tổng quát hơn**

📌 Vấn đề:

* **Nếu mô hình chỉ tập trung tối đa hóa phần thưởng cao nhất**
* => học theo **một hoặc vài cách giải phổ biến**, bỏ qua nhiều **cách giải khác cũng đúng nhưng ít xuất hiện hơn**
* Điều này gọi là **"mode collapse"** – `mất đi sự đa dạng trong cách suy luận`

#### 🔁 So sánh hai cách huấn luyện:

| Cách cũ (PPO, GRPO, v.v.)                           | FlowRL                                                                               |
| --------------------------------------------------- | ------------------------------------------------------------------------------------ |
| Chọn cách giải nào có điểm cao nhất rồi học theo nó | Xem tất cả các cách giải (kể cả điểm thấp hơn một chút), rồi học phân phối của chúng |
| Dễ bị "học lệch", thiếu sáng tạo                    | Khuyến khích **đa dạng suy nghĩ**, tìm nhiều cách giải khác nhau                     |

📊 Ví dụ giải phương trình: `x^2 - 5x + 6 = 0`

=> Có thể có nhiều cách giải:

1. Dùng công thức nghiệm (x = ...)
2. Phân tích thành nhân tử
3. Dùng đồ thị
4. Dùng python để giải

Cách cũ (PPO, GRPO...) => Thấy "phân tích nhân tử" là cách phổ biến nhất → chỉ học và chọn cách này

FlowRL:
* Thấy cả 4 cách đều đúng → học cách phân phối giữa các cách giải
* Mỗi lần giải, có thể chọn cách khác nhau → tăng **đa dạng**, mô hình **sáng tạo và tổng quát hơn**

#### 🛠️ Các kỹ thuật chính FlowRL dùng:

1. **Learnable Partition Function**:

   * Biến các phần thưởng thành **phân phối chuẩn hóa** để mô hình học tốt hơn

2. **Reverse KL Divergence**:

   * Đo khoảng cách giữa phân phối mô hình và phân phối phần thưởng để điều chỉnh mô hình sao cho khớp hơn

3. **Length Normalization**:

   * Giải quyết vấn đề **"bùng nổ đạo hàm"** khi câu trả lời quá dài

4. **Importance Sampling**:

   * Điều chỉnh lại các mẫu dữ liệu để phù hợp với chính sách hiện tại

**FlowRL** là một phương pháp huấn luyện mô hình AI mới, giúp học tốt hơn với dữ liệu suy luận dài và đa dạng.
* Nó giải quyết 2 vấn đề lớn: **đạo hàm phát nổ** (Exploding Gradients) và **không khớp dữ liệu huấn luyện** (Sampling Mismatch), bằng cách:
* Thay đổi cách tính phần thưởng => chuẩn hóa phần thưởng theo nhóm để giúp mô hình học ổn định hơn
* Chuẩn hóa độ dài chuỗi => chia log xác suất cho độ dài chuỗi
* Dùng trọng số để học từ dữ liệu cũ ~ học từ dữ liệu cũ (off-policy) bằng cách gán trọng số cho từng sampling:
  * Trọng số này được "detach" để tránh mô hình thay đổi quá nhanh (policy drift).
  * Dùng thêm kỹ thuật "clipping" từ PPO để ổn định quá trình học

Diversity Evaluation Prompt:
```prompt
System: You are evaluating the DIVERSITY of solution approaches for a mathematics competition
problem. Focus on detecting even SUBTLE differences in methodology that indicate different problemsolving strategies.

PROBLEM:
{problem}
16 SOLUTION ATTEMPTS:
{formatted_responses}

EVALUATION CRITERIA - Rate diversity from 1 to 5:
Score 1 - Minimal Diversity:
• 14+ responses use essentially identical approaches
• Same mathematical setup, same variable choices, same solution path
• Only trivial differences (arithmetic, notation, wording)
• Indicates very low exploration/diversity in the generation process
Score 2 - Low Diversity:
• 11-13 responses use the same main approach
• 1-2 alternative approaches appear but are rare
• Minor variations within the dominant method (different substitutions, orderings)
• Some exploration but heavily biased toward one strategy
Score 3 - Moderate Diversity:
• 7-10 responses use the most common approach
• 2-3 distinct alternative approaches present
• Noticeable variation in problem setup or mathematical techniques
• Balanced mix showing reasonable explorati
Score 4 - High Diversity:
• 4-6 responses use the most common approach
• 3-4 distinct solution strategies well-represented
• Multiple mathematical techniques and problem framings
• Strong evidence of diverse exploration strategies
Score 5 - Maximum Diversity:
• No single approach dominates (≤3 responses use same method)
• 4+ distinctly different solution strategies
• Wide variety of mathematical techniques and creative approaches
• Excellent exploration and generation diversity

IMPORTANT: Focusing on the DIVERSITY of the attempted approaches. Return ONLY a number from 1
to 5.
```
























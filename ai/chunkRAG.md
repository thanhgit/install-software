# Chunk RAG
* cho phép lọc thông tin không liên quan **ở cấp độ chunk**, thay vì toàn văn bản
* => tăng độ chính xác và giảm sai sót
* Cụ thể, hệ thống này phân tích từng đoạn nhỏ trong tài liệu được truy xuất
  * sử dụng LLM để xác định mức độ liên quan của từng chunk với truy vấn người dùng
  * Những đoạn không liên quan hoặc chỉ liên quan lỏng lẻo => loại bỏ **trước khi**
* Phù hợp với các tác vụ quan trọng
  * `Têu cầu độ chính xác cao như suy luận nhiều bước (multi-hop reasoning) và kiểm tra sự thật (fact-checking)`
  * Trong domain chuyên sâu, khi chất lượng dữ liệu tốt, khi có tài nguyên tính toán dư dả
  
<img width="995" height="1128" alt="image" src="https://github.com/user-attachments/assets/32381021-d6c1-4e26-94c3-7b528acd3636" />
Phương pháp luận:
1. **Loại bỏ dư thừa bằng Cosine Similarity:**

   * so sánh và loại bỏ các đoạn trùng lặp hoặc quá giống nhau trong tài liệu được truy xuất
   * => nâng cao tính đa dạng và hiệu quả trong quá trình tạo câu trả lời

2. **Multi-Meta-RAG cho truy vấn nhiều bước:**

   * Sử dụng **metadata được trích xuất bởi LLM** để filter trước
   * => truy xuất chính xác hơn với các truy vấn phức tạp yêu cầu nhiều bước suy luận

3. **Viết lại truy vấn để cải thiện truy xuất:** (**Rewrite-Retrieve-Read** )

   * Bằng cách sử dụng học tăng cường (reinforcement learning) dựa trên phản hồi từ hiệu suất của LLM (
   * => cải thiện độ chính xác của truy xuất và giảm việc lấy thông tin không liên quan

4. **Self-RAG – Tự phản hồi để cải thiện chất lượng:**

   * Truy xuất theo yêu cầu và tự phản ánh (self-reflection)
   * Cụ thể, LLM sử dụng các “reflection tokens” để tự đánh giá và chỉnh sửa kết quả tạo ra
   * => giúp giảm thông tin dư thừa và cải thiện tính chính xác của nội dung

---
### **Semantic Chunking & Filtering Pipeline)**
* Sử NLP đến LLM => nhằm đảm bảo chỉ retrieval những đoạn thông tin **thật sự liên quan và chính xác**
* Kết hợp cả truy xuất BM25 và truy xuất ngữ nghĩa, sau đó reranking các chunk bằng LLM mạnh để chọn lọc thông tin quan trọng
* => LLM tạo câu trả lời ngắn gọn và chính xác, dựa hoàn toàn vào thông tin đã được xác minh

#### **1. Phân đoạn ngữ nghĩa (Semantic Chunking)**

Chia nhỏ tài liệu thành các đoạn có liên kết ngữ nghĩa chặt chẽ:

* **Tách câu (Sentence Tokenization):**
  Tài liệu được chia thành từng câu bằng hàm `sent_tokenize` của NLTK để xử lý chi tiết hơn

* **Tạo vector ngữ nghĩa (Sentence Embeddings):**
  Mỗi câu được mã hóa thành vector ngữ nghĩa bằng mô hình `text-embedding-3-small` của OpenAI

* **Tính độ tương đồng (Similarity Calculation):**
  * Tính cosine similarity giữa các câu liên tiếp để đánh giá mức độ liên quan
  * Nếu độ cosine similarity < (ví dụ 0.7) => chủ đề có thể đã thay đổi

* **Xác định ranh giới đoạn (Chunk Boundary Identification):**
  Dựa vào cosine similarity  thấp => hệ thống xác định ranh giới các chunk

* **Tạo các đoạn (Chunk Creation):**
  Các câu được gom nhóm thành chunk => `đảm bảo mỗi đoạn không quá dài (ví dụ 500 ký tự) để duy trì sự mạch lạc và dễ xử lý`

#### **2. Tạo Vector Store Creation**

* **Embedding Chunks:** Mỗi chunk được embedding thành vector 

* **Lưu trữ vào vector store** để thực hiện tìm kiếm theo độ tương đồng sau này

* **Khởi tạo bộ truy xuất (Retriever Initialization):** để so sánh vector truy vấn với các vector chunk => trả về những chunk phù hợp nhất

#### **3. Viết lại truy vấn** bằng LLM (LLM-Based Rewriting)
  Như GPT-4o-mini với hướng dẫn rõ ràng để giữ nguyên ý nghĩa nhưng tối ưu hóa cho việc tìm kiếm

#### **4. Lọc sơ bộ ban đầu**

Để giảm tải tính toán:

* **Loại bỏ trùng lặp (Remove Redundant Chunks):**
  Các đoạn giống nhau được loại bỏ bằng TF-IDF và cosine similarity.

* **Sắp xếp theo độ liên quan (Semantic Similarity Sorting):**
  Các đoạn còn lại được sắp xếp theo mức độ giống với truy vấn để ưu tiên xử lý.

#### **5. Đánh giá mức độ liên quan bằng LLM nâng cao (Advanced LLM-Based Relevance Scoring)**

* **Điểm số ban đầu (Initial LLM Scoring):**
  LLM gán điểm mức độ liên quan dựa trên một prompt cố định

* **Tự phản ánh (Self-Reflection):**
  LLM tự xem xét và điều chỉnh lại điểm nếu nhận thấy có sai sót

* **Đánh giá độc lập (Critic LLM Scoring):**
  Một LLM khác hoạt động như “giám khảo” đánh giá lại từng đoạn để xác minh kết quả

* **Tính điểm cuối cùng (Final Score Calculation):**
  Điểm trung bình của ba bước trên được sử dụng để tăng độ tin cậy

#### **6. Xác định ngưỡng động (Dynamic Threshold Determination)**

* **Đề xuất ngưỡng bằng LLM:**
  LLM phân tích phân phối điểm số và đề xuất ngưỡng phù hợp.

* **Áp dụng ngưỡng:**
  Các đoạn có điểm số cao hơn ngưỡng được giữ lại để dùng trong quá trình tạo câu trả lời cuối cùng.

#### **7. Hybrid Retrieval and Re-Ranking**

* **BM25 Retriever:**
  để tìm kiếm theo từ khóa với trọng số (ví dụ 0.5) nhằm tăng độ bao phủ của thông tin

* **Xếp hạng lại đoạn (Re-ranking Chunks):**
  * Dùng **‘rerank-english-v3.0’ của Cohere** để làm model reranking các chunk dựa trên mức độ liên quan
  * => giải quyết vấn đề **“Lost in the middle”** — hiện tượng các đoạn quan trọng bị lọt vào giữa và bị LLM bỏ qua

#### **8. Tạo câu trả lời (Answer Generation)**

* **Biên soạn ngữ cảnh (Context Compilation):**
  Các chunk đã được lọc và sắp xếp => context engineering 

* **Sinh câu trả lời với LLM (Answer Generation with LLM):**
  Lưu ý, prompt cần đảm bảo rằng nội dung chỉ dựa trên thông tin đã cung cấp, **không "bịa" thêm**

#### **9. Đánh giá hệ thống (Evaluation)**

* **Đo lường độ chính xác:**
  Câu trả lời do LLM sinh ra sẽ được so sánh với **đáp án chuẩn (ground truth)** xét đến **độ chính xác tuyệt đối** và **tính đúng về mặt ngữ nghĩa**

* **LLM đánh giá:**
  Có một LLM mạnh để  đánh giá riêng sẽ đối chiếu giữa câu trả lời và đáp án chuẩn => đánh dấu là **đúng hoặc sai**, phục vụ cho việc đo hiệu suất hệ thống

#### **Hạn chế của chunkRAG**
* **Phụ thuộc vào chunking và embedding:**
  * Hiệu quả của hệ thống phụ thuộc lớn vào chất lượng **phân đoạn ngữ nghĩa** và **embedding** dùng để đánh giá mức độ liên quan
  * => `Chunking sai có thể đưa thông tin không phù hợp`

* **Chi phí tính toán cao:**
  * Sử dụng **đa tầng đánh giá bằng LLM và Critic LLM** => chi phí tính toán tăng cao, đặc biệt với **tập dữ liệu lớn** hoặc real-time 

* **Tương thích với loại dữ liệu, tài liệu dài, context liên kết**
  * tài liệu dạng có cấu trúc (PDF với bảng, hình ảnh, tiêu đề…) cần xử lý đặc biệt
   
* `TreeRAG` với chunking phân cấp để bảo toàn cấu trúc hierarchies giữa các knowledge points: phù hợp hơn với tài liệu dài

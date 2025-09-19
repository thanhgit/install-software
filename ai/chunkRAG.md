# Chunk RAG and Mixture-of-Chunkers (MoC)
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

#### `TreeRAG` với chunking phân cấp để bảo toàn cấu trúc hierarchies giữa các knowledge points: phù hợp hơn với tài liệu dài

#### *KG²RAG* [link](https://github.com/nju-websoft/KG2RAG)
<img width="1497" height="1077" alt="image" src="https://github.com/user-attachments/assets/3fb03b39-6d29-43cb-b134-fcfb8cfe8551" />

* KG dùng tập hợp triplets (head entity, relation, tail entity) có liên quan đến nhau => tìm các chunks liên quan đến câu trả lời
* **kết hợp tốt giữa truy xuất ngữ nghĩa và cấu trúc logic của tri thức** => sử dụng knowledge graphs để tổ chức và mở rộng thông tin sau khi seed chunks
* Cụ thể, **liên kết giữa các (chunks)** và các **entity/triples trong KG** => hiểu được các **mối quan hệ cấp độ sự kiện (fact-level)** giữa các chunk

Quy trình tổng quan:
1. **Xác định quan hệ giữa các đoạn (chunks)** ở cấp độ sự kiện/thực thể (fact-level)
2. **Mở rộng chunk** từ các chunk truy xuất ban đầu (seed chunks) bằng cách dẫn dắt theo cấu trúc đồ thị tri thức
3. **Tổ chức lại các đoạn thông tin** theo KG => `tạo ra ngữ cảnh mạch lạc và đầy đủ hơn`

#### **Các bước chính của phương pháp:**

1. **Xử lý offline:**

   * **Phân đoạn văn bản (chunking)** từ các tài liệu cung cấp
   * **Gắn kết các chunk với KG**, từ đó thiết lập quan hệ giữa các đoạn ở cấp độ tri thức (fact-level)

2. **Truy xuất đoạn có hỗ trợ bởi KG:**

   * **Semantic-based retrieval:** Truy xuất các đoạn ban đầu (“seed chunks”) bằng embedding và rerank 
   * **Graph-guided expansion:** Từ các seed chunks => trích xuất các node liên quan trong KG => mở rộng thêm các chunk có entity hoặc triples liên quan
   * → giúp tăng tính **đa dạng và toàn diện** của thông tin được truy xuất

3. **Tổ chức ngữ cảnh bằng KG (KG-based context organization):**

   * **Lọc thông tin:** Loại bỏ các đoạn không liên quan trong đồ thị mở rộng
   * **Sắp xếp chunk:** Tổ chức các đoạn thành các **đoạn văn mạch lạc**, sử dụng cấu trúc KG làm khung sườn → `đảm bảo ngữ cảnh đầu vào cho LLM rõ ràng và hợp lý hơn`

####  KG-enhanced Chunk Retrieval
```
Target Text: <target text>
Triplets:
```
Ví dụ, Prompt for Triplet Extraction
```prompt
Instruction:
Extract informative triplets directly from the text following the examples.
Do not add any extra words, line breaks, or spaces.

Example 1:
Text: Scott Derrickson (born July 16, 1966) is an American director, screenwriter and producer.
Triplets:
<Scott Derrickson, born in, 1966>,
<Scott Derrickson, nationality, America>,
<Scott Derrickson, occupation, director>,
<Scott Derrickson, occupation, screenwriter>,
<Scott Derrickson, occupation, producer>

Example 2:
Text: A Kiss for Corliss is a 1949 American comedy film
directed by Richard Wallace and written by Howard Dimsdale.
Triplets:
<A Kiss for Corliss, year, 1949>,
<A Kiss for Corliss, country, America>,
<A Kiss for Corliss, genre, comedy film>,
<A Kiss for Corliss, director, Richard Wallace>,
<A Kiss for Corliss, writer, Howard Dimsdale>
```

---
### Mixture-of-Chunkers (MoC) [link](https://arxiv.org/pdf/2503.09600)
* Đánh giá chất lượng chunking mới gồm hai chỉ số:
  * **Boundary Clarity** (độ rõ ràng biên đoạn)
  * **Chunk Stickiness** (độ gắn kết của đoạn).
  * => nhấn mạnh sự cần thiết phải tích hợp các mô hình ngôn ngữ lớn (LLMs) vào quá trình chunking
* Đánh đổi giữa hiệu quả tính toán và độ chính xác chunking khi dùng LLM
 
#### **MoC**
* Là một framework nhận biết độ chi tiết (granularity-aware) với ba giai đoạn xử lý
* MoC hướng đến việc tạo ra một danh sách các biểu thức chính quy để trích xuất các đoạn văn bản một cách cấu trúc từ văn bản gốc
* Dùng 2 chỉ số: **Boundary Clarity** và **Chunk Stickiness** để phân tích nguyên nhân điều gì `khiến chunking dựa trên ngữ nghĩa hoạt động chưa tốt trong một số trường hợp` =>  `cần thiết phải sử dụng LLM trong quá trình chunking`

Định tuyến nhận biết đa cấp độ chi tiết (multi-granularity-aware router), các meta-chunker chuyên biệt, và thuật toán hậu xử lý
* Cụ thể, cơ chế này áp dụng chiến lược chia để trị, phân chia không gian độ chi tiết liên tục thành nhiều miền con liền kề, mỗi miền tương ứng với một chunker nhẹ và chuyên biệt
* => Bộ định tuyến sẽ chọn động chunker phù hợp nhất dựa trên đoạn văn bản đầu vào hiện tạiDu

Dùng SLM nhờ kích hoạt thưa thớt (sparse activation)
* đạt được sự cân bằng tối ưu giữa độ chính xác và hiệu quả cho hệ thống chunking.
* Chú ý: meta-chunker tạo ra toàn bộ từng đoạn văn mà hướng dẫn nó tạo ra một danh sách các biểu thức chính quy dùng để trích xuất các đoạn văn bản từ văn bản gốc
* áp dụng thuật toán hiệu chỉnh dựa trên khoảng cách chỉnh sửa (edit distance) để so sánh và sửa lỗi các quy tắc chunking được tạo ra với văn bản gốc => giảm hallucination từ meta-chunker





































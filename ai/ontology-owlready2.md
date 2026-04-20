# Dùng ontology trong owlready2

* HermiT (The Debugger):
    > Dùng trong giai đoạn Expert thiết kế ontology
    > * HermiT giúp kiểm tra xem các class có bị mâu thuẫn logic không
    > * Nó rất kỹ lưỡng nhưng chậm => nên chỉ phù hợp để "test" cấu trúc

* Pellet (The Logic Engine):
    > Dùng trong giai đoạn làm giàu dữ liệu (Data Enrichment)
    > * Nhờ hỗ trợ SWRL Rules => suy luận ra các mối quan hệ ẩn
    > * Ví dụ: Người dùng A thích Thể loại B dựa trên hành vi C
    > *  Trong RAG, nó giúp LLM có thêm các kết nối thông minh mà dữ liệu thô không có
    
* FaCT++ (The Indexer):
    > Dùng trong giai đoạn triển khai quy mô lớn (Production/Indexing)
    > * Khi bạn có hàng triệu entity cần phân loại vào cây thư mục (Taxonomy) để lưu vào VectorDB hoặc graphDB
    > * Tốc độ của FaCT++ (C++) là lợi thế tuyệt đối để kịp tiến độ indexing

### Chiến lược kết hợp cho RAG:
1. Thiết kế:
    > Dùng Protégé + HermiT để vẽ và check lỗi logic của Ontology
3. Lập trình:
   > Dùng Owlready2/EMMOntoPy để load ontology đó vào Python
5. Indexing:
   > Chạy FaCT++ để phân loại nhanh các thực thể vào Class.
7. Enrichment:
   > Chạy Pellet để kích hoạt các Rules (Luật) tạo ra các Triple mới
9. Retrieval:
   > LLM truy vấn vào kho dữ liệu đã được "tối ưu hóa" bởi các bước trên

#### Dùng Pellet reasoning
* Dùng đúng java version
* Using
    ```python
    from owlready2 import *
    onto = get_ontology("http://test.org")
    
    with onto:
        sync_reasoner_pellet(infer_property_values = True, infer_data_property_values = True)
    ```

### Dùng FaCT++ reasoning
* https://github.com/tilde-lab/pyfactxx
    ```bash
    pip install pyfactxx
    ````
* Using
    ```python
    from pyfactxx import coras
    
    crs = coras.Coras()
    crs.load(ontology_file, format='turtle')
    
    crs.parse()
    crs.realise()
    
    result = crs.query('SELECT ?a ?b ?c WHERE {?a ?b ?c}')
    ```
    
    





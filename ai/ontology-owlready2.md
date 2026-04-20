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

#### Jena Fuseki onto server
* https://github.com/apache/jena
<img width="577" height="349" alt="image" src="https://github.com/user-attachments/assets/b5c25a53-d0b5-44b2-949f-e37156630664" />


#### Dùng konclude resoner
* https://github.com/konclude/Konclude

#### Dùng HermiT (buit-in in owlready2)
* HermiT sẽ kiểm tra mâu thuẫn
    ```python
    try:
        with onto:
            sync_reasoner(infer_property_values=True)
        print("Ontology nhất quán!")
    except OwlReadyInconsistentOntologyError:
        print("Lỗi: Ontology mất tính nhất quán!")
    
    ```
* `infer_property_values=True` giúp:
    * Tự động điền thuộc tính:
         > Nếu bạn có luật "Người sống ở Hà Nội thì có quốc tịch Việt Nam", Reasoner sẽ tự thêm thuộc tính hasNationality = Vietnam cho các cá thể đó
    * Cảnh báo:
         > Việc này tiêu tốn rất nhiều tài nguyên (RAM/CPU) nếu Ontology của bạn có hàng ngàn cá thể
         >
* Sau khi chạy `sync_reasoner`
    > Kết quả suy luận được lưu vào một "Inference graph" (đồ thị suy luận)
    
    > Truy cập `.is_a` để xem class mới được suy luận hoặc kiểm tra các thuộc tính mà không gán thủ công



#### Dùng Pellet reasoning
* Cấu hình jenv
    ```bash
    echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(jenv init -)"' >> ~/.bashrc
    source ~/.bashrc
    ```
* List jvm
    ```bash
    update-java-alternatives --list
    ```
* Add jvm
    ```bash
    jenv add /usr/lib/jvm/java-1.11.0-openjdk-amd64
    ```
* Dùng đúng java version bởi jenv
    ```bash
    jenv local 25.0.2
    ```
* Using
    ```python
    from owlready2 import *
    onto = get_ontology("http://test.org")
    
    with onto:
        sync_reasoner_pellet(infer_property_values = True, infer_data_property_values = True)
    ```

#### Dùng FaCT++ reasoning
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

#### Dùng toolkit
* https://emmo-repo.github.io/EMMOntoPy/stable/
```
pip install EMMOntoPy
```    





# LLM tricks

### ReAct pattern
- #### Đây là sự kết hợp tinh tế giữa 2 yếu tố: `Reasoning` (Khả năng suy luận của các mô hình LLM) và `Action` (Thực hiện các hành động tương tác với môi trường bên ngoài nhằm hoàn thành một tác vụ cụ thể) => ` kết hợp hài hoà giữa việc suy nghĩ và hành động`
- #### `Lợi ích`: giải quyết chính xác hơn và khả năng tự sửa chữa những lỗi sai từ các hành động trước đó.

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

### Bài toán tích hợp AI agent vào CI/CD để tối ưu stored procedures (SP)
![image](https://github.com/user-attachments/assets/ddfb1d3c-62a9-4498-8b4a-402780912c93)

#### Nếu có một SP mới => trigger một MRs => chạy performance testing trong CI/CD
- #### Nếu tests fails => DBA phải phân tích thử công, xác định bottlenecks, đề xuất cải thiện
- #### Nếu test success => có thể merge 

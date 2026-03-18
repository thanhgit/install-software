# Tools for AI agent

#### MCP gateway
```bash
docker run -d --name mcpgateway \
  -p 4444:4444 \
  -e HOST=0.0.0.0 \
  -e MCPGATEWAY_UI_AIRGAPPED=true \
  -e MCPGATEWAY_UI_ENABLED=true \
  -e MCPGATEWAY_ADMIN_API_ENABLED=true \
  -e PLUGINS_ENABLED=true \
  -e JWT_SECRET_KEY=my-password-test-key \
  -e JWT_AUDIENCE=mcpgateway-api \
  -e JWT_ISSUER=mcpgateway \
  -e AUTH_REQUIRED=true \
  -e PLATFORM_ADMIN_EMAIL=admin@util4dev.tech \
  -e PLATFORM_ADMIN_PASSWORD=admin \
  -e PLATFORM_ADMIN_FULL_NAME="Platform Administrator" \
  -e DATABASE_URL=sqlite:///./mcp.db \
  ghcr.io/ibm/mcp-context-forge:1.0.0-BETA-1
```

## Design AI agent
#### User cần “cảm giác đáng tin + có kiểm soát”
* Start WF
```text
A => B => C
Quy trình này thường mất khoảng 10 phút nếu làm thủ công.
Tôi sẽ xử lý tự động cho bạn — thường chỉ mất vài phút.
Bạn có thể làm việc khác, tôi sẽ báo ngay khi hoàn tất.
```
* In progress WF
```
“Đang thu thập dữ liệu…”
“Đang xử lý…”
“Gần xong…”
```

#### 1️⃣ Weighted Sum Model (WSM)
* Tính tổng có trọng số của tất cả tiêu chí

* ✅ Khi nào dùng:
  * Khi mọi tiêu chí đều có cùng đơn vị hoặc đã chuẩn hóa.
  * Khi ưu tiên đơn giản, trực tiếp: “giá trị càng cao càng tốt” hoặc “càng thấp càng tốt” đã được chuyển đổi.
  * Dữ liệu dạng số (quantitative).

* ✅ Ưu điểm
  * Rất đơn giản, nhanh chóng.
  * Dễ giải thích cho người dùng.

* ❌ Hạn chế
  * Không xử lý tốt tiêu chí với đơn vị khác nhau nếu chưa chuẩn hóa.
  * Không cân nhắc khoảng cách giữa lựa chọn và ideal.

#### 2️⃣ TOPSIS (Technique for Order Preference by Similarity to Ideal Solution)
* Tính khoảng cách từ mỗi lựa chọn tới giải pháp lý tưởng (max score) và giải pháp xấu nhất (min score).
* => Chọn lựa chọn **gần giải pháp lý tưởng nhất** và **xa giải pháp xấu nhất nhất**
  
* ✅ Khi nào dùng
  * Khi bạn có nhiều tiêu chí, có cả maximize và minimize.
  * Khi cần so sánh tương đối các lựa chọn với “ideal solution”.
  * Dữ liệu dạng số, chuẩn hóa là bắt buộc.

* ✅ Ưu điểm
  * Xử lý tiêu chí khác đơn vị tốt (bằng chuẩn hóa).
  * Xem xét tổng thể so với ideal và anti-ideal → phù hợp với decision phức tạp.

#### 3️⃣ MOORA (Multi-Objective Optimization on the basis of Ratio Analysis)
* Chuẩn hóa dữ liệu bằng ratio method: chia giá trị mỗi lựa chọn cho căn bậc hai tổng bình phương của tiêu chí.
* Phép cộng trừ giữa các tiêu chí maximize và minimize để tính điểm cuối cùng.

* ✅ Khi nào dùng
  * Khi cần cân bằng các tiêu chí tối đa hóa và tối thiểu hóa.
  * Khi dữ liệu khác đơn vị, không muốn chỉ dùng Weighted Sum đơn giản.
  * Phù hợp với decision nhanh, trực quan nhưng vẫn tính đến nhiều tiêu chí.

* ✅ Ưu điểm
  * Chuẩn hóa tự động → dễ dùng khi tiêu chí khác đơn vị.
  * Giống WSM nhưng mạnh hơn cho trường hợp có cả maximize và minimize.

| Phương pháp  | Loại decision phù hợp                                                  | Ưu điểm                               | Nhược điểm                                                       |
| ------------ | ---------------------------------------------------------------------- | ------------------------------------- | ---------------------------------------------------------------- |
| Weighted Sum | Lựa chọn đơn giản, ít tiêu chí, cùng đơn vị                            | Đơn giản, dễ giải thích               | Không xử lý tốt đơn vị khác nhau, khoảng cách relative           |
| TOPSIS       | Lựa chọn nhiều tiêu chí, có maximize & minimize, cần so sánh với ideal | Tính tương đối tốt, xử lý đa tiêu chí | Cần chuẩn hóa, phức tạp hơn                                      |
| MOORA        | Nhiều tiêu chí khác đơn vị, mix maximize & minimize                    | Chuẩn hóa tự động, cân bằng           | Ít trực quan hơn Weighted Sum, vẫn cần hiểu cách ratio hoạt động |


















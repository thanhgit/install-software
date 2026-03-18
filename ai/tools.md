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
























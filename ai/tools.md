# Tools for AI agent

#### Lib
* https://github.com/scikit-fuzzy/scikit-fuzzy for fuzzy logic để mô phỏng các biến ngôn ngữ

* For Hedge Algebra
```python
import numpy as np

class HedgeAlgebra4Tuple:
    def __init__(self, a, b, alpha, beta):
        self.val = np.array([a, b, alpha, beta])
    
    def defuzzify(self):
        # Hàm giải mờ đơn giản (ví dụ: lấy trung tâm diện tích)
        a, b, alpha, beta = self.val
        return (a + b) / 2 + (beta - alpha) / 4
```

* Optuna:
    * Tối ưu hóa tham số (Hyperparameter Tuning) bởi tìm bộ tham số 4-tuple tối ưu sao cho kết quả ra quyết định của AHP khớp với thực tế nhất
    * => tìm Vùng an toàn (Range) cho contextual bandit và Trọng số khởi tạo cho AHP

* Build persona
```python
import pandas as pd
import numpy as np
import xgboost as xgb
from pyahp import parse

# 1. BƯỚC AHP: Định nghĩa ma trận so sánh cặp (từ chuyên gia/kinh doanh)
# Giả sử tiêu chí cho Persona "Sinh viên": Giá (quan trọng hơn) > Cấu hình > Thiết kế
ahp_model = {
    "name": "Student Priority",
    "method": "approximate",
    "criteria": ["Price", "Performance", "Design"],
    "comparisons": [
        [1, 5, 9],    # Price vs [Price, Perf, Design]
        [0.2, 1, 3],  # Perf vs [Price, Perf, Design]
        [0.11, 0.33, 1] # Design vs [Price, Perf, Design]
    ]
}

# Giả định trọng số thu được từ AHP (thực tế dùng thư viện pyahp để giải)
# weights = [0.7, 0.2, 0.1] 
weights = np.array([0.7, 0.2, 0.1]) 

# 2. CHUẨN BỊ DATASET (Sản phẩm thô + Điểm AHP)
data = pd.DataFrame({
    'user_id': [101, 101, 102, 102],
    'price_score': [0.9, 0.4, 0.8, 0.3], # Đã chuẩn hóa 0-1
    'perf_score': [0.3, 0.8, 0.4, 0.9],
    'design_score': [0.5, 0.9, 0.4, 0.7],
    'historical_ctr': [0.05, 0.12, 0.02, 0.08] # Dữ liệu hành vi thực tế
})

# Tính toán "AHP_Preference_Score" - Đây là Feature Engineering thủ công
data['ahp_score'] = (
    data['price_score'] * weights[0] + 
    data['perf_score'] * weights[1] + 
    data['design_score'] * weights[2]
)

# 3. TRAIN XGBOOST
# Input bao gồm cả dữ liệu thô (Raw) và dữ liệu chuyên gia (AHP)
X = data[['price_score', 'perf_score', 'design_score', 'ahp_score', 'historical_ctr']]
y = [0, 1, 0, 1] # Nhãn: Mua hay không mua

model = xgb.XGBClassifier(objective='binary:logistic')
model.fit(X, y)

# Kiểm tra độ quan trọng của đặc trưng
print(model.get_booster().get_score(importance_type='weight'))
```

* Using contextual bandit to Ràng buộc (Constraint) trong biên độ bạn cho phép, ví dụ 0.2)
```python
# Trọng số cứng từ AHP cho Persona "Eco-Friendly"
ahp_weights = {'green_material': 0.6, 'price': 0.3, 'delivery_speed': 0.1}

# Biên độ thay đổi tối đa (Guardrail) là 20%
epsilon = 0.2 

def get_constrained_weights(bandit_delta):
    final_weights = {}
    for criteria, base_w in ahp_weights.items():
        # Lấy delta từ thuật toán Bandit (ví dụ Thompson Sampling)
        delta = bandit_delta.get(criteria, 0)
        
        # Áp dụng ràng buộc: Không được vượt quá biên độ cho phép
        clamped_delta = max(min(delta, epsilon), -epsilon)
        
        final_weights[criteria] = base_w + clamped_delta
    return final_weights

# Giả sử hôm nay trời mưa, khách cần giao nhanh (delivery_speed)
# Bandit học được xu hướng này và gửi delta_delivery = +0.5
# Hệ thống sẽ "nắn" lại thành +0.2 để không làm mất đặc trưng "Eco-Friendly" (0.6) của Persona này.
```

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


















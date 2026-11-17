# Utitity scripts

#### For python3
```python
def calculate_average(numbers):
    if not numbers:  # Nếu danh sách rỗng
        return 0.0
    return sum(numbers) / len(numbers)

print("Đang tính toán...")
empty_list = []
result = calculate_average(empty_list)
print("Kết quả:", result)  # In ra: Kết quả: 0.0
```

#### For golang
```go
package main

import (
	"encoding/json"
	"fmt"
	"time"
)

type ServerStatus struct {
	Name      string `json:"name"`
	Active    bool   `json:"active"`
	CheckedAt string `json:"checked_at"`
}

func checkServer(name string) string {
	status := ServerStatus{
		Name:      name,
		Active:    true,
		CheckedAt: time.Now().Format("15:04:05"),
	}
	data, _ := json.MarshalIndent(status, "", "  ")
	return string(data)
}

func main() {
	fmt.Println("Đang kiểm tra kết nối hệ thống...")
	result := checkServer("Jupyter-Go-Node-01")
	fmt.Println(result)
}
```

#### For typescript
```typescript
// 1. Kiểm tra hỗ trợ TypeScript Interface & Top-level await
interface MetricResult {
  service: string;
  latencyMs: number;
  status: "OK" | "SLOW";
}

const sleep = (ms: number) => new Promise((resolve) => setTimeout(resolve, ms));

// 2. Hàm tiện ích mô phỏng đo độ trễ và xử lý dữ liệu
async function benchmarkServices(services: string[]): Promise<MetricResult[]> {
  const results: MetricResult[] = [];
  for (const service of services) {
    const start = performance.now();
    await sleep(Math.floor(Math.random() * 150) + 50);
    const latency = Math.round(performance.now() - start);
    results.push({
      service,
      latencyMs: latency,
      status: latency < 130 ? "OK" : "SLOW",
    });
  }
  return results;
}

// 3. Thực thi bất đồng bộ ở cấp cao nhất (không cần bọc trong hàm async)
console.log("Đang kiểm tra phản hồi các dịch vụ trên cdp-node...");
const data = await benchmarkServices(["Auth-API", "Payment-Gateway", "Search-Engine"]);

// 4. Kiểm tra API hiển thị đặc trưng của cdp-kernel (jupyter.md / jupyter.html)
const tableRows = data
  .map((item) => `| ${item.service} | ${item.latencyMs} ms | **${item.status}** |`)
  .join("\n");

jupyter.md`
# Báo cáo kiểm tra Kernel \`cdp-node\`

| Dịch vụ | Độ trễ | Trạng thái |
| :--- | :---: | :---: |
${tableRows}
`;
```

#### For rust
```rust
// Định nghĩa một struct đơn giản
#[derive(Debug)]
struct Task {
    id: u32,
    title: String,
    done: bool,
}

// Hàm tiện ích lọc các công việc chưa hoàn thành
fn get_pending_tasks(tasks: &[Task]) -> Vec<&Task> {
    tasks.iter().filter(|t| !t.done).collect()
}

// Khởi tạo dữ liệu và chạy thử nghiệm
let tasks = vec![
    Task { id: 1, title: String::from("Cài đặt Rust Kernel"), done: true },
    Task { id: 2, title: String::from("Chạy thử script"), done: false },
    Task { id: 3, title: String::from("Tối ưu hóa hiệu năng"), done: false },
];

let pending = get_pending_tasks(&tasks);
println!("Số việc chưa làm: {}", pending.len());
for task in pending {
    println!("- [{}] {}", task.id, task.title);
}
```

#### Generate QR code
```rust
// In a Jupyter notebook cell:
:dep qrcode-generator-evcxr
use qrcode_generator_evcxr::draw_qrcode;

draw_qrcode("https://example.com");
```

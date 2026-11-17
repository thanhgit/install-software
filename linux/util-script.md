# Utitity scripts

#### For python3
```python
%%time
import asyncio
import random
import statistics
from dataclasses import dataclass
from typing import List
from IPython.display import display, Markdown

# 1. Kiểm tra Dataclass & Type Hinting (Python 3.7+)
@dataclass
class TaskMetric:
    name: str
    duration_ms: float
    status: str

# 2. Kiểm tra lập trình bất đồng bộ (Async/Await)
async def simulate_worker(name: str) -> TaskMetric:
    delay = random.uniform(0.05, 0.25)
    await asyncio.sleep(delay)
    ms = round(delay * 1000, 2)
    return TaskMetric(
        name=name,
        duration_ms=ms,
        status="OK" if ms < 180 else "SLOW"
    )

async def run_benchmark(tasks: List[str]) -> List[TaskMetric]:
    coroutines = [simulate_worker(t) for t in tasks]
    return await asyncio.gather(*coroutines)

# 3. Thực thi trực tiếp với Top-level await (Tính năng đặc trưng của IPython)
print("Đang chạy kiểm tra bất đồng bộ trên Python Kernel...")
results = await run_benchmark(["Data-Ingestion", "Model-Inference", "Cache-Sync", "DB-Backup"])

# 4. Tính toán thống kê & hiển thị Rich Output (Markdown)
durations = [r.duration_ms for r in results]
avg_time = round(statistics.mean(durations), 2)

rows = "\n".join(
    f"| `{r.name}` | {r.duration_ms} ms | **{r.status}** |"
    for r in results
)

report = f"""
# Kết quả kiểm tra Python 3
* **Thời gian phản hồi trung bình:** `{avg_time} ms`

| Tác vụ | Thời gian xử lý | Trạng thái |
| :--- | :---: | :---: |
{rows}
"""

display(Markdown(report))
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

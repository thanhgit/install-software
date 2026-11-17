# Utitity scripts

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

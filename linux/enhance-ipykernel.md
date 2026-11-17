# Enhance Jupiter notebook

#### Đăng kí kernel in docker
* Dockerfile
  ```dockerfile
  FROM python:3.12-slim
  
  # Prevent Python from writing .pyc files and buffering stdout/stderr
  ENV PYTHONDONTWRITEBYTECODE=1 \
      PYTHONUNBUFFERED=1
  
  # Install only ipykernel (and any specific libraries your code needs)
  RUN pip install --no-cache-dir ipykernel
  
  # Default command to launch the kernel when a connection file is mounted
  ENTRYPOINT ["python", "-m", "ipykernel_launcher"]
  ```
* Build image
  ```bash
  docker build -t my-jupyter-image .
  ```
* docker_kernel_wrapper.py
  ```python
  import json
  import os
  import subprocess
  import sys
  
  def main():
      image_name = sys.argv[1]
      conn_file = sys.argv[2]
  
      parent_pid = os.getpid()
      container_name = f"jupyter-kernel-{parent_pid}"
  
      with open(conn_file, "r") as f:
          conn_data = json.load(f)
  
      conn_data["ip"] = "0.0.0.0"
      with open(conn_file, "w") as f:
          json.dump(conn_data, f)
  
      port_keys = ["shell_port", "iopub_port", "stdin_port", "control_port", "hb_port"]
      port_args = []
      for key in port_keys:
          port = conn_data[key]
          port_args.extend(["-p", f"{port}:{port}"])
  
      # Tạo tiến trình giám sát độc lập để dọn dẹp container khi tiến trình chính bị ngắt
      watchdog_code = f"""
  import time, subprocess, os
  pid = {parent_pid}
  while True:
      try:
          os.kill(pid, 0)
      except OSError:
          break
      time.sleep(1)
  subprocess.run(["docker", "rm", "-f", "{container_name}"], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
  """
      popen_kwargs = {}
      if os.name == "nt":
          popen_kwargs["creationflags"] = subprocess.DETACHED_PROCESS | subprocess.CREATE_NEW_PROCESS_GROUP
      else:
          popen_kwargs["start_new_session"] = True
  
      subprocess.Popen([sys.executable, "-c", watchdog_code], **popen_kwargs)
  
      # Khởi chạy Docker container
      cmd = [
          "docker", "run", "--rm",
          "--name", container_name,
          *port_args,
          "-v", f"{conn_file}:/connection-spec.json",
          image_name,
          "python", "-m", "ipykernel_launcher", "-f", "/connection-spec.json"
      ]
  
      subprocess.run(cmd)
  
  if __name__ == "__main__":
      main()

  ```
* Đăng ký tại: ` ~/.local/share/jupyter/kernels/docker-python/kernel.json`
  ```json
  {
    "argv": [
      "python",
      "/home/thanhnp/.local/share/jupyter/kernels/py-docker/docker_kernel_wrapper.py",
      "lightweight-ipykernel:latest",
      "{connection_file}"
    ],
    "display_name": "Python 3.12 (Docker)",
    "language": "python"
  }
  ```

#### Đăng ký bash kernel
```
pip install bash_kernel
python -m bash_kernel.install
```

#### Đăng ký golang kernel
```
go install github.com/janpfeifer/gonb@latest && \
  go install golang.org/x/tools/cmd/goimports@latest && \
  go install golang.org/x/tools/gopls@latest
```
```
gonb --install
```

#### Đăng ký C++ kernel
* https://github.com/jupyter-xeus/xeus-cling
  
#### Đăng ký SQL kernel
* https://github.com/jupyter-xeus/xeus-sql
  
#### Đăng ký rust kernel
```bash
# Rust toolchain
rustup component add rust-src

# Cài Evcxr
cargo install --locked evcxr_jupyter

# Đăng ký Rust kernel
evcxr_jupyter --install
```

```
{
  "kernelspec": {
    "display_name": "Rust",
    "language": "rust",
    "name": "rust"
  }
}
```

#### Đăng ký node kernel
```bash
npm install -g @tlockney/cdp-kernel
```
```bash
cdp-kernel install --runtime node
cdp-kernel install --runtime deno
cdp-kernel install --runtime node --deno-compat
cdp-kernel install --runtime bun
cdp-kernel install --runtime workerd
cdp-kernel install --runtime celld
```

#### Tắt Jedi để gợi ý code (Autocomplete) phản hồi tức thì
* Thiết lập profile tại `~/.ipython/profile_default/ipython_config.py`
```
%config IPCompleter.use_jedi = False
```

#### Tắt lịch sử lưu trữ (HistoryManager) trong file ipython_config.py
```python
thêm c.HistoryManager.enabled = False
```

#### Dùng thư viện / trình biên dịch
* Dùng Polars hoặc DuckDB thay Pandas
* Biên dịch hàm nặng bằng Numba hoặc Cython
* Thêm decorator `@numba.njit` trước các hàm chứa vòng lặp tính toán số học để biên dịch trực tiếp sang mã máy thay vì chạy qua trình thông dịch Python chậm chạp

#### Thay ipykernel bằng xeus-python (Nhân viết bằng C++)
* Bản tiêu chuẩn `xpython` ~ (Nhân C++ có hỗ trợ lệnh magic của IPython)
* Bản siêu nhẹ `xpython-raw` ~ (Nhân C++ thuần túy, bỏ qua IPython, nhẹ và khởi động nhanh nhất)
* Nếu chọn nhân XPython Raw (bỏ qua lớp IPython), tốc độ khởi động, gợi ý code và thực thi cell tăng thêm khoảng 15%,
* Tuy nhiên bạn sẽ mất các lệnh magic như %timeit hay %%bash
  ```bash
  pip install xeus-python
  ```

* Cài đặt gói hỗ trợ kernel
  ```bash
  pip install jupyter_client
  ```

* Kiểm tra nhân
  ```bash
  jupyter kernelspec list
  ```

* Set `xpython-raw`
  ```
  # ---
  # jupyter:
  #   kernelspec:
  #     display_name: XPython Raw
  #     language: python
  #     name: xpython-raw
  # ---
  ```
* Config jupyter
  ```
  # ---
  # jupyter:
  #   jupytext:
  #     text_representation:
  #       extension: .py
  #       format_name: percent
  #       format_version: '1.3'
  #       jupytext_version: 1.19.6
  #   kernelspec:
  #     display_name: Python 3
  #     language: python
  #     name: python3
  # ---
  ```
#### Gom nhóm lệnh print()
* In ra output một lần ở cuối
```python
print("\n".join(logs))
```

#### Dùng E2B API
```bash
pip install e2b-code-interpreter
```
```python
import os
from e2b_code_interpreter import Sandbox

os.environ["E2B_API_KEY"] = "e2b_..." # Điền API key của bạn

# Tạo sandbox mới (hoặc dùng Sandbox.connect("sandbox_id") để nối vào sandbox đang có)
sbx = Sandbox.create() 
print("Sandbox ID dùng chung:", sbx.sandbox_id)

# Chạy code trên E2B và nhận kết quả (text, biểu đồ, dataframe...) về Jupyter local
execution = sbx.run_code("x = 10 + 25; x")
print(execution.text)  # Kết quả: 35
```

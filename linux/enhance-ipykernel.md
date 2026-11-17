# Enhance Jupiter notebook

#### Đăng ký bash kernel
```
pip install bash_kernel
python -m bash_kernel.install
```

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

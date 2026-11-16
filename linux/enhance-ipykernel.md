# Enhance Jupiter notebook

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

#### Gom nhóm lệnh print()
* In ra output một lần ở cuối
```python
print("\n".join(logs))
```

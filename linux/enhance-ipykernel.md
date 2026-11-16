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

#### Thay ipykernel bằng xeus-python (Nhân viết bằng C++)
* Nếu chọn nhân XPython Raw (bỏ qua lớp IPython), tốc độ khởi động, gợi ý code và thực thi cell tăng thêm khoảng 15%,
* Tuy nhiên bạn sẽ mất các lệnh magic như %timeit hay %%bash
  ```bash
  pip install xeus-python
  ```

#### Gom nhóm lệnh print()
* In ra output một lần ở cuối
```python
print("\n".join(logs))
```

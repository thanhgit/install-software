# Enhance Jupiter notebook

#### Tắt Jedi để gợi ý code (Autocomplete) phản hồi tức thì
* Thiết lập profile tại `~/.ipython/profile_default/ipython_config.py`
```
%config IPCompleter.use_jedi = False
```

#### . Thay ipykernel bằng xeus-python (Nhân viết bằng C++)
```bash
pip install xeus-python
```

# Dùng ONNX format

#### Dùng `optimum-cli` để convert đến ONNX
* Install
```bash
python -m pip install optimum
```
* How to use
```bash
optimum-cli export onnx --task text2text-generation --model . onnx
```

#### Tối ưu sâu hơn với `torch.onnx.export`
```python
import torch
from transformers import GPT2Model

model = GPT2Model.from_pretrained("gpt2")
model.eval()

dummy_input = torch.randint(0, 50257, (1, 10))  # ví dụ input_ids
torch.onnx.export(
    model, 
    dummy_input, 
    "gpt2.onnx", 
    opset_version=17,
    input_names=["input_ids"],
    output_names=["output"]
)
```

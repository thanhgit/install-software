# Dùng ONNX format

#### Dùng transformers-cli để convert đến ONNX
```bash
transformers-cli convert --model_name gpt2 --framework pt --opset 17 onnx/gpt2.onnx
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

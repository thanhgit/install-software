# Dùng ONNX format

#### Dùng `optimum-cli` để convert đến ONNX (khuyên dùng)
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
from transformers import AutoModelForCausalLM, AutoTokenizer

# Load model và tokenizer
model_name = "./"
model = AutoModelForCausalLM.from_pretrained(model_name)
model.eval()
tokenizer = AutoTokenizer.from_pretrained(model_name, local_files_only=True)

# Tạo dummy input_ids (ví dụ 10 token)
dummy_text = "Xin chào"  # văn bản ví dụ
dummy_input = tokenizer(dummy_text, return_tensors="pt")

# Export sang ONNX
class ONNXWrapper(torch.nn.Module):
    def __init__(self, model):
        super().__init__()
        self.model = model

    def forward(self, input_ids):
        return self.model(input_ids).logits  # chỉ trả tensor

wrapped_model = ONNXWrapper(model)
torch.onnx.export(
    wrapped_model,
    (dummy_input["input_ids"],),
    "vietnamese_error_correction.onnx",
    opset_version=18,
    input_names=["input_ids"],
    output_names=["logits"],
    dynamic_axes={
        "input_ids": {0: "batch_size", 1: "sequence_length"},
        "logits": {0: "batch_size", 1: "sequence_length"}
    }
)

```

### Dùng `ONNX-Sim` để tối ưu thêm
* File ONNX nhỏ hơn, chạy nhanh hơn, output không đổi về mặt giá trị
* Install
```bash
pip install onnx-simplifier
```
* How to use
```python
import onnx
from onnxsim import simplify

# Load file ONNX đã export
model_path = "vietnamese_error_correction.onnx"
onnx_model = onnx.load(model_path)

# Simplify model
model_simplified, check = simplify(onnx_model)
assert check, "Simplified ONNX model failed validation"

# Lưu file đã tối ưu
onnx.save(model_simplified, "vietnamese_error_correction_simplified.onnx")
print("ONNX model đã được simplify thành công!")
```

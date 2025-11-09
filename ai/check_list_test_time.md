# Check list trong test-time

#### Verify if the NVIDIA GPU you are using supports
```python
import torch
torch.cuda.is_bf16_supported()
```

#### Convert scikit-learn model to ONNX format
* https://github.com/onnx/sklearn-onnx
```bash
pip install skl2onnx
```

#### ONNX provides several ORTModelForXxx classes
* Each one specialized in a downstream task
* FX: ORTModelForSequenceClassification for Sequence Classification tasks
```python
from optimum.onnxruntime import ORTModelForSequenceClassification

model_id = 'bert-base-uncased'
model = ORTModelForSequenceClassification.from_pretrained(model_id, from_transformers=True)
```
* ONNX Runtime quantization API to dynamically quantize our converted model
```python
from onnxruntime.quantization import quantize_dynamic, QuantType

onnx_path = 'bert_uncased_model.onnx'
onnx_quantized_path = 'bert_uncased_quantized_model.onnx'
quantized_model = quantize_dynamic(onnx_path, onnx_quantized_path, weight_type=QuantType.QInt8)
```
* Download the fine-tuned model in fp32 precision cho ONNX format
```python
from optimum.onnxruntime import ORTModelForSequenceClassification
from transformers import AutoTokenizer
from pathlib import Path

model_id="optimum/distilbert-base-uncased-finetuned-banking77"
model = ORTModelForSequenceClassification.from_pretrained(model_id, export=True)
tokenizer = AutoTokenizer.from_pretrained(model_id)

onnx_path = Path("onnx")
model.save_pretrained(onnx_path)
tokenizer.save_pretrained(onnx_path)
```
* Use ONNX in Transformer pipeline
```python
from transformers import pipeline

vanilla_clf = pipeline("text-classification", model=model, tokenizer=tokenizer)
vanilla_clf("Could you assist me in checking my card validity?")
```
* To quantize the model in 8-bit precision
```python
from optimum.onnxruntime import ORTQuantizer
from optimum.onnxruntime.configuration import AutoQuantizationConfig

dynamic_quantizer = ORTQuantizer.from_pretrained(model)
dqconfig = AutoQuantizationConfig.avx512_vnni(is_static=False, per_channel=False)
model_quantized_path = dynamic_quantizer.quantize(save_dir=onnx_path, quantization_config=dqconfig)
```

#### **Tối ưu hiệu năng mô hình ONNX** 
* Sử dụng **profiling runtime** để đo lường hiệu suất như latency, throughput, và memory usage
* => có thể cần điều chỉnh cấu hình runtime hoặc áp dụng các kỹ thuật tối ưu hóa cho từng mô hình, từng thiết bị.

**ONNX Runtime Profiling**:
 * Cho phép bật profiling trong phiên inference (`sess_options.enable_profiling = True`).
 * Khi chạy inference, một file JSON được tạo ra, chứa dữ liệu về threading, latency của từng operator, v.v.
 * Có thể dùng dữ liệu này để phân tích hiệu năng và tìm điểm cải thiện.

**Ví dụ cụ thể**:
 * Tạo một mô hình linear regression với ONNX (sử dụng `MatMul` và `Add`).
 * Tạo session inference (`InferenceSession`) trên CPU.
 * Chạy inference với dữ liệu ngẫu nhiên.
 * Kết thúc profiling bằng `sess.end_profiling()` để lấy tên file JSON chứa dữ liệu profiling.
```python
from onnxruntime import InferenceSession, SessionOptions
from sklearn.linear_model import LinearRegression
from skl2onnx import to_onnx

# train model
clr = LinearRegression()
clr.fit(X_train, y_train)

# convert model to onnx format
model_def = to_onnx(clr, X_train)

so = SessionOptions()
so.enable_profiling = True
sess = InferenceSession(model_def.SerializeToString(), so)

sess.run(None, {'X': X_test})
prof = sess.end_profiling()
```


































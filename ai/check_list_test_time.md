# Check list

#### Verify if the NVIDIA GPU you are using supports
```python
import torch
torch.cuda.is_bf16_supported()
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

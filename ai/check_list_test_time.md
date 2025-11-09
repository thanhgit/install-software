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
* Download the fine-tuned model in fp32 precision
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







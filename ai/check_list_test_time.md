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

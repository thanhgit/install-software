# Dùng ONNX format

#### Dùng transformers-cli để convert đến ONNX
```bash
transformers-cli convert --model_name gpt2 --framework pt --opset 17 onnx/gpt2.onnx
```

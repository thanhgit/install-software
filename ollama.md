# How to use Ollama

#### Models support tools
- #### Tutorial: https://ollama.com/blog/tool-support
- #### [Link](https://ollama.com/search?c=tools)

#### Enable GPU
- #### Get GPU UUID
```bash
nvidia-smi -L
```
- #### Edit `/etc/systemd/system/ollama.service`
```bash
Environment=CUDA_VISIBLE_DEVICES=GPU-xxx
```
- #### Restart ollama server
```bash
sudo systemctl daemon-reload
sudo systemctl restart ollama
```
- #### Restart nvidia driver
```bash
sudo rmmod nvidia_uvm && sudo modprobe nvidia_uvm
```

#### Call chat API
```bash
curl http://localhost:11434/v1/chat/completions \
    -H "Content-Type: application/json" \
    -d '{
        "model": "llama3",
        "messages": [
            {
                "role": "system",
                "content": "You are a helpful assistant."
            },
            {
                "role": "user",
                "content": "what is devsecops?"
            }
        ]
    }'
```

#### Call embedding API
```bash
curl http://localhost:11434/api/embed -d '{
  "model": "nomic-embed-text",
  "input": "Llamas are members of the camelid family"
}'
```

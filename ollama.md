# How to use Ollama

#### Models support tools
- #### Tutorial: https://ollama.com/blog/tool-support
- #### [Link](https://ollama.com/search?c=tools)

#### Configuration
- #### Change OLLAMA_ORIGINS => allow requests from all
```bash
Environment=OLLAMA_ORIGINS=*
```
- #### Change OLLAMA_HOST
```bash
Environment=OLLAMA_HOST=127.0.0.1:11434
```

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

### Create an Agent
```typescript
import { Agent } from "@mastra/core/agent";
import { openai } from '@ai-sdk/openai";
export const myAgent = new Agent({
  name: "My Agent",
  instructions: "You are a helpful assistant.",
  model: openai("gpt-4o-mini"),
});
```












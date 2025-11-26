# How to use Ollama

#### Models support tools
- #### Tutorial: https://ollama.com/blog/tool-support
- #### [Link](https://ollama.com/search?c=tools)

#### Check Nvidia container
```bash
docker info | grep -i runtime
```
```
 Runtimes: io.containerd.runc.v2 nvidia runc
 Default Runtime: nvidia
```

#### Configuration
- #### Change OLLAMA_ORIGINS => allow requests from all
```bash
Environment=OLLAMA_ORIGINS=*
```
- #### Change OLLAMA_HOST
```bash
Environment=OLLAMA_HOST=0.0.0.0:11434
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

### Structured Output
```typescript
const schema = {
  type: "object",
  properties: {
    summary: { type: "string" },
    keywords: { type: "array", items: { type: "string" } },
  },
  additionalProperties: false,
  required: ["summary", "keywords"],
};

const response = await myAgent.generate([
    {
      role: "user",
      content: "Please provide a summary and keywords for the following text: ...",
    },
  ],
  {  output: schema, },
);
console.log("Structured Output:", response.object);
```

#### Creating tools
```typescript
import { createTool } from "@mastra/core/tools";
import { z } from "zod";

const getWeatherInfo = async (city: string) => {
  // Replace with an actual API call to a weather service
  const data = await fetch(`https://api.example.com/weather?city=${city}`).then(
    (r) => r.json(),
  );
  return data;
};

export const weatherInfo = createTool({
  id "Get Weather Information",
  inputSchema: z.object({
    city: z.string(),
  }),
  description: `Fetches the current weather information for a given city`,
  execute: async ({ context: { city } }) => {
    console.log("Using tool to fetch weather information for", city);
    return await getWeatherInfo(city);
  },
});
```










# AI agent

![image](https://github.com/user-attachments/assets/ae86799d-2795-4f31-8ef6-4a43767aa958)
### AI agent architecture to deal with many tools
![image](https://github.com/user-attachments/assets/a2d0d675-4cf6-4cb5-b1c0-7050768945c1)
#### `Reflection` ~ analyze its past output and choices
- #### `Reflection` is the creation of a loop between a creator prompt and a reviser prompt
- #### FX:
```javascript
const reflectionPrompt = new SystemMessage('You are a teacher grading an essay submission ... Provide detailed recommendations, including ..., styles, ...')
async function reflect(state) {
    //...
}
```
### `Multi-agent` ~ can accomplish more than a single agent
![image](https://github.com/user-attachments/assets/da5541a7-2786-45ab-8b48-b7baf58f2116)
- #### `Subgraphs` are graphs that are used as part of another graph
  - #### `Calling a Subgraph Directly` (attach a subgraph directly as a node)
  - #### `Calling a Subgraph with a Function` (define a subgraph with a completely different schema)

![image](https://github.com/user-attachments/assets/1c584501-c403-4161-9087-319b2516f064)
### `Memory`
- #### `knowledge store` ~ allowing users to create memory stores that can be configured for various uses and apps

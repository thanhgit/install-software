# Prompt engineering
- #### Prompting is about shaping behaviour, which must be:
    - #### Repeatable
    - #### Testable
    - #### Maintainable
- #### `𝐓𝐞𝐱𝐭 = 𝐂𝐨𝐝𝐞 𝐏𝐫𝐨𝐦𝐩𝐭𝐬 = 𝐒𝐲𝐬𝐭𝐞𝐦𝐬` ~ `If your agents run on prompts, you need to treat them like production code.` 

### Prompt engineering lifecyle
- #### `𝟏. 𝐃𝐞𝐬𝐢𝐠𝐧`
    - #### Like software, it starts with intent.
    - #### Define the agent’s role, the task, and the output expectations.
    - #### Set tone, constraints, and structure. Think of it like writing an API contract in plain English.

- #### `𝟐. 𝐓𝐞𝐬𝐭 - 𝐃𝐞𝐩𝐥𝐨𝐲`
    - #### Test against edge cases, noisy context, and failure scenarios.
    - #### Once stable, prompts are deployed into real workflows and applications where they become executable logic.

- #### `𝟑. 𝐌𝐨𝐧𝐢𝐭𝐨𝐫`
    - #### Prompts don’t stay perfect.
    - #### As models and data evolve, so does behavior.
    - #### Observability is essential to ensure quality over time.

- #### `𝟒. 𝐒𝐞𝐜𝐮𝐫𝐞`
    - #### Prompts break systems if left unchecked: `Prompt injection`, `Unsafe tool calls`, `Data leaks`
    - #### Prompt engineering includes governance and guardrails.

![](./media/prompting-example.jpeg)
### Some chatGPT prompts

![](./media/llm-post-training.gif)
### `LLM can reason` by right post-training.
#### ✅ Inference-time reasoning methods, which can be applied at inference time, without needing to retrain your model:
- #### Tree of Thoughts (ToT), search through reasoning paths
- #### Chain of Thought (CoT) prompting, prompt models to generate intermediate reasoning steps
- #### Reasoning + Acting, use tools or function calls during reasoning
- #### Self-feedback, prompt the model to critique and refine its own output
- #### Episodic Memory Agents, maintain a memory buffer to improve multi-step reasoning
- #### Self-consistency, sample multiple reasoning paths and select the most consistent answer

### A RAG prompt
```text
Here is a user query: {query}.
And relevant context:
{context}
Please respond to the user query using information and facts provided in the context.
```

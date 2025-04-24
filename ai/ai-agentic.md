# AI agentic
- #### understanding the need for `controls and guardrails` on autonomous agents and using control barrier functions
- #### `Self-governance` implies that the system can make its own decisions, set its own goals, and regulate its behavior based on its internal rules, models, and decision-making algorithms

![image](https://github.com/user-attachments/assets/5f758396-da1c-47c1-8029-310c740c8175)

#### MCP framework
- #### Build effective agents with Model ContextProtocol
- #### AugmentedLLM
```python
from mcp_agent.agents.agent import Agent
from mcp_agent.workflows.llm.augmented_llm_anthropic import AnthropicAugmentedLLM

finder_agent = Agent(
  name="finder",
  instruction="You are an agent with filesystem + fetch access. Return the requested file or URL contents.",
  server_names=["fetch", "filesystem"],
)

async with finder_agent:
  llm = await finder_agent.attach_llm(AnthropicAugmentedLLM)
  result = await llm.generate_str(
    message="Print the first 2 paragraphs of https://www.anthropic.com/research/building-effective-agents",
    # Can override model, tokens and other defaults
  )

  logger.info(f"Result: {result}")

  # Multi-turn conversation
  result = await llm.generate_str(
    message="Summarize those paragraphs in a 128 character tweet",
  )
  logger.info(f"Result: {result}")
```

#### `Behavior trees`
![image](https://github.com/user-attachments/assets/3ac0799e-b9fe-47c6-b825-2e328f76a7df)
- #### are a long-established pattern used to control robotics and AI in games
- #### Built-in node
![image](https://github.com/user-attachments/assets/c2d49668-775f-4387-be0c-e42b22599ce0)
- #### Python library: `py_trees`
- #### `Agentic behavior trees (ABTs)` implement behavior trees on assistant and agent systems

#### Refs:
- #### https://www.linkedin.com/pulse/4-main-ai-agent-design-patterns-recommend-andrew-ng-yiman-huang-nwype/

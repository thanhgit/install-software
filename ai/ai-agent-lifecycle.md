# AI agent life cycle
- #### How agents go from input to action, autonomously.
- #### Design principle: "dữ liệu phân tán, thông tin phân phối, tri trức tập trung, hành động nhất quán"

![](./media/ai-agent-lifecycle.jpeg)

#### 1. Input Received
- #### A user prompt or trigger starts it all. The agent identifies what needs to be done.

#### 2. Intent Recognition
- #### LLMs like GPT-4 or Claude analyze the input to extract user intent or goal.

#### 3. Context & Memory Retrieval
- #### The agent pulls from short-term, long-term, and external memory before taking any action.

#### 4. Task Planning
- #### Breaks down the task into steps, resolves dependencies using reasoning frameworks like ReAct or Tree of Thought.

#### 5. Tool Selection
- #### Chooses the best tool for the job - API call, database query, or external service.

#### 6. Action Execution
- #### Executes the task through the selected tools and handles fallbacks if something fails.

#### 7. Output Validation
- #### Validates output for usefulness, safety, and hallucination with tools like Guardrails and LangSmith.

#### 8. Memory Update
- #### Updates memory to keep continuity and support future decision-making.

#### 9. Feedback Loop (Optional)
- #### Evaluates its own performance - adjusts output or retries if quality is off.

#### 10. Autonomous Next Steps
- #### Decides what to do next: follow up, ask questions, or run another workflow.
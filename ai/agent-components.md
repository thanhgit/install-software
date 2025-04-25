# Agent components

### `Knowledge representation` 
- #### provides the mechanisms for encoding an agent’s understanding of its env into formats amenable to reasoning and decision-making processes

![image](https://github.com/user-attachments/assets/ef26bd5d-3ba8-49d3-89ba-710baf2f4c77)
![image](https://github.com/user-attachments/assets/f794cb03-a356-4e5a-8a38-90020a538319)
#### `Semantic networks` 
- #### are graph-based structures composed of nodes that represent concepts, entities, events, or states in the world

![image](https://github.com/user-attachments/assets/6d1afce5-36a7-4669-b45b-b6b248bd7feb)
#### `Frames`
- #### knowledge about objects, situations, or events is stored in data structures
- #### Each frame consists of a collection of attribute-value pairs that describe the properties and characteristics of the concept being represented

#### `Logic-based representations`
- #### takes a more formal, mathematical route => encode facts, rules, and axioms about a domain
- #### formal logical languages such as propositional logic , rst-order logic , or specialized modal/temporal logics
```
“All humans are mortal” can be represented as ∀ x (Human(x) → Mortal(x)) in rst-order logic
“It is raining or it is sunny” can be expressed as Rain ∨ Sunny in propositional logic
“Eventually, the system will stabilize” can be modeled as ◇ Stable in temporal logic
```

#### `Deductive reasoning`
![image](https://github.com/user-attachments/assets/2c61ba5b-94cc-4740-88f0-114372b38fa1)
- #### is a fundamental form of logical reasoning that follows a top-down approach
- #### Applied to Mathematics/geometry, Law, Software verification, Network routing

#### `Inductive reasoning`
![image](https://github.com/user-attachments/assets/bf8f42c5-7b0f-4794-8b77-f8183ded0da1)
- #### follows a bottom-up methodology, involves making generalizations or deriving probable conclusions from a set of specific observations or data points
- #### Applied to Scientific method, ML, Pattern recognition, Data Mining, Natural language acquisition

#### `Abductive reasoning` ~ inference to the best explanation
![image](https://github.com/user-attachments/assets/b0fa321d-126d-4a4b-a9c5-db4585e40fae)
- #### is a form of reasoning that works backward – attempting to find the most plausible explanations or premises that could account for a given set of observations or data
- #### Applied to Medical diagnosis, Fault detection, Forensics/criminal investigation, AI planning, Scienti c discovery

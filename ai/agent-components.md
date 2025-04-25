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

# Dùng ontology trong owlready2

#### Dùng Pellet reasoning
```python
from owlready2 import *
onto = get_ontology("http://test.org")

with onto:
    sync_reasoner_pellet(infer_property_values = True, infer_data_property_values = True)
```

### Dùng FaCT++ reasoning
* https://github.com/tilde-lab/pyfactxx
```bash
pip install pyfactxx
````








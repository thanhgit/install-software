# Spacy 

#### Part of Speech (POS) Tagging
- #### Giải thích loại từ
```python
import spacy 
spacy.explain("VBD")

# >>> verb, past tense
```

```python
nlp = spacy.load("en_core_web_sm")
doc = nlp("I love Rome, it is the best city in the world!")
for token in doc:
    print(f"{token.text} --> {token.tag_}--> {spacy.explain(token.tag_)}")
```

#### Dependency Parsing
```python
doc = nlp("red car")

for token in doc:
    print(f"{token.text}, {token.dep_} ")

# >>> red, amod 
# >>> car, ROOT
```
```python 
from spacy import displacy

sentence = "A dependency parser analyzes the grammatical structure of a sentence."

nlp = spacy.load("en_core_web_sm")
doc = nlp(sentence)

displacy.serve(doc, style="dep")
```

#### Named Entity Recognition (NER)
```python
sentence = "A dependency parser analyzes the grammatical structure of a sentence."

nlp = spacy.load("en_core_web_sm")
doc = nlp("Rome is the bast city in Italy based on my Google search")

doc.ents
# >>> (Rome, Italy, Google)

doc[0], doc[0].ent_type_, spacy.explain(doc[0].ent_type_)
# >>> (Rome, 'GPE', 'Countries, cities, states')
```
* Hiển thị
```python
displacy.serve(doc, style="ent")
```

#### Rule-based matching for information extraction
* Token-based matching
```python
"Marcello Politi"
"Marcello   Politi"
"Marcello Danilo Politi"

reg = r"Marcello\s(Danilo\a)?Politi"
```
```python
import spacy
from spacy.matcher import Matcher
from spacy.tokens import Span

nlp = spacy.load("en_core_web_sm")

matcher = Matcher(nlp.vocab)
pattern = [
    {"LOWER": "good"},
    {"LOWER": "morning"},
    {"IS_PUNCT": True},
]
matcher.add("monrningGreeting", [pattern])

doc = nlp("Good morning, My name is Marcello Politi!")
matches = matcher(doc)
spans = []

for match_id, start, end in matches:
  spans.append(
      Span(doc, start, end, nlp.vocab.strings[match_id])
  )

doc.spans["sc"] = spans
```
* Hiển thị
```python
from spacy import displacy

displacy.render(doc, style = "span")
```
* Patterns with PhraseMatcher
```python
import spacy
from spacy.tokens import Span
from spacy.matcher import PhraseMatcher
from spacy import displacy

nlp = spacy.load("en_core_web_sm")

terms = ["Sundar Pichai", "Tim Cook", "Silicon Valley"]
matcher = PhraseMatcher(nlp.vocab)
patterns = [nlp.make_doc(text) for text in terms]
matcher.add("TechLeadersAndPlaces", patterns)

doc = nlp("Tech CEOs like Sundar Pichai and Tim Cook met in Silicon Valley to discuss AI regulation.")
matches = matcher(doc)
spans= []

for match_id, start, end in matches:
  pattern_name = nlp.vocab.strings[match_id]
  spans.append(Span(doc, start, end, pattern_name))

doc.spans["sc"] = spans
displacy.render(doc, style = "span")
```

* Ví dụ, tìm IP addresses in a text
```python
matcher = PhraseMatcher(nlp.vocab, attr= "SHAPE")

ips  = ["127.0.0.0", "127.256.0.0"]
patterns = [nlp.make_doc(ip) for ip in ips]
matcher.add("IP-pattern", patterns)


doc = nlp("This fastAPI server can run on 192.1.1.1 or on 192.170.1.1")
matches = matcher(doc)
spans= []

for match_id, start, end in matches:
  pattern_name = nlp.vocab.strings[match_id]
  spans.append(Span(doc, start, end, pattern_name))

doc.spans["sc"] = spans
displacy.render(doc, style = "span")
```

* IBAN Extraction là lấy thông tin quan trọng 
```python
pattern =[
   {
    "SHAPE":"XXdd"
   },
   {
    "TEXT": "REGEX":"\d{1,4}, "OP":"+"
   }
]

matcher = Matcher(nlp.vocab)
matcher.add("IBAN", [patttern])
```
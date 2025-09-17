---
model: gemini:gemini-2.5-flash
temperature: 0
---

Your task is to take the input and improve upon it according to the request provided at the start. The request is given as `::: request :::`. Keep the original structure of blocks, formatting quirks, etc, unless the request implies changing it. Don't include markdown code wrappers, original request, emotional or conversational filler.

### INPUT:

```lua
-- ::: extract if and proof-read the text [lua] :::
local str = is_needed and "How does it look like?"
```

### OUTPUT:

```lua
local str
if is_needed then
  str = "What does it look like?"
end
```

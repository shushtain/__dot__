---
model: gemini:gemini-2.5-flash
temperature: 0
---

Provide only code, without comments or explanations. If no programming language is specified, try to guess based on the prompt. If it's still ambiguous, prioritize Rust.

### INPUT:

async sleep in js

### OUTPUT:

```javascript
async function timeout(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}
```

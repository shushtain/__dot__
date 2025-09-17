---
model: gemini:gemini-2.5-flash-lite
temperature: 0
---

Analyze the contents of git diff and generate the commit header. The header must respect 50 character limit and follow Conventional Commits specification. Provide only the unquoted header string without comments or explanations. Both type and description should not be capitalized.

Be specific. For example, if the commit introduces two new Rust crates, it's better to list them than to say "updated dependencies", unless they don't fit within the header.

If the input does not contain any meaningful information (e.g. it's an empty string or just a dot, etc), output "style: minor adjustments".

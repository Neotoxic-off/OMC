---
name: no-goto
enabled: true
event: file
conditions:
  - field: file_path
    operator: regex_match
    pattern: \.cs$
  - field: new_text
    operator: regex_match
    pattern: \bgoto\b
---

**C# Style: No `goto` statements**

`goto` creates unstructured control flow. Use `break`, `continue`, `return`, loops, or extracted methods instead.

❌ `goto retry;`
✅ Refactor into a `while` loop or recursive call.

Remove the `goto` and restructure the logic before proceeding.

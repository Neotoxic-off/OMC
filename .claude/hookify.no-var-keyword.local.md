---
name: no-var-keyword
enabled: true
event: file
conditions:
  - field: file_path
    operator: regex_match
    pattern: \.cs$
  - field: new_text
    operator: regex_match
    pattern: \bvar\s+\w+
---

**C# Style: No `var` keyword**

Always use explicit types — never `var`.

❌ `var name = "hello";`
✅ `string name = "hello";`

❌ `var items = new List<string>();`
✅ `List<string> items = new List<string>();`

Replace `var` with the actual concrete type before proceeding.

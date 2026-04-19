---
name: no-double-space-type
enabled: true
event: file
conditions:
  - field: file_path
    operator: regex_match
    pattern: \.cs$
  - field: new_text
    operator: regex_match
    pattern: (string|int|bool|double|float|long|decimal|char|object|void|List|Dictionary|IEnumerable|Type)\s{2,}\w+
---

**C# Style: Extra space between type and variable name**

Use exactly one space between type and variable name.

❌ `string  name = "hello";`
✅ `string name = "hello";`

❌ `int  count = 0;`
✅ `int count = 0;`

❌ `int count    = 0;`
✅ `int count = 0;`

Remove the extra spaces before proceeding.

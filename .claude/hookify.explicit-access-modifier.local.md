---
name: explicit-access-modifier
enabled: true
event: file
conditions:
  - field: file_path
    operator: regex_match
    pattern: \.cs$
  - field: new_text
    operator: regex_match
    pattern: "^\\s+(static\\s+|readonly\\s+|abstract\\s+|virtual\\s+|override\\s+)?(void|string|int|bool|double|float|long|decimal|Task|List<|Dictionary<|IEnumerable<)\\s+\\w+"
---

**C# Style: Explicit access modifiers required**

Never rely on default (implicit private) visibility. Always declare `private`, `public`, `protected`, `internal`, or `protected internal` explicitly.

❌ `void DoWork() { }`
✅ `private void DoWork() { }`

❌ `static readonly int MaxCount = 10;`
✅ `private static readonly int MaxCount = 10;`

Add the explicit access modifier before proceeding.

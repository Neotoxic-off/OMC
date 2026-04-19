---
name: no-public-fields
enabled: true
event: file
conditions:
  - field: file_path
    operator: regex_match
    pattern: \.cs$
  - field: new_text
    operator: regex_match
    pattern: public\s+(static\s+)?(string|int|bool|double|float|long|decimal|char|byte|object|Guid|DateTime|List<|Dictionary<|IEnumerable<|HashSet<)\s+\w+\s*;
---

**C# Style: No public fields — use properties**

Public fields expose internals directly. Always use auto-properties or full properties.

❌ `public string Name;`
✅ `public string Name { get; set; }`

❌ `public int Count;`
✅ `public int Count { get; private set; }`

Convert the public field to a property before proceeding.

---
name: no-regions
enabled: true
event: file
conditions:
  - field: file_path
    operator: regex_match
    pattern: \.cs$
  - field: new_text
    operator: regex_match
    pattern: "#region"
---

**C# Style: No `#region` blocks**

Regions hide complexity and encourage oversized classes. If code needs regions, it needs refactoring.

❌
```csharp
#region Helpers
private string Format(string s) { ... }
#endregion
```

✅ Extract into a separate class or partial class instead.

Remove all `#region` / `#endregion` blocks before proceeding.

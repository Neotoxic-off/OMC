---
name: is-null-check
enabled: true
event: file
conditions:
  - field: file_path
    operator: regex_match
    pattern: \.cs$
  - field: new_text
    operator: regex_match
    pattern: (==\s*null|!=\s*null|null\s*==|null\s*!=)
---

**C# Style: Use `is null` / `is not null` for null checks**

Pattern matching null checks are clearer and not overridable by `==` operator overloads.

❌ `if (x == null)`
✅ `if (x is null)`

❌ `if (x != null)`
✅ `if (x is not null)`

❌ `return value == null ? "none" : value;`
✅ `return value is null ? "none" : value;`

Replace all `== null` / `!= null` with `is null` / `is not null` before proceeding.

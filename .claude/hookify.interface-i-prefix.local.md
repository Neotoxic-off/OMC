---
name: interface-i-prefix
enabled: true
event: file
conditions:
  - field: file_path
    operator: regex_match
    pattern: \.cs$
  - field: new_text
    operator: regex_match
    pattern: \binterface\s+[A-HJ-Z]\w*\b
---

**C# Style: Interfaces must start with `I`**

.NET naming convention: all interface names begin with capital `I`.

❌ `interface Repository { }`
✅ `interface IRepository { }`

❌ `interface UserService { }`
✅ `interface IUserService { }`

Rename the interface (and all usages) to start with `I` before proceeding.

---
name: no-throw-base-exception
enabled: true
event: file
conditions:
  - field: file_path
    operator: regex_match
    pattern: \.cs$
  - field: new_text
    operator: regex_match
    pattern: throw new (Exception|ApplicationException|SystemException)\(
---

**C# Style: No throwing base `Exception` types**

Always throw a specific, meaningful exception type. Base `Exception` gives callers no useful type to catch.

❌ `throw new Exception("Something went wrong");`
✅ `throw new InvalidOperationException("Cannot call Foo before initialization.");`

❌ `throw new ApplicationException("Bad input");`
✅ `throw new ArgumentException("Value must be positive.", nameof(value));`

Common specific exceptions: `ArgumentException`, `ArgumentNullException`, `ArgumentOutOfRangeException`, `InvalidOperationException`, `NotSupportedException`, `ObjectDisposedException`, `KeyNotFoundException`.

Replace with the appropriate specific exception type before proceeding.

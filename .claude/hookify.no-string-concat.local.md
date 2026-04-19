---
name: no-string-concat
enabled: true
event: file
conditions:
  - field: file_path
    operator: regex_match
    pattern: \.cs$
  - field: new_text
    operator: regex_match
    pattern: "\"+\\s*\\+\\s*\\w+|\\w+\\s*\\+\\s*\""
---

**C# Style: No string concatenation with `+`**

Use string interpolation (`$"..."`) for readability. Use `StringBuilder` for loops or many concatenations.

❌ `string msg = "Hello " + name + "!";`
✅ `string msg = $"Hello {name}!";`

❌ `string path = dir + "\\" + file + ".txt";`
✅ `string path = $"{dir}\\{file}.txt";`

For loops building strings: use `StringBuilder`.

Replace `+` string concatenation with interpolation or `StringBuilder` before proceeding.

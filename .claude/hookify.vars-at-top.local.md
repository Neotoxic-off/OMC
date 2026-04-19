---
name: vars-at-top
enabled: true
event: file
conditions:
  - field: file_path
    operator: regex_match
    pattern: \.cs$
  - field: new_text
    operator: regex_match
    pattern: ;\s+(string|int|bool|double|float|long|decimal|char|object|List<|Dictionary<|IEnumerable<|HashSet<|Queue<|Stack<)\s+\w+\s*=
---

**C# Style: Variables must be declared at the top of the function**

All variables must be declared AND initialized at the very top of the function body, before any logic (conditionals, loops, method calls, etc.).

❌ Wrong — variable declared mid-function:
```csharp
void Foo()
{
    DoSomething();
    string result = Compute();  // ← declared after logic
}
```

✅ Correct — all variables at top:
```csharp
void Foo()
{
    string result = Compute();  // ← declared first
    DoSomething();
}
```

Move the variable declaration(s) to the top of the function before proceeding.

---
name: no-empty-catch
enabled: true
event: file
conditions:
  - field: file_path
    operator: regex_match
    pattern: \.cs$
  - field: new_text
    operator: regex_match
    pattern: "catch\\s*(\\([^)]*\\))?\\s*\\{\\s*\\}"
---

**C# Style: No empty catch blocks**

Silent swallowing of exceptions hides bugs. Always log, rethrow, or handle meaningfully.

❌
```csharp
catch (Exception) { }
catch { }
```

✅
```csharp
catch (Exception ex)
{
    _logger.LogError(ex, "Operation failed.");
    throw;
}
```

Add handling (log + rethrow, or explicit intentional comment) before proceeding.

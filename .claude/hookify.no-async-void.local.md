---
name: no-async-void
enabled: true
event: file
conditions:
  - field: file_path
    operator: regex_match
    pattern: \.cs$
  - field: new_text
    operator: regex_match
    pattern: async\s+void\s+(?!(On[A-Z]|\w+_\w+))
---

**C# Style: No `async void` methods**

`async void` exceptions cannot be caught by callers and crash the process. Only allowed for event handlers (prefixed `On...` or matching `Name_EventName` pattern).

❌ `private async void LoadData()`
✅ `private async Task LoadData()`

❌ `public async void Save()`
✅ `public async Task Save()`

✅ `private async void OnButtonClick(object sender, EventArgs e)` — event handler, OK.

Change return type to `Task` before proceeding.

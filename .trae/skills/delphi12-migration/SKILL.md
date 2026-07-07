---
name: "delphi12-migration"
description: "Complete guide for migrating legacy Delphi projects (D7~XE) to Delphi 12. Covers encoding, AnsiStrings, PChar→PAnsiChar, namespace resolution, debugger errors, and build automation. Invoke when upgrading any pre-Delphi12 project to Delphi 12+."
---

# Delphi 12 Migration Skill

Comprehensive experience accumulated from migrating a real-world industrial control project (BWHPU) from legacy Delphi to Delphi 12. This skill contains every issue encountered and its resolution.

## Quick Diagnosis Checklist

When a legacy Delphi project fails in Delphi 12, check these in order:

1. File encoding → all files must be UTF-8 with BOM
2. `AnsiStrings` unit → must be explicitly added to uses clauses
3. `PChar` → `PAnsiChar` in serial/comm code
4. Namespace prefixes → IDE auto-resolves, CLI needs `-NS`
5. Duplicate method declarations → remove old-style duplicates
6. `.dproj` compatibility → regenerate from IDE or copy from working reference

---

## Issue 1: File Encoding — The Root of Most Problems

### Symptom
- Chinese characters garbled in IDE/editor
- `EConvertError: 'Variant method calls not supported'` at debug time
- Compiler parses code incorrectly despite syntax being valid
- File sizes differ from a known-good reference project

### Root Cause
Legacy Delphi files used ANSI/GBK (CP936) encoding without BOM. Delphi 12 and modern editors (VS Code, Trae) default to UTF-8. When a GBK file is misread as UTF-8, the compiler generates corrupted DCU symbol tables, which causes the debugger to misinterpret Variant operations — hence the cryptic "Variant method calls not supported" error. **This error has nothing to do with Variant code itself.**

### Fix

**Detection (PowerShell):**
```powershell
$bytes = [System.IO.File]::ReadAllBytes("filename.pas")
if ($bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
    Write-Host "UTF-8 with BOM"
} elseif ($bytes[0] -eq 0x75 -and $bytes[1] -eq 0x6E) {
    Write-Host "Likely ANSI/GBK (no BOM, starts with 'un')"
} else {
    Write-Host "Check manually"
}
```

**Conversion (PowerShell) — preserves content correctly:**
```powershell
# Convert GBK/ANSI .pas and .dfm files to UTF-8 with BOM
$files = Get-ChildItem -Path "." -Include "*.pas","*.dfm" -Recurse
foreach ($f in $files) {
    $content = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::GetEncoding(936))
    [System.IO.File]::WriteAllText($f.FullName, $content, (New-Object System.Text.UTF8Encoding $true))
    Write-Host "Converted: $($f.Name)"
}
```

**Conversion (Python — smart detection, preferred):**
```python
import os
from pathlib import Path

def convert_to_utf8_bom(file_path):
    encodings_to_try = ['gb2312', 'gbk', 'gb18030', 'utf-8', 'big5']
    raw_bytes = Path(file_path).read_bytes()

    for enc in encodings_to_try:
        try:
            content = raw_bytes.decode(enc)
            if any('一' <= c <= '鿿' for c in content):
                Path(file_path).write_text(content, encoding='utf-8-sig')
                return enc
        except (UnicodeDecodeError, UnicodeError):
            continue
    return None
```

### Key Insight
When you have a **reference project** that compiles and runs correctly, the safest approach is to compare file sizes first, then copy clean files from the reference rather than trying to repair corrupted ones. Direct copy eliminates invisible encoding damage.

---

## Issue 2: AnsiStrings Unit — Explicit Uses Required

### Symptom
```
[dcc32 Error] Main.pas(xxx): E2003 Undeclared identifier: 'StrLen'
[dcc32 Error] Main.pas(xxx): E2003 Undeclared identifier: 'StrCat'
[dcc32 Error] FatekPLC.pas(xxx): E2003 Undeclared identifier: 'StrCopy'
```

### Root Cause
In Delphi 12, `AnsiStrings.StrLen`, `AnsiStrings.StrCat`, `AnsiStrings.StrCopy` etc. are no longer auto-imported. You must add `AnsiStrings` to your uses clause.

### Fix
```pascal
uses
  // ...existing units...,
  AnsiStrings;  // <-- add this
```

Then prefix calls:
```pascal
// Before (legacy — worked in D7~XE):
StrLen(Pstr1)
StrCopy(dest, src)
StrCat(dest, src)

// After (Delphi 12):
AnsiStrings.StrLen(Pstr1)
AnsiStrings.StrCopy(dest, src)
AnsiStrings.StrCat(dest, src)
```

### Files Typically Affected
- Any unit doing serial/COM port communication
- Modbus/TCP client implementations
- PLC communication modules
- String buffer manipulation code

---

## Issue 3: PChar → PAnsiChar in Communication Code

### Symptom
Data corruption when sending/receiving binary data over serial ports or TCP. Bytes with values > 127 get mangled.

### Root Cause
In Delphi 12, `PChar` maps to `PWideChar` (UTF-16). Legacy serial communication code that uses `PChar` to point to byte buffers will interpret each byte as a wide character, corrupting binary protocols (Modbus, PLC protocols, etc.).

### Fix
```pascal
// Before:
function SendData2Plc(DataPtr: PChar; DataLen: integer): boolean;
var
  tmpData2: PChar;
begin
  GetMem(tmpData2, 1024);
  StrCopy(tmpData2, DataPtr);
  // ...
end;

// After:
function SendData2Plc(DataPtr: PAnsiChar; DataLen: integer): boolean;
var
  tmpData2: PAnsiChar;
begin
  GetMem(tmpData2, 1024);
  AnsiStrings.StrCopy(tmpData2, DataPtr);
  // ...
end;
```

Also update buffer declarations:
```pascal
// Before:
var
  Buffer: array[0..4095] of Char;
  pStr: PChar;

// After:
var
  Buffer: array[0..4095] of AnsiChar;
  pStr: PAnsiChar;
```

### Conditional Compilation for Cross-Version Support
```pascal
{$IFDEF DELPHI12_OR_NEWER}
uses AnsiStrings;
{$ENDIF}

{$IFDEF W_PANSICHAR}
  PCommChar = PAnsiChar;
{$ELSE}
  PCommChar = PChar;
{$ENDIF}
```

### Files Typically Affected
- `SPComm.pas` — serial port component
- `FatekPLC.pas` — PLC protocol
- `IdModbusClient.pas` — Modbus TCP
- Any unit using `CreateFile`, `ReadFile`, `WriteFile` with string buffers

---

## Issue 4: Namespace Resolution — IDE vs Command Line

### Symptom
Project compiles fine in Delphi 12 IDE but fails with `dcc32.exe` command-line compiler:
```
[dcc32 Error] Main.pas(xxx): E2003 Undeclared identifier: 'Create'
[dcc32 Fatal Error] Main.pas(xxx): F2063 Could not compile used unit '...'
```

### Root Cause
Delphi 12 introduced unit scope namespaces (`Winapi.*`, `System.*`, `Vcl.*`). The IDE automatically resolves these, but `dcc32.exe` requires explicit `-NS` parameter.

### Fix

**Option A: Add namespace prefixes in source (recommended for new projects)**
```pascal
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs;
```

**Option B: Command-line namespace parameter**
```powershell
dcc32.exe -B -NS"System;Winapi;Vcl;Data;Xml;Soap;Web;Datasnap;System.Win;Data.Win;Datasnap.Win;Web.Win;Soap.Win;Xml.Win" HPU.dpr
```

**Option C: Use IDE-generated .dproj (recommended for legacy migration)**
Copy the `.dproj` from a working Delphi 12 reference project. The `.dproj` contains all namespace configuration and is the most reliable approach.

### Recommendation
For legacy project migration, **copy a working `.dproj`** from a reference project. This ensures all settings (namespaces, search paths, compiler flags) are correct. Manual namespace editing is error-prone.

---

## Issue 5: Duplicate Method Declarations

### Symptom
```
[dcc32 Error] Main.pas(xxx): E2037 Declaration of 'XXX' differs from previous declaration
```

### Root Cause
Some legacy codebases have methods declared in both the interface section's `type` block AND repeated in an earlier `private`/`public` section. Older compilers were lenient; Delphi 12 is strict.

### Fix
Remove duplicate declarations, keeping only one. These are often found in form units where a helper method was added to the interface section without removing a prior declaration.

---

## Issue 6: Delphi 12 IDE Configuration

### .env File
```batch
DELPHI_VERSION=23.0
DELPHI_PATH=C:\Program Files (x86)\Embarcadero\Studio\23.0
DCC32_PATH=C:\Program Files (x86)\Embarcadero\Studio\23.0\bin\dcc32.exe
DCC64_PATH=C:\Program Files (x86)\Embarcadero\Studio\23.0\bin\dcc64.exe
OUTPUT_DIR=Win32\Release
DEBUG_OUTPUT_DIR=Win32\Debug
```

### VS Code / Trae Settings (`.trae/settings.json`)
```json
{
  "files.encoding": "gbk",
  "[pascal]": {
    "files.encoding": "gbk"
  }
}
```
Set encoding to `gbk` for legacy projects still using ANSI source files. Once fully migrated to UTF-8, change to `utf8`.

---

## Issue 7: Build Automation

### Minimal PowerShell Build Script
```powershell
param([ValidateSet("Debug","Release")][string]$Configuration="Release")

$DCC32 = "C:\Program Files (x86)\Embarcadero\Studio\23.0\bin\dcc32.exe"
$NS = 'System;Winapi;Vcl;Data;Xml;Soap;Web;Datasnap;System.Win;Data.Win;Datasnap.Win;Web.Win;Soap.Win;Xml.Win'

$opts = @("-B", "-Q", "-W",
    "-E.\Win32\$Configuration",
    "-N.\Win32\$Configuration",
    "-LE.\Win32\$Configuration",
    "-LN.\Win32\$Configuration",
    "-NS`"$NS`""
)

if ($Configuration -eq "Debug") { $opts += @("-V", "-GD") }

$proc = Start-Process $DCC32 -ArgumentList ($opts + "HPU.dpr") -Wait -PassThru -NoNewWindow
if ($proc.ExitCode -eq 0) {
    Write-Host "Build succeeded: .\Win32\$Configuration\HPU.exe"
} else {
    Write-Host "Build failed with code $($proc.ExitCode)"
    exit $proc.ExitCode
}
```

---

## Complete Migration Workflow

### Phase 1: Assessment
1. Identify all `.pas`, `.dfm`, `.dpr`, `.dproj` files
2. Check each file's encoding (BOM presence)
3. Check for `PChar` usage in communication/buffer code
4. Check for bare `StrLen`/`StrCopy`/`StrCat` calls (missing `AnsiStrings.` prefix)
5. Attempt IDE compilation, note all errors
6. Attempt command-line compilation (`dcc32.exe`), note differences from IDE

### Phase 2: Fix Encoding (Foundation)
1. Convert all `.pas` and `.dfm` files to UTF-8 with BOM
2. Verify Chinese characters display correctly after conversion
3. If possible, diff against a known-good reference project

### Phase 3: Fix Code
1. Add `AnsiStrings` to uses clauses of affected units
2. Replace `PChar` with `PAnsiChar` in serial/comm/buffer code
3. Replace bare `StrLen` → `AnsiStrings.StrLen`, `StrCopy` → `AnsiStrings.StrCopy`, `StrCat` → `AnsiStrings.StrCat`
4. Add namespace prefixes to uses clauses (or rely on `.dproj` config)
5. Remove duplicate method declarations
6. Fix any `string` → `AnsiString` type mismatches in protocol code

### Phase 4: Configure
1. Copy `.dproj` from working reference or regenerate from IDE
2. Set up `.env` with Delphi paths
3. Create `build.ps1` for command-line compilation

### Phase 5: Verify
1. IDE Build → must pass with 0 errors
2. IDE Run + Debug (F9) → no "Variant method calls not supported"
3. Chinese characters display correctly in UI
4. Command-line build (`.\build.ps1`) passes
5. Runtime test: program starts, opens COM port, reads config
6. Exit code is 0

---

## Common Mistakes to Avoid

| Wrong | Right | Why |
|-------|-------|-----|
| Manually fixing "Variant" code | Fix file encoding first | Encoding corruption mimics Variant errors |
| Adding namespace prefixes one by one | Copy working `.dproj` | Miss one prefix → mysterious compile error |
| Converting encoding without proper detection | Use Python chardet or try multiple codecs | Wrong codec = garbled comments |
| Using UTF-8 without BOM | Always use UTF-8 with BOM | Delphi 12 expects BOM for DBCS content |
| Editing `.dproj` manually | Let IDE regenerate it | Internal GUIDs and paths must be consistent |
| Mixing `PChar` and `PAnsiChar` | Pick one per module | Type confusion at call sites |
| Skipping command-line build test | Test both IDE and CLI | IDE auto-resolves what CLI cannot |

---

## Reference: Files Changed in BWHPU Migration

| File | Changes |
|------|---------|
| `Main.pas` | Added `AnsiStrings` to uses, namespace prefixes, encoding fix |
| `FatekPLC.pas` | `PChar→PAnsiChar`, `StrLen→AnsiStrings.StrLen`, encoding fix |
| `LanguageFunc.pas` | Encoding fix (GBK comments → UTF-8), BOM added |
| `SPComm.pas` | `PChar→PAnsiChar` (had `W_PANSICHAR` define), encoding fix |
| `ModbusUtils.pas` | BOM added, encoding fix |
| `ModbusConsts.pas` | BOM added |
| `ModbusTypes.pas` | BOM added |
| `IdModbusClient.pas` | BOM added, encoding fix |
| `TypeDef.pas` | Encoding fix |
| `VarDef.pas` | Encoding fix |
| `FileFunc.pas` | Encoding fix |
| `ParaSet.pas` | Encoding fix |
| `Main.dfm` | Encoding fix |
| `ParaSet.dfm` | Encoding fix |
| `HPU.dproj` | Regenerated for Delphi 12 |
| `HPU.res` | Regenerated |
| All `.dfm` files | UTF-8 BOM conversion |

---

## Quick Start: Apply to a New Project

```powershell
# 1. Convert all source files to UTF-8 BOM
Get-ChildItem -Recurse -Include "*.pas","*.dfm","*.dpr" | ForEach-Object {
    $content = [System.IO.File]::ReadAllText($_.FullName, [System.Text.Encoding]::GetEncoding(936))
    [System.IO.File]::WriteAllText($_.FullName, $content, (New-Object System.Text.UTF8Encoding $true))
}

# 2. Check for PChar in communication units (manual review needed)
Select-String -Pattern "PChar" -Path "*.pas" | Where-Object { $_.Line -notmatch "PAnsiChar" }

# 3. Check for missing AnsiStrings prefix
Select-String -Pattern "(?<!AnsiStrings\.)\bStr(Len|Copy|Cat)\b" -Path "*.pas"

# 4. Build
dcc32.exe -B -NS"System;Winapi;Vcl;Data;Xml;Soap;Web;Datasnap;System.Win;Data.Win;Datasnap.Win;Web.Win;Soap.Win;Xml.Win" YourProject.dpr
```

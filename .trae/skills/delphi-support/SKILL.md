---
name: "delphi-support"
description: "Provides Delphi/Pascal language support including syntax help, code completion, compilation guidance, and project structure analysis. Invoke when working with .pas, .dpr, .dproj files or Delphi-related questions."
---

# Delphi Support Skill

This skill provides comprehensive support for Delphi/Object Pascal development in Trae.

## Supported File Types

- `.pas` - Pascal unit files
- `.dpr` - Delphi project files
- `.dproj` - Delphi project configuration
- `.dfm` - Delphi form files
- `.bdsproj` - Borland Developer Studio projects
- `.groupproj` - Project group files

## Common Tasks

### 1. Code Navigation
- Jump to declarations: `Ctrl + Click` on identifiers
- Find references: Right-click → Find References
- Go to definition: `F12`

### 2. Code Completion
- Standard Pascal syntax highlighting
- Common Delphi VCL/FMX components
- RTL (Run-Time Library) functions

### 3. Project Structure
```
Project/
├── .dpr          # Main project file
├── .dproj        # Project configuration
├── .pas          # Unit files
├── .dfm          # Form definitions
└── .res          # Resources
```

### 4. Compilation
- Use Delphi IDE (RAD Studio) for compilation
- Or use MSBuild with .dproj files
- Command line: `dcc32.exe Project.dpr`

### 5. Common Patterns

#### Unit Structure
```pascal
unit MyUnit;

interface

uses
  Classes, SysUtils;

type
  TMyClass = class(TObject)
  public
    procedure DoSomething;
  end;

implementation

procedure TMyClass.DoSomething;
begin
  // Implementation
end;

end.
```

#### Form Creation
```pascal
procedure TMainForm.FormCreate(Sender: TObject);
begin
  // Initialization code
end;
```

## Key Delphi Concepts

1. **Units**: Modular code organization
2. **Forms**: Visual components (.dfm + .pas)
3. **Components**: VCL/FMX visual and non-visual components
4. **Events**: Event-driven programming model
5. **Packages**: BPL for code sharing

## Tips

- Always match .pas and .dfm files
- Use `{$R *.dfm}` to link form resources
- Interface section = public API
- Implementation section = private code
- Initialization/Finalization for unit-level setup

## Resources

- Delphi RTL: System, SysUtils, Classes
- VCL: Forms, Controls, StdCtrls, ExtCtrls
- Database: DB, DBClient, FireDAC
- Network: Indy components

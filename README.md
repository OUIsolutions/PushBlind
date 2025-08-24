

<div align="center">

# PushBlind
![Lua Logo](https://img.shields.io/badge/PushBlind-0.5.0-blue?style=for-the-badge&logo=lua)
[![GitHub Release](https://img.shields.io/github/release/OUIsolutions/PushBlind.svg?style=for-the-badge)](https://github.com/OUIsolutions/PushBlind/releases)
[![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)](https://github.com/OUIsolutions/PushBlind/blob/main/LICENSE)
![Status](https://img.shields.io/badge/Status-Alpha-orange?style=for-the-badge)
![Platforms](https://img.shields.io/badge/Platforms-Windows%20|%20Linux-lightgrey?style=for-the-badge)

</div>

---

## ⚠️ Important Notice

> **This is alpha software!** Use at your own risk. While we're working hard to make it stable, bugs are expected. Perfect for learning and prototyping! 🧪

---

### Overview

PushBlind is a package manager for Lua-based automation scripts and development tools. It provides a streamlined interface for managing GitHub-hosted packages that define automated actions for software development tasks.

**Core Operations:**
1. **Add packages from GitHub repositories**
2. **Install and manage package dependencies**  
3. **Execute package actions and workflows**
4. **Update packages to latest versions**
5. **Remove packages when no longer needed**

PushBlind is designed for developers who need to:
- Manage automation scripts and development tools
- Download and install packages from GitHub repositories
- Execute automated tasks like building, testing, or deploying
- Keep development tools updated with latest versions
- Create and distribute custom automation packages
- Run package-defined actions through a unified CLI interface

### Key Features

- **GitHub Integration** - Direct package installation from GitHub repositories
- **Action-Based System** - Execute specific actions defined by packages
- **Git Customization** - Configurable git commands for cloning and updating
- **Cross-platform Support** - Compatible with Windows and Linux systems
- **Minimal Configuration** - Simple setup with customizable git operations
- **Package Isolation** - Each package is managed independently
- **Extensible Actions** - Packages can define custom actions beyond install/update/remove

### Package Development

Want to create your own packages for PushBlind? Check the `package_sample/` directory for examples showing how to create package definitions with action functions using the `PushBlind.actions` namespace.

---

## Releases

|  **File**                                                                                                           | **What is**                                |
|---------------------------------------------------------------------------------------------------------------------|--------------------------------------------|
|[pushblind.out](https://github.com/OUIsolutions/PushBlind/releases/download/0.5.0/pushblind.out)                   | Linux Static Binary                        |
|[pushblind64.exe](https://github.com/OUIsolutions/PushBlind/releases/download/0.5.0/pushblind64.exe)               | Windows 64-bit Binary                      |
|[pushblinди32.exe](https://github.com/OUIsolutions/PushBlind/releases/download/0.5.0/pushblinди32.exe)             | Windows 32-bit Binary                      |
|[pushblind.deb](https://github.com/OUIsolutions/PushBlind/releases/download/0.5.0/pushblind.deb)                   | Debian Package                             |
|[pushblind.rpm](https://github.com/OUIsolutions/PushBlind/releases/download/0.5.0/pushblind.rpm)                   | RPM Package                                |
|[extension.c](https://github.com/OUIsolutions/PushBlind/releases/download/0.5.0/extension.c)                       | VibeScript Extension Source                |

## Installation and Usage Documentation

| **Documentation**                                                | **Description**                                       |
|----------------------------------------------------------------|-------------------------------------------------------|
| [Build from Source](docs/build_from_scrath.md)                | Complete guide to building PushBlind from source     |
| [CLI Usage Guide](docs/cli_usage.md)                          | Comprehensive CLI commands and usage examples        |
| [Package Creation](docs/packing.md)                           | How to create your own PushBlind packages            |

## [CLI Commands Reference](docs/cli_usage.md)
Click here [CLI Commands Reference](docs/cli_usage.md) to see the complete list of available commands.

## CLI Usage

### Basic Commands

#### Configure Git Commands
PushBlind uses git internally to manage packages. You can customize which git commands it uses:

```bash
pushblind set_git_clone "git clone"
pushblind set_git_pull "git pull"
```

#### Add Package
Add a package from a GitHub repository:
```bash
pushblind add <repository_url> <entry_file> --name <package_name>

# Examples:
pushblind add https://github.com/OUIsolutions/public_oui_packages.git all.lua --name public_oui
pushblind add https://github.com/example/my-package.git main.lua --name my_package
```

#### Install Package
Install or set up a package for use:
```bash
pushblind install <package_name>

# Example:
pushblind install public_oui
```

#### Update Package
Update a package to the latest version:
```bash
pushblind update <package_name>

# Example:
pushblind update public_oui
```

#### Remove Package
Remove a package and its files:
```bash
pushblind remove <package_name>

# Example:
pushblind remove public_oui
```

#### Execute Package Actions
Execute specific actions from installed packages:
```bash
pushblind <action_name> <package_name>

# Example:
pushblind build_project public_oui
```

## Package Creation Guide

### Basic Package Structure

Create a Lua file with action functions using the `PushBlind.actions` namespace:

```lua
-- Required action: Install the package
function PushBlind.actions.install()
    print("Installing my package...")
    -- Add your installation logic here
    -- This might include:
    -- - Creating necessary directories
    -- - Downloading dependencies
    -- - Setting up configuration files
    -- - Installing system dependencies
    
    print("Package installed successfully!")
end

-- Required action: Update the package
function PushBlind.actions.update()
    print("Updating my package...")
    -- Add your update logic here
    -- This might include:
    -- - Pulling latest configurations
    -- - Updating dependencies
    -- - Migrating settings
    
    print("Package updated successfully!")
end

-- Required action: Remove the package
function PushBlind.actions.remove()
    print("Removing my package...")
    -- Add your removal logic here
    -- This might include:
    -- - Cleaning up created files
    -- - Removing installed dependencies
    -- - Restoring previous configurations
    
    print("Package removed successfully!")
end

-- Custom action example: Build a project
function PushBlind.actions.build_project()
    print("Building project...")
    -- Add build logic here
    print("Project built successfully!")
end
```

### Package Examples

#### Simple Binary Installation
```lua
function PushBlind.actions.install()
    print("Installing binary tool...")
    -- Download and install a binary tool
    os.execute('curl -L https://example.com/tool.out -o tool.out')
    os.execute("sudo chmod +x tool.out")
    os.execute("sudo mv tool.out /usr/bin/tool")
    print("Tool installed successfully!")
end

function PushBlind.actions.update()
    print("Updating binary tool...")
    -- Update to latest version
    os.execute('curl -L https://example.com/tool.out -o tool.out')
    os.execute("sudo chmod +x tool.out")
    os.execute("sudo mv tool.out /usr/bin/tool")
    print("Tool updated successfully!")
end
```

#### Meta Package (Installing Multiple Packages)
```lua
function PushBlind.actions.install()
    print("Meta package cannot be directly installed")
    print("Use update action to add component packages")
end

function PushBlind.actions.update()
    print("Adding component packages...")
    
    -- Add multiple related packages from the same repository
    PushBlind.add_package({
        repo = PushBlind.same, -- Refers to the current repository
        filename = "component1.lua",
        name = "component1",
        force = false -- Don't re-clone if already exists
    })
    
    PushBlind.add_package({
        repo = PushBlind.same,
        filename = "component2.lua", 
        name = "component2",
        force = false
    })
    
    print("Meta package components added!")
end
```

### Package Guidelines

1. **Use PushBlind.actions namespace** for all action functions
2. **Implement required actions** (`install`, `update`, `remove`)
3. **Handle errors gracefully** and provide meaningful feedback
4. **Use absolute paths** when possible to avoid directory issues
5. **Clean up temporary files** after installation
6. **Test all actions thoroughly** before publishing
7. **Document package requirements** and dependencies
8. **Provide clear user feedback** about what the package is doing

### Package File Naming

- Use descriptive filenames that match the package purpose
- Common patterns: `package_name.lua`, `main.lua`, `all.lua`
- Keep filenames simple and without spaces

### Testing Your Package

1. Create your package file in a GitHub repository
2. Add it to PushBlind: `pushblind add https://github.com/user/repo package.lua --name test_package`
3. Install it: `pushblind install test_package`
4. Test custom actions: `pushblind your_action test_package`
5. Update it: `pushblind update test_package`
6. Remove if needed: `pushblind remove test_package`

## Build Instructions

### Prerequisites

Before building, ensure you have:
- `curl` - for downloading dependencies
- `gcc` - for compiling C code
- Darwin build system (version 0.12.0)
- KeyObfuscate for generating security keys

### Build All Targets

To compile all available output formats at once:

```bash
darwin run_blueprint --target all
```

This generates the following files in the `release/` directory:
- `pushblind.deb` - Debian package
- `pushblind_extension.c` - C extension source
- `pushblindi32.exe` - Windows 32-bit executable
- `pushblind.out` - Linux binary
- `pushblind.rpm` - RPM package

### Individual Build Targets

| Target | Command | Output | Description |
|--------|---------|--------|-------------|
| `.deb` | `darwin run_blueprint --target .deb` | `release/debian_static.deb` | Debian package |
| `extension` | `darwin run_blueprint --target extension` | `release/extension.c` | C extension source |
| `linux_bin` | `darwin run_blueprint --target linux_bin` | `release/pushblind.out` | Static Linux binary |
| `local_unix_bin` | `darwin run_blueprint --target local_unix_bin` | `release/local_unix_bin.out` | Local Unix binary |
| `.rpm` | `darwin run_blueprint --target .rpm` | `release/rpm_static_build.rpm` | RPM package |
| `.exe` | `darwin run_blueprint --target .exe` | `release/ouivibei32.exe` | Windows executable |

### Manual Compilation

If you prefer to compile the extension manually:

1. Generate the extension:
```bash
darwin run_blueprint --target extension
```

2. Compile with GCC:
```bash
gcc dependencies/vibescript.c \
    -DCONTENT_ENCRYPT_KEY=\"../keys/content.h\" \
    -DLLM_ENCRYPT_KEY=\"../keys/llm.h\" \
    -DNAME_ENCRYPT_KEY=\"../keys/name.h\" \
    -DVIBE_EXTENSION_MODULE=\"../release/pushblind_extension.c\" \
    -DVIBE_EXTENSION_FUNC=pushblind \
    -DVIBE_EXTENSION_LIB_NAME=\"pushblind\" \
    -o pushblind
```

## Directory Structure

```
~/.pushblind/
├── packages/          # Downloaded package repositories
│   └── package_name/  # Individual package directories
└── names/             # Package name mappings
    └── *.txt          # Name mapping files
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---
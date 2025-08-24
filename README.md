

<div align="center">

# PushBlind
![Lua Logo](https://img.shields.io/badge/PushBlind-0.0.1-blue?style=for-the-badge&logo=lua)
[![GitHub Release](https://img.shields.io/github/release/OUIsolutions/PushBlind.svg?style=for-the-badge)](https://github.com/OUIsolutions/PushBlind/releases)
[![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)](https://github.com/OUIsolutions/PushBlind/blob/main/LICENSE)
![Status](https://img.shields.io/badge/Status-Alpha-orange?style=for-the-badge)
![Platforms](https://img.shields.io/badge/Platforms-Windows%20|%20Linux-lightgrey?style=for-the-badge)

</div>

---

## ⚠️ Important Notice

> **This is alpha software!** Use at your own risk. While we're working hard to make it stable, bugs are expected. Perfect for learning and prototyping! 🧪

---

## Overview

PushBlind is a package manager built as a [VibeScript](https://github.com/OUIsolutions/VibeScript) extension. It provides a streamlined interface for managing Git-hosted packages, allowing developers to add, install, update, and remove packages from repositories with simple commands.

**Key capabilities:**
- **Add packages from Git repositories** (GitHub, GitLab, etc.)
- **Install and manage package dependencies** 
- **Update packages to latest versions**
- **Remove packages when no longer needed**
- **Execute package actions** through a unified CLI interface

This package manager is designed for developers who need to:
- Manage project automation scripts and tools
- Download and install packages from Git repositories  
- Keep packages updated with latest versions
- Create custom package definitions for distribution
- Execute predefined actions from packages

## Key Features

- **Git Integration** - Direct package installation from any Git repository
- **Action-Based System** - Packages define actions that can be executed via CLI
- **Cross-platform Support** - Compatible with Windows and Linux systems
- **Configurable Git Commands** - Customize git clone and pull commands
- **Package Actions** - Execute package-defined actions like `build_project`, `deploy`, etc.
- **Meta Packages** - Packages that install or manage other packages

## Package Development

Want to create your own packages for PushBlind? Check the [Package Creation Guide](docs/packing.md) for detailed instructions on creating packages with install/update/remove actions and custom functionality.

---

## Releases

PushBlind can be built in multiple formats. Based on your system, choose the appropriate build:

| **Build Target** | **Command** | **Output** | **Description** |
|------------------|-------------|------------|-----------------|
| `.deb` | `darwin run_blueprint --target .deb` | `release/debian_static.deb` | Debian package |
| `extension` | `darwin run_blueprint --target extension` | `release/extension.c` | C extension source |
| `linux_bin` | `darwin run_blueprint --target linux_bin` | `release/pushblind.out` | Static Linux binary |
| `local_unix_bin` | `darwin run_blueprint --target local_unix_bin` | `release/local_unix_bin.out` | Local Unix binary |
| `.rpm` | `darwin run_blueprint --target .rpm` | `release/rpm_static_build.rpm` | RPM package |
| `.exe` | `darwin run_blueprint --target .exe` | `release/ouivibei32.exe` | Windows executable |

### Build All Targets
```bash
darwin run_blueprint --target all
```

## Installation Methods

| **Method** | **Description** |
|------------|-----------------|
| [Build from Source](docs/build_from_scrath.md) | Complete guide for building PushBlind from source code |
| Manual Compilation | Build the VibeScript extension manually using gcc |

## Documentation

| **Guide** | **Description** |
|-----------|-----------------|
| [CLI Usage](docs/cli_usage.md) | Complete command-line interface reference |
| [Package Creation](docs/packing.md) | How to create your own PushBlind packages |
| [Build from Source](docs/build_from_scrath.md) | Step-by-step source building instructions | 

## CLI Usage

### Configuration Commands

#### Set Git Commands
Configure git commands used by PushBlind:
```bash
pushblind set_git_clone "git clone"
pushblind set_git_pull "git pull"
```

### Package Management

#### Add Package
Add a package from a Git repository:
```bash
pushblind add <repository_url> <entry_file> --name <package_name>
```

Example:
```bash
pushblind add https://github.com/OUIsolutions/public_oui_packages.git all.lua --name public_oui
```

#### Install Package
Install a package:
```bash
pushblind install <package_name>
```

#### Update Package
Update a package to the latest version:
```bash
pushblind update <package_name>
```

#### Remove Package
Remove a package:
```bash
pushblind remove <package_name>
```

#### Execute Package Actions
Execute actions defined by packages:
```bash
pushblind <action_name> <package_name>
```

Example:
```bash
pushblind build_project my_package
```

## Package Creation

PushBlind packages are Lua files that define actions for automation tasks. Each package must implement three core actions:

### Required Actions

```lua
-- Required: Install the package
function PushBlind.actions.install()
    print("Installing package...")
    -- Installation logic here
    return true
end

-- Required: Update the package  
function PushBlind.actions.update()
    print("Updating package...")
    -- Update logic here
    return true
end

-- Required: Remove the package
function PushBlind.actions.remove()
    print("Removing package...")
    -- Cleanup logic here
    return true
end
```

### Custom Actions

Add any number of custom actions:

```lua
-- Custom action example
function PushBlind.actions.build_project()
    print("Building project...")
    -- Build logic here
    return true
end

function PushBlind.actions.deploy()
    print("Deploying application...")
    -- Deployment logic here
    return true
end
```

### Meta Packages

Meta packages can install other packages:

```lua
function PushBlind.actions.update()
    PushBlind.add_package({
        repo = PushBlind.same, -- Current repository
        filename = "component1.lua",
        name = "component1",
        force = false
    })
    return true
end
```

For detailed package creation instructions, see the [Package Creation Guide](docs/packing.md).

## Build Instructions

### Prerequisites

Before building, ensure you have:
- `curl` - for downloading dependencies
- `gcc` - for compiling C code  
- `sudo` privileges - for installing system-wide tools

### Install Required Tools

#### 1. Install Darwin Build System (version 0.12.0)

**Linux:**
```bash
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.12.0/darwin_linux_bin.out -o darwin.out
chmod +x darwin.out
sudo mv darwin.out /usr/local/bin/darwin
```

**macOS:**
```bash
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.12.0/darwin.c -o darwin.c
gcc darwin.c -o darwin.out
sudo mv darwin.out /usr/local/bin/darwin
rm darwin.c
```

#### 2. Install KeyObfuscate

**Linux:**
```bash
curl -L https://github.com/OUIsolutions/key_obfuscate/releases/download/0.0.1/KeyObfuscate.out -o KeyObfuscate
sudo chmod +x KeyObfuscate
sudo mv KeyObfuscate /bin/KeyObfuscate
```

#### 3. Generate Security Keys

```bash
mkdir -p keys
KeyObfuscate --entry 'your-content-password' --project_name 'content' --output 'keys/content.h'
KeyObfuscate --entry 'your-llm-password' --project_name 'llm' --output 'keys/llm.h'
KeyObfuscate --entry 'your-name-password' --project_name 'name' --output 'keys/name.h'
```

### Build Commands

#### Build All Targets
```bash
darwin run_blueprint --target all
```

#### Manual Compilation
```bash
# Generate extension
darwin run_blueprint --target extension

# Compile with GCC
gcc dependencies/vibescript.c \
    -DCONTENT_ENCRYPT_KEY=\"../keys/content.h\" \
    -DLLM_ENCRYPT_KEY=\"../keys/llm.h\" \
    -DNAME_ENCRYPT_KEY=\"../keys/name.h\" \
    -DVIBE_EXTENSION_MODULE=\"../release/pushblind_extension.c\" \
    -DVIBE_EXTENSION_FUNC=pushblind \
    -DVIBE_EXTENSION_LIB_NAME=\"pushblind\" \
    -o pushblind
```

For complete build instructions, see [Build from Source](docs/build_from_scrath.md).

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---
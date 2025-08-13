

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

### Overview

PushBlind is a lightweight package manager for Lua-based applications. It provides a streamlined interface for managing GitHub-hosted packages, eliminating the complexity of traditional dependency management:

1. **Add packages from GitHub repositories** 
2. **Install and manage package dependencies**
3. **Update packages to latest versions**
4. **Remove packages when no longer needed**

This package manager is designed for developers who need to:
- Manage Lua packages and dependencies
- Download and install packages from GitHub repositories
- Keep packages updated with latest versions
- Organize and maintain project dependencies
- Create custom package definitions for distribution

### Key Features

- **GitHub Integration** - Direct package installation from GitHub repositories
- **Version Control** - Git-based package management with automatic updates
- **Custom Package Creation** - Create your own package definitions with install/update scripts
- **Cross-platform Support** - Compatible with Windows and Linux systems
- **Minimal Configuration** - Simple setup with SSH or HTTPS Git modes
- **Package Isolation** - Each package is managed independently in separate directories

### Package Development

Want to create your own packages for PushBlind? Check the `package_sample/` directory for examples showing how to create package definitions with install and update functions.

---

## Releases

|  **File**                                                                                                           | **What is**                                |
|---------------------------------------------------------------------------------------------------------------------|--------------------------------------------|
|[pushblind.out](https://github.com/OUIsolutions/PushBlind/releases/download/0.0.1/pushblind.out)                   | Linux Static Binary                        |
|[pushblind64.exe](https://github.com/OUIsolutions/PushBlind/releases/download/0.0.1/pushblind64.exe)               | Windows 64-bit Binary                      |
|[pushblinди32.exe](https://github.com/OUIsolutions/PushBlind/releases/download/0.0.1/pushblinди32.exe)             | Windows 32-bit Binary                      |
|[pushblind.deb](https://github.com/OUIsolutions/PushBlind/releases/download/0.0.1/pushblind.deb)                   | Debian Package                             |
|[pushblind.rpm](https://github.com/OUIsolutions/PushBlind/releases/download/0.0.1/pushblind.rpm)                   | RPM Package                                |
|[extension.c](https://github.com/OUIsolutions/PushBlind/releases/download/0.0.1/extension.c)                       | VibeScript Extension Source                |

## Installation Tutorials

| **Method**                                                      | **Description**                                       |
|----------------------------------------------------------------|-------------------------------------------------------|
| [Binary Installation](docs/instalations/binary.md)            | Direct binary installation (the easiest)             |
| [Package Installation](docs/instalations/package.md)          | System package installation (.deb/.rpm)              |
| [VibeScript Extension](docs/instalations/extension.md)        | Install as VibeScript extension                       |
| [Build from Source](docs/instalations/build_from_source.md)   | Building PushBlind from source code                  |

## [CLI Commands Reference](docs/cli_reference.md)
Click here [CLI Commands Reference](docs/cli_reference.md) to see the complete list of available commands.

## Usage Tutorials 

| **Tutorial**                                                    | **Description**                                         |
|-----------------------------------------------------------------|---------------------------------------------------------|
| [Getting Started](docs/tutorials/getting_started.md)           | Basic setup and first package installation             |
| [Git Configuration](docs/tutorials/git_configuration.md)       | Setting up SSH or HTTPS mode for Git operations        |
| [Package Management](docs/tutorials/package_management.md)     | Adding, installing, updating and removing packages     |
| [Creating Packages](docs/tutorials/creating_packages.md)       | How to create your own PushBlind packages              |
| [Package Structure](docs/tutorials/package_structure.md)       | Understanding package file structure and conventions   |
| [Advanced Usage](docs/tutorials/advanced_usage.md)             | Advanced features and customization options            |

## CLI Usage

### Basic Commands

#### Set Git Mode
Configure whether to use HTTPS or SSH for Git operations:
```bash
pushblind set_git_mode https
# or
pushblind set_git_mode ssh
```

#### Add Package
Add a package from a GitHub repository:
```bash
pushblind add OUIsolutions/ouivibe ouivibe.lua --name ouivibe
pushblind add user/repository package_file.lua --name my_package
```

#### List Packages
List all installed packages:
```bash
pushblind list
```

#### Install Package
Install or reinstall a package:
```bash
pushblind install ouivibe
pushblind install my_package
```

#### Update Package
Update a package to the latest version:
```bash
pushblind update ouivibe
pushblind update my_package
```

#### Remove Package
Remove a package and its files:
```bash
pushblind remove ouivibe
pushblind remove my_package
```

#### Force Operations
Use `--force` flag to overwrite existing packages:
```bash
pushblind add OUIsolutions/ouivibe ouivibe.lua --name ouivibe --force
```

## Package Creation Guide

### Basic Package Structure

Create a Lua file with `install` and `update` functions:

```lua
function install(running_file)
    -- Installation logic here
    print("Installing package...")
    
    -- Example: Download and install a binary
    os.execute("curl -L https://example.com/binary -o binary")
    os.execute("sudo chmod +x binary")
    os.execute("sudo mv binary /usr/bin/")
    
    return true  -- Return true on success, false on failure
end

function update(running_file)
    -- Update logic here
    print("Updating package...")
    
    -- Example: Re-download latest version
    os.execute("curl -L https://example.com/latest/binary -o binary")
    os.execute("sudo chmod +x binary")
    os.execute("sudo mv binary /usr/bin/")
    
    return true  -- Return true on success, false on failure
end
```

### Package Examples

#### Simple Binary Installation
```lua
function install(running_file)
    -- Download and install a binary tool
    dtw.remove_any("mytool.out")
    os.execute('gh release download --repo user/mytool --pattern "mytool.out"')
    os.execute("sudo chmod +x mytool.out")
    os.execute("sudo mv mytool.out /usr/bin/mytool")
    return true
end

function update(running_file)
    -- Update to latest version
    dtw.remove_any("mytool.out")
    os.execute('gh release download --repo user/mytool --pattern "mytool.out"')
    os.execute("sudo chmod +x mytool.out")
    os.execute("sudo mv mytool.out /usr/bin/mytool")
    return true
end
```

#### Chrome Automation Tools Installation
```lua
function install()
    -- Remove existing installation
    dtw.remove_any(os.getenv("HOME") .. "/oui_chrome")
    
    -- Download Chrome and ChromeDriver
    os.execute("curl -L https://storage.googleapis.com/chrome-for-testing-public/138.0.7204.94/linux64/chromedriver-linux64.zip -o chromedriver.zip")
    os.execute("mkdir -p ~/oui_chrome")
    os.execute("curl -L https://storage.googleapis.com/chrome-for-testing-public/138.0.7204.94/linux64/chrome-linux64.zip -o chrome-linux64.zip")
    os.execute("unzip chromedriver.zip -d ~/oui_chrome && unzip chrome-linux64.zip -d ~/oui_chrome")
    os.execute("rm *.zip")
    
    return true
end

function update()
    -- This package doesn't support updates
    return false
end
```

#### Meta Package (Installing Multiple Packages)
```lua
function install(running_file)
    print("Meta package cannot be directly installed")
    return false 
end

function update(running_file)
    -- Add multiple related packages
    PushBlind.add_package({
        package_name = "OUIsolutions/private_oui_packages",
        filename = "ouivibe.lua",
        name = "ouivibe",
        force = false
    })
    PushBlind.add_package({
        package_name = "OUIsolutions/private_oui_packages",
        filename = "chrome_automations.lua",
        name = "chrome_automations",
        force = false
    })
    return true 
end
```

### Package Guidelines

1. **Always return boolean values** from `install` and `update` functions
2. **Handle errors gracefully** and provide meaningful feedback
3. **Use absolute paths** when possible to avoid directory issues
4. **Clean up temporary files** after installation
5. **Test both install and update functions** thoroughly
6. **Document package requirements** and dependencies
7. **Use version-specific downloads** when available

### Package File Naming

- Use descriptive filenames that match the package purpose
- Common patterns: `package_name.lua`, `tool_installer.lua`
- Keep filenames simple and without spaces

### Testing Your Package

1. Create your package file in a GitHub repository
2. Add it to PushBlind: `pushblind add user/repo package.lua --name test_package`
3. Install it: `pushblind install test_package`
4. Test the functionality
5. Update it: `pushblind update test_package`
6. Remove if needed: `pushblind remove test_package`

## Build Instructions

### Build All Platforms
```bash
darwin run_blueprint build/ --mode folder extension_build alpine_static_build windowsi32_build windows64_build rpm_static_build debian_static_build --contanizer podman
```

### Local Linux Build
```bash
darwin run_blueprint build/ --mode folder local_linux_build
```

## Directory Structure

```
~/.pushblind/
├── packages/          # Downloaded package repositories
│   └── user_repo/     # Individual package directories
└── names/             # Package name mappings
    └── *.txt          # Name hash files
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---
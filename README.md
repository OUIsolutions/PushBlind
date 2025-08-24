

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


## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---
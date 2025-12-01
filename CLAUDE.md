# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

PushBlind is a package manager for Lua-based automation scripts and development tools. It provides GitHub integration for managing packages that define automated actions for software development tasks. The project is built using VibeScript (a Lua-based runtime) and compiles to multiple target platforms.

## Build System

PushBlind uses **Darwin** build system (version 0.12.0) for compilation and packaging.

### Build Commands

Build all targets:
```bash
darwin run_blueprint --target all
```

Individual build targets:
```bash
darwin run_blueprint --target extension      # Generate C extension source
darwin run_blueprint --target linux_bin      # Static Linux binary
darwin run_blueprint --target .deb          # Debian package
darwin run_blueprint --target .rpm          # RPM package
darwin run_blueprint --target .exe          # Windows 32-bit executable
darwin run_blueprint --target local_unix_bin # Local Unix binary
```

### Build Dependencies

- `curl` - downloading dependencies
- `gcc` or `g++` - C/C++ compilation
- Darwin build system (0.12.0)
- KeyObfuscate - security key generation
- Docker or Podman (configurable via `--contanizer` flag)

## Architecture

### Core Components

**src/main.lua** - Entry point and CLI dispatcher
- Handles command-line argument parsing via `argv` API
- Routes actions to appropriate handlers
- Implements git configuration commands (`set_git_clone`, `set_git_pull`)
- Manages property storage (`set_prop`, `get_prop`)
- Supports `.pushblind` file for setting current package context

**src/api.lua** - Package management API
- `PushBlind.add_package()` - Clones repositories and registers packages
- `PushBlind.run_action()` - Executes package-defined actions
- `PushBlind.list_packages()` - Lists installed packages
- `PushBlind.remove_package()` - Uninstalls packages and cleans up repos
- Uses SHA-based directory naming for package/repo isolation

**src/cli_actions.lua** - CLI action implementations
- Wraps API functions with CLI-friendly error handling
- Provides colored terminal output via `private_vibescript` color codes
- Handles command-line flags (`--name`, `--force`)

### Package System

Packages are Lua scripts that define actions using the `PushBlind.actions` namespace:

```lua
function PushBlind.actions.install()
    -- Installation logic
end

function PushBlind.actions.update()
    -- Update logic
end

function PushBlind.actions.remove()
    -- Cleanup logic
end

function PushBlind.actions.custom_action()
    -- Custom action logic
end
```

**Special Variables:**
- `PushBlind.same` - Reference to current repository (for meta-packages)
- `PushBlind.repo_dir` - Current package's repository directory
- `script_dir_name` - Directory containing the package script

### Storage Structure

```
~/.pushblind/
├── repos/                    # Git repositories (SHA-named)
│   └── {sha_hash}/          # One repo per unique GitHub URL
└── packages/                # Package metadata (SHA-named)
    └── {sha_hash}/
        ├── name.txt         # Package name
        ├── repo.txt         # Repository SHA reference
        └── filename.txt     # Entry script filename
```

### Build Configuration

**darwinconf.lua** - Build metadata and project configuration
- Defines project name, version, license, and description
- Configurable containerization tool (Docker/Podman via `--contanizer` flag)
- Loads all build recipes from `builds/` directory

**builds/** - Darwin build recipes
- Each `.lua` file defines a build target recipe
- `extension_build.lua` - Generates C extension by bundling all `src/*.lua` files
- `linux_bin.lua` - Uses Alpine Linux container for static compilation
- Build recipes use `darwin.add_recipe()` with dependencies and outputs

### Compilation Process

1. Extension build collects all `src/*.lua` files
2. Darwin generates C extension (`pushblind_extension.c`)
3. Target-specific builds compile VibeScript with the extension
4. Compilation flags inject encryption keys for content, LLM, and name obfuscation
5. Final binaries are output to `release/` directory

### VibeScript Integration

PushBlind is built as a VibeScript extension:
- Compiled with `dependencies/vibescript.c`
- Uses encryption keys from `keys/` directory (content.h, llm.h, name.h)
- Extension entry point: `vibescript_extension_main()`
- Provides `dtw` filesystem API and `argv` argument parsing

## CLI Usage

Basic package operations:
```bash
pushblind add <repo_url> <entry_file> --name <package_name> [--force]
pushblind install <package_name>
pushblind update <package_name>
pushblind remove <package_name>
pushblind list
pushblind <action_name> <package_name>
```

Git configuration:
```bash
pushblind set_git_clone "git clone"
pushblind set_git_pull "git pull"
```

Property management:
```bash
pushblind set_prop <key> <value>
pushblind get_prop <key>
```

Version info:
```bash
pushblind version
pushblind --version
pushblind -v
```

Current package context (using `.pushblind` file):
```bash
pushblind <action> current
```

## Development Notes

- The project uses SHA hashing (`dtw.generate_sha()`) to create unique identifiers for packages and repositories
- Repositories are shared across packages from the same GitHub URL
- When removing a package, the repository is only deleted if no other packages reference it
- Package actions receive `script_dir_name` as first argument for path resolution
- Git commands are configurable to support custom git installations or wrappers
- The build system supports cross-platform compilation through containerization

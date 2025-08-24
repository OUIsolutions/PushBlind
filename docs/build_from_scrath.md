# Building PushBlind from Source

This guide will walk you through the complete process of building PushBlind from source code. Follow these steps in order to successfully compile and package the application.

## Prerequisites

Before starting, ensure you have the following tools installed on your system:
- `curl` - for downloading dependencies
- `gcc` - for compiling C code
- `sudo` privileges - for installing system-wide tools

## Installation Steps

### 1. Install Darwin Build System

Darwin is the build system used to compile PushBlind. You need version 0.12.0 specifically.

#### Linux Installation
```bash
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.12.0/darwin_linux_bin.out -o darwin.out
chmod +x darwin.out
sudo mv darwin.out /usr/local/bin/darwin
```

#### macOS Installation
```bash
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.12.0/darwin.c -o darwin.c
gcc darwin.c -o darwin.out
sudo mv darwin.out /usr/local/bin/darwin
rm darwin.c
```

### 2. Install KeyObfuscate

KeyObfuscate generates encrypted security keys that protect your application's sensitive data.

#### Linux Installation
```bash
curl -L https://github.com/OUIsolutions/key_obfuscate/releases/download/0.0.1/KeyObfuscate.out -o KeyObfuscate
sudo chmod +x KeyObfuscate
sudo mv KeyObfuscate /bin/KeyObfuscate
```

### 3. Generate Security Keys

Create the required encryption keys for your build. Replace the example passwords with your own secure strings.

```bash
# Create the keys directory
mkdir -p keys

# Generate three security keys with your custom passwords
KeyObfuscate --entry 'your-content-password' --project_name 'content' --output 'keys/content.h'
KeyObfuscate --entry 'your-llm-password' --project_name 'llm' --output 'keys/llm.h'
KeyObfuscate --entry 'your-name-password' --project_name 'name' --output 'keys/name.h'
```

**Important:** Store these passwords securely. You will need them to decrypt the application data later.

## Building the Project

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

### Available Build Targets

To see all available build options:

```bash
darwin list_blueprints
```

#### Individual Build Targets

| Target | Command | Output | Description |
|--------|---------|--------|-------------|
| `.deb` | `darwin run_blueprint --target .deb` | `release/debian_static.deb` | Debian package |
| `extension` | `darwin run_blueprint --target extension` | `release/extension.c` | C extension source |
| `linux_bin` | `darwin run_blueprint --target linux_bin` | `release/pushblind.out` | Static Linux binary |
| `local_unix_bin` | `darwin run_blueprint --target local_unix_bin` | `release/local_unix_bin.out` | Local Unix binary |
| `.rpm` | `darwin run_blueprint --target .rpm` | `release/rpm_static_build.rpm` | RPM package |
| `.exe` | `darwin run_blueprint --target .exe` | `release/ouivibei32.exe` | Windows executable |

## Manual Compilation

If you prefer to compile the extension manually:

### 1. Generate the Extension
```bash
darwin run_blueprint --target extension
```

### 2. Compile with GCC
PushBlind is a [VibeScript](https://github.com/OUIsolutions/VibeScript) extension. Compile it using:

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

## Troubleshooting

- **Permission denied errors**: Ensure you have `sudo` privileges and the commands are run with appropriate permissions
- **Missing dependencies**: Verify that `curl`, `gcc`, and other required tools are installed
- **Build failures**: Check that all security keys are properly generated before building
- **Path issues**: Ensure you're running commands from the project root directory

For more information, visit the [Darwin](https://github.com/OUIsolutions/Darwin) and [KeyObfuscate](https://github.com/OUIsolutions/key_obfuscate) repositories.

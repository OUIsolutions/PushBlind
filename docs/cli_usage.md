
# PushBlind CLI Usage Guide

This guide covers all the command-line operations available in PushBlind. Each command is explained with examples and use cases to help you get started quickly.

## Basic Command Structure

All PushBlind commands follow this general pattern:
```bash
pushblind <command> [arguments] [options]
```

## Configuration Commands

### Setting Git Commands

PushBlind uses git internally to manage packages. You can customize which git commands it uses, though this is optional as sensible defaults are provided.

#### Configure Git Clone Command
```bash
pushblind set_git_clone "git clone"
```
This sets the command used to clone repositories. The default value is "git clone", but you might want to change it if you need specific git options or use a git wrapper.

**Example with custom options:**
```bash
pushblind set_git_clone "git clone --depth 1"
```

#### Configure Git Pull Command
```bash
pushblind set_git_pull "git pull"
```
This sets the command used to update existing repositories. The default is "git pull".

**Example with custom options:**
```bash
pushblind set_git_pull "git pull --rebase"
```

## Package Management

### Adding Packages

The `add` command registers a new package repository with PushBlind. This downloads the repository and makes its actions available for use.

#### Basic Syntax
```bash
pushblind add <repository_url> <entry_file> --name <package_name>
```

#### Parameters Explained
- `<repository_url>`: The git repository URL containing the package
- `<entry_file>`: The main Lua file that defines the package's actions
- `--name <package_name>`: A local name for the package (used in other commands)

#### Example
```bash
pushblind add https://github.com/OUIsolutions/public_oui_packages.git all.lua --name public_oui
```

This command:
1. Clones the repository from GitHub
2. Registers it with the local name "public_oui"
3. Uses "all.lua" as the main entry point
4. Makes all actions defined in that file available

### Updating Packages

When package repositories are updated, you can pull the latest changes using the `update` command.

#### Syntax
```bash
pushblind update <package_name>
```

#### Example
```bash
pushblind update public_oui
```

This pulls the latest changes from the "public_oui" package repository.

### Installing Packages

The `install` command sets up a package for use. This may involve downloading dependencies or performing setup operations defined by the package.

#### Syntax
```bash
pushblind install <package_name>
```

#### Example
```bash
pushblind install public_oui
```

### Removing Packages

To remove a package from your system, use the `remove` command. This will delete the package files and unregister it from PushBlind.

#### Syntax
```bash
pushblind remove <package_name>
```

#### Example
```bash
pushblind remove public_oui
```

**Warning:** This will permanently delete the package. You'll need to add it again if you want to use it later.

## Executing Package Actions

Once you have packages installed, you can execute their actions using this syntax:

#### Syntax
```bash
pushblind <action_name> <package_name>
```

#### Parameters
- `<action_name>`: The name of the action you want to execute
- `<package_name>`: The name of the package containing the action

#### Example
```bash
pushblind build_project public_oui
```

This executes the "build_project" action from the "public_oui" package.

## Common Workflow

Here's a typical workflow when working with PushBlind:

1. **Add a package:**
   ```bash
   pushblind add https://github.com/example/my-package.git main.lua --name my_package
   ```

2. **Install the package:**
   ```bash
   pushblind install my_package
   ```

3. **Use package actions:**
   ```bash
   pushblind some_action my_package
   ```

4. **Update when needed:**
   ```bash
   pushblind update my_package
   ```

5. **Remove if no longer needed:**
   ```bash
   pushblind remove my_package
   ```

## Tips and Best Practices

- **Package Names:** Choose descriptive names for your packages to avoid confusion
- **Regular Updates:** Run `update` periodically to get the latest package improvements
- **Action Discovery:** Check package documentation to learn what actions are available
- **Git Configuration:** Only modify git commands if you have specific requirements

## Getting Help

Most commands will provide error messages if used incorrectly. Make sure your package names match exactly what you used when adding them, as PushBlind is case-sensitive.

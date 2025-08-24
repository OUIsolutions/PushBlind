# PushBlind Package Creation Guide

This guide will walk you through creating your own PushBlind packages from scratch. Whether you're new to package management or PushBlind specifically, this guide provides step-by-step instructions to help you build and distribute your own automation packages.

## What is a PushBlind Package?

A PushBlind package is a collection of Lua scripts that define automated actions for software development tasks. Packages can handle everything from building projects to deploying applications, managing dependencies, or running custom workflows.

Each package contains one or more action functions that users can execute through the PushBlind command-line interface.

## Prerequisites

Before creating your first package, make sure you have:

- A GitHub account (or access to another Git hosting service)
- Basic knowledge of Lua programming
- PushBlind installed on your system
- Git installed and configured with your credentials

## Creating Your First Package

### Step 1: Set Up Your Repository

First, you need to create a new repository to host your package:

1. Go to GitHub and create a new repository
2. Choose a descriptive name for your package (e.g., "my-build-tools", "project-deployer")
3. Initialize it with a README file
4. Clone the repository to your local machine:

```bash
git clone https://github.com/your_username/your_repo_name.git
cd your_repo_name
```

### Step 2: Create Your Package File

Create a Lua file that will serve as your package's entry point. The filename should be descriptive and end with `.lua`. For example, if your package is called "build-tools", create `build_tools.lua`.

```bash
touch my_package.lua
```

### Step 3: Define Package Actions

Open your package file and define the actions your package will provide. Every PushBlind package should implement these three core actions:

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
```

### Step 4: Add Custom Actions

Beyond the required actions, you can add any number of custom actions specific to your package's purpose:

```lua
-- Custom action example: Build a project
function PushBlind.actions.build_project()
    print("Building project...")
    -- Add build logic here
    -- This might include:
    -- - Compiling source code
    -- - Running build scripts
    -- - Generating output files
    
    print("Project built successfully!")
end

-- Custom action example: Run tests
function PushBlind.actions.run_tests()
    print("Running tests...")
    -- Add test logic here
    -- This might include:
    -- - Executing test suites
    -- - Generating test reports
    -- - Checking code coverage
    
    print("Tests completed!")
end

-- Custom action example: Deploy application
function PushBlind.actions.deploy()
    print("Deploying application...")
    -- Add deployment logic here
    -- This might include:
    -- - Uploading files to servers
    -- - Updating database schemas
    -- - Restarting services
    
    print("Application deployed successfully!")
end
```

### Step 5: Test Your Package Locally

Before publishing, test your package locally:

1. Commit and push your changes to GitHub:

```bash
git add .
git commit -m "Initial package implementation"
git push origin main
```

2. Add your package to PushBlind using HTTPS:

```bash
pushblind add https://github.com/your_username/your_repo_name.git my_package.lua --name my_package
```

Or using SSH if you have SSH keys configured:

```bash
pushblind add git@github.com:your_username/your_repo_name.git my_package.lua --name my_package
```

3. Test the installation:

```bash
pushblind install my_package
```

4. Test your custom actions:

```bash
pushblind build_project my_package
pushblind run_tests my_package
```

## Advanced Package Features

### Adding Dependencies and Utilities

Your package can include utility functions and external dependencies:

```lua
-- Utility function example
local function check_file_exists(filepath)
    local file = io.open(filepath, "r")
    if file then
        file:close()
        return true
    end
    return false
end

-- Using utilities in actions
function PushBlind.actions.setup_environment()
    if not check_file_exists("config.json") then
        print("Creating default configuration...")
        -- Create config file logic here
    end
    
    print("Environment setup complete!")
end
```

### Working with External Commands

You can execute system commands from within your package actions:

```lua
function PushBlind.actions.install_dependencies()
    print("Installing Node.js dependencies...")
    
    -- Execute npm install
    local result = os.execute("npm install")
    if result == 0 then
        print("Dependencies installed successfully!")
    else
        print("Error installing dependencies!")
        return false
    end
    
    return true
end
```

### Creating Meta Packages

Meta packages are packages that install or manage other packages. This is useful for creating package collections or complex installation workflows:

```lua
function PushBlind.actions.install()
    print("Installing meta package with multiple components...")
    
    -- Install a package from the same repository
    PushBlind.add_package({
        repo = PushBlind.same, -- Refers to the current repository
        filename = "component1.lua",
        name = "component1",
        force = false -- Don't re-clone if already exists
    })
    
    -- Install another component
    PushBlind.add_package({
        repo = PushBlind.same,
        filename = "component2.lua", 
        name = "component2",
        force = false
    })
    
    print("Meta package installation complete!")
    return true
end

function PushBlind.actions.update()
    print("Updating all components...")
    
    -- Update individual components
    PushBlind.add_package({
        repo = PushBlind.same,
        filename = "component1.lua",
        name = "component1", 
        force = false
    })
    
    PushBlind.add_package({
        repo = PushBlind.same,
        filename = "component2.lua",
        name = "component2",
        force = false
    })
    
    return true
end
```

## Best Practices

### Code Organization

- Keep your main package file focused on action definitions
- Create separate files for complex logic and include them as needed
- Use descriptive function names that clearly indicate their purpose
- Add comments to explain complex operations

### Error Handling

Always include proper error handling in your actions:

```lua
function PushBlind.actions.build_project()
    print("Starting build process...")
    
    -- Check if required files exist
    if not check_file_exists("src/main.lua") then
        print("Error: main.lua not found in src/ directory")
        return false
    end
    
    -- Execute build command
    local result = os.execute("lua build.lua")
    if result ~= 0 then
        print("Error: Build process failed")
        return false
    end
    
    print("Build completed successfully!")
    return true
end
```

### User Feedback

Provide clear feedback to users about what your package is doing:

```lua
function PushBlind.actions.install()
    print("Installing development environment...")
    print("Step 1/3: Creating project structure...")
    -- Create directories
    
    print("Step 2/3: Installing dependencies...")
    -- Install deps
    
    print("Step 3/3: Setting up configuration...")
    -- Setup config
    
    print("Installation complete! You can now run 'pushblind build_project my_package'")
end
```

### Version Management

Consider adding version information to your packages:

```lua
PushBlind.package_info = {
    name = "My Development Tools",
    version = "1.0.0",
    description = "A collection of tools for project development",
    author = "Your Name"
}

function PushBlind.actions.version()
    print("Package: " .. PushBlind.package_info.name)
    print("Version: " .. PushBlind.package_info.version)
    print("Description: " .. PushBlind.package_info.description)
end
```

## Publishing and Sharing

Once your package is ready:

1. Make sure all code is committed and pushed to your repository
2. Add a README.md file explaining what your package does and how to use it
3. Tag releases in your repository for version management
4. Share your package repository URL with other users

Users can then install your package using:

```bash
pushblind add https://github.com/your_username/your_repo_name.git your_package.lua --name package_name
```

## Troubleshooting Common Issues

### Package Not Found
- Ensure your repository URL is correct and accessible
- Check that the filename matches exactly (case-sensitive)
- Verify the file exists in the repository root

### Action Not Working
- Check for syntax errors in your Lua code
- Ensure function names start with `PushBlind.actions.`
- Test individual commands outside of PushBlind first

### Permission Issues
- Some actions may require elevated permissions
- Document any special requirements in your package README

This guide should give you a solid foundation for creating effective PushBlind packages. Start with simple actions and gradually add more complexity as you become more comfortable with the system. 


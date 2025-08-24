
### Configure git ommands
these commands are optional ,and they configure git commands
these values are the default
```bash
pushblind set_git_clone "git clone" 
```
```bash
pushblind set_git_pull "git pull"
```

### Add Packages
thes command add a pakage 
```bash
pushblind add https://github.com/OUIsolutions/public_oui_packages.git  all.lua  --name public_oui
```
### Update 
```bash
pushblind update public_oui
```

### Install a pakage
```bash
pushblind install your_package_name
```

### Remove a pakage
```bash
pushblind remove your_package_name
```

### Calling any action
```bash
pushblind  your_action_name your_package_name
```


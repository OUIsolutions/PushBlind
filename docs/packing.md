### Creating a basic Package
to create a package , first create a github repo 
then create a file with the name of your package, example "my_program.lua" 

in these file,write:
```lua
function PushBlind.actions.install()
--do stuff
    print("package installed")
end
function PushBlind.actions.update()
  --do stuff
  print("package updated")
end
function PushBlind.actions.remove()
  --do stuff
  print("package removed")
end

``` 

then add your package with (in case of https):
```bash
pushblind add https://github.com/your_username/your_repo.git  your_program.lua  --name package_name
```

or in case of ssh:
```bash
pushblind add git@github.com:your_username/your_repo.git  your_program.lua  --name package_name
``` 

### Adding a package inside a package
you can create a "meta" package and add a same repo package 

```lua
function PushBlind.actions.update()
    PushBlind.add_package({
        repo = PushBlind.same, -- vibescript.lua must be in the same repo of the meta package
        filename = "vibescript.lua",
        name = "vibescript",
        force=false -- to not recolone the repo
    })
    return true
end

``` 


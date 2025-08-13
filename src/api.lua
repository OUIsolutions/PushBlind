PushBlind = {}

function PushBlind.add_package(props)
    local home = os.getenv("HOME")
    local formated_package_name = props.package_name:gsub("/", "_")
    local packages_dir = home.."/.pushblind/packages/"..formated_package_name
    local possible_git_dir = dtw.list_dirs(packages_dir,true)[1]

    if possible_git_dir then
        if not props.force then
            return "already_exists"
        end
    end
    dtw.remove_any(packages_dir)
    os.execute("mkdir -p "..packages_dir)

    os.execute("cd "..packages_dir.." && git clone https://github.com/"..props.package_name..".git")
    
    local package_git = dtw.list_dirs(packages_dir,true)[1]
    if not package_git then
        return "not_exist"
    end
    local names_dir = home.."/.pushblind/names/"
    local name_sha = dtw.generate_sha(props.name)
    dtw.write_file(names_dir..name_sha..".txt",props.name)
    set_prop("pushblind.package_dir."..props.name,packages_dir)
    set_prop("pushblind.git_dir."..props.name,package_git)
    set_prop("pushblind.package_file."..props.name,props.filename)
    return "cloned"
end
function PushBlind.list_packages()
    
    local home = os.getenv("HOME")
    local packages_dir = home.."/.pushblind/packages/"
    local packages_dirs = dtw.list_dirs(packages_dir,true)
    local all = {}
    for i =1,#packages_dirs do
        local current_file = packages_dirs[i]        
        local content = dtw.load_file(current_file)
        if content then
            all[#all+1] = content
        end
    end
    return all    
end
function PushBlind.install_package(name)
    PushBlind.running_dir = get_prop("pushblind.git_dir."..name)
    print("running_dir ",PushBlind.running_dir)
    if not PushBlind.running_dir then        
        return false
    end
   
    local filename  = get_prop("pushblind.package_file."..name)
    if not filename then 
        return false 
    end 
    PushBlind.running_file = PushBlind.running_dir..filename

     if not dtw.isfile(PushBlind.running_file) then
        return false
    end

    dofile(PushBlind.running_file)
    os.execute("cd "..PushBlind.running_dir.." && git pull")
    local result = install(PushBlind.running_file)    
    os.execute("cd "..PushBlind.running_dir.." && git reset --hard HEAD")
    return result   
end
function PushBlind.update_package(name)
    PushBlind.running_dir = get_prop("pushblind.git_dir."..name)
    if not PushBlind.running_dir then        
        return false
    end
   
    local filename  = get_prop("pushblind.package_file."..name)
    if not filename then 
        return false 
    end 
    PushBlind.running_file = PushBlind.running_dir..filename

     if not dtw.isfile(PushBlind.running_file) then
        return false
    end

    dofile(PushBlind.running_file)
    os.execute("cd "..PushBlind.running_dir.." && git pull")
    local result = update(PushBlind.running_file)    
    os.execute("cd "..PushBlind.running_dir.." && git reset --hard HEAD")
    return result   
end

function  PushBlind.remove_package(name)
    local home = os.getenv("HOME")
    local name_path = home.."/.pushblind/names/"
    local name_sha = dtw.generate_sha(name)
    local name_file = name_path..name_sha..".txt"
    print("Removing name file: ",name_file)
    local package_dir = get_prop("pushblind.package_dir."..name)
    if not package_dir then
        return "not_exist"
    end
    if not dtw.isdir(package_dir) then
        return "not_exist"
    end
    dtw.remove_any(package_dir)
    return "removed"
end
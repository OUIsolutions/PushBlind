PushBlind = {}

function PushBlind.add_package(props)
    local home = os.getenv("HOME")
    local formated_package_name = props.package_name:gsub("/", "_")
    local packages_dir = home.."/.pushblind/packages/"..formated_package_name
    local possible_git_dir = dtw.list_dirs(packages_dir,true)[1]

    if possible_git_dir then

        local names_dir = home.."/.pushblind/names/"
        local name_sha = dtw.generate_sha(props.name)
        dtw.write_file(names_dir..name_sha..".txt",props.name)
        set_prop("pushblind.package_dir."..props.name,packages_dir)
        set_prop("pushblind.git_dir."..props.name,possible_git_dir)
        set_prop("pushblind.package_file."..props.name,props.filename)
        if not props.force then
            return "already_exists"
        end
    end
    dtw.remove_any(packages_dir)
    os.execute("mkdir -p "..packages_dir)
    local git_mode = get_prop("pushblind.git_mode")
    if git_mode == "https" then  
        os.execute("cd "..packages_dir.." && git clone https://github.com/"..props.package_name..".git")
    end 
    if git_mode == "ssh" then  
        os.execute("cd "..packages_dir.." && git clone git@github.com:"..props.package_name..".git")
    end
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
    local names_dir = home.."/.pushblind/names/"
    local names_files = dtw.list_files(names_dir,true)
    local all = {}
    for i =1,#names_files do
        local current_file = names_files[i]      
        local content = dtw.load_file(current_file)
        if content then
            all[#all+1] = content
        end
    end
    return all    
end
function PushBlind.install_package(name)
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

function PushBlind.remove_package(name)
    local home = os.getenv("HOME")
    local name_path = home .. "/.pushblind/names/"
    local name_sha = dtw.generate_sha(name)
    local name_file = name_path .. name_sha .. ".txt"
    local package_dir = get_prop("pushblind.package_dir." .. name)

    if not package_dir then
        return "not_exist"
    end
    if not dtw.isdir(package_dir) then
        return "not_exist"
    end

    -- Verificar se outros pacotes usam o mesmo package_dir
    local names_files = dtw.list_files(name_path, true)
    local other_packages_using_dir = false
    for i = 1, #names_files do
        local current_file = names_files[i]
        local current_name = dtw.load_file(current_file)
        if current_name and current_name ~= name then
            local other_package_dir = get_prop("pushblind.package_dir." .. current_name)
            if other_package_dir == package_dir then
                other_packages_using_dir = true
                break
            end
        end
    end

    -- Remover o arquivo de nome e as propriedades do pacote
    dtw.remove_any(name_file)
    set_prop("pushblind.package_dir." .. name, nil)
    set_prop("pushblind.git_dir." .. name, nil)
    set_prop("pushblind.package_file." .. name, nil)

    -- Remover o package_dir apenas se nenhum outro pacote o utiliza
    if not other_packages_using_dir then
        dtw.remove_any(package_dir)
    end

    return "removed"
end
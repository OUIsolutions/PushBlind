PushBlind = {}
PushBlind.actions = {}

function PushBlind.add_package(props)
    local home = os.getenv("HOME")
    local formated_package_name = dtw.generate_sha(props.package_name)
    local package_dir = home.."/.pushblind/packages/"..formated_package_name

    if dtw.isdir(package_dir) then

          print(private_vibescript.YELLOW.."Package already exists: "..props.name..private_vibescript.RESET)
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

function PushBlind.run_action(package_name, action_name)
    PushBlind.running_dir = get_prop("pushblind.git_dir." .. package_name)
    if not PushBlind.running_dir then        
        error("Package " .. package_name .. " not found.",0)
    end

    local filename = get_prop("pushblind.package_file." .. package_name)
    if not filename then 
        error("Package " .. package_name .. " does not have a valid filename.",0) 
    end 
    PushBlind.running_file = PushBlind.running_dir .. filename

    if not dtw.isfile(PushBlind.running_file) then
        error("Package " .. package_name .. " does not have a valid file.",0)
    end
    os.execute("cd " .. PushBlind.running_dir .. " && git pull")
    local ok, err = pcall(dofile, PushBlind.running_file)
    if not ok then
        os.execute("cd " .. PushBlind.running_dir .. " && git reset --hard HEAD")
        error("Error running package " .. package_name .. ": " .. err)
    end

    local action_provided = false
    for action, func in pairs(PushBlind.actions) do
        if action == action_name then
            action_provided = true
            break
        end
    end
    if action_provided then
        local ok, err = pcall(PushBlind.actions[action_name],PushBlind.running_dir, PushBlind.running_file)
        if not ok then
            os.execute("cd " .. PushBlind.running_dir .. " && git reset --hard HEAD")
            error("Error running action " .. action_name .. " for package " .. package_name .. ": " .. err)
        end
    end

    os.execute("cd " .. PushBlind.running_dir .. " && git reset --hard HEAD")
    if not action_provided then
        error("Action " .. action_name .. " not found for package " .. package_name,0)
    end
end


function PushBlind.install_package(package_name)
   PushBlind.run_action(package_name,"install")
end

function PushBlind.update_package(package_name)
    PushBlind.run_action(package_name,"update")    
end

function PushBlind.remove_package(package_name)

    local ok,error = pcall(PushBlind.run_action,package_name,"remove")
    if not  ok then
        print(private_vibescript.RED.."Error on remove "..package_name..": "..error..private_vibescript.RESET)
    end

    local home = os.getenv("HOME")
    local name_path = home .. "/.pushblind/names/"
    local name_sha = dtw.generate_sha(package_name)
    local name_file = name_path .. name_sha .. ".txt"
    local package_dir = get_prop("pushblind.package_dir." .. package_name)
    set_prop("pushblind.package_dir." .. package_name, nil)
    set_prop("pushblind.git_dir." .. package_name, nil)
    set_prop("pushblind.package_file." .. package_name, nil)
    dtw.remove_any(name_file)
 
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
    if not package_dir then
        error("Package "..package_name.." not found.")
    end
    if not dtw.isdir(package_dir) then
        error("Package directory "..package_dir.." does not exist.")
    end

    -- Remover o package_dir apenas se nenhum outro pacote o utiliza
    if not other_packages_using_dir then
        dtw.remove_any(package_dir)
    end


end
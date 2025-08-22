PushBlind = {}
PushBlind.actions = {}
local function get_home()
    return os.getenv("HOME")
end

function PushBlind.add_package(props)
    local home = get_home()
    local formated_repo = dtw.generate_sha(props.repo)
    local pushblind_repos_dir = home.."/.pushblind/repos/"
    local package_repo = pushblind_repos_dir..formated_repo

    if not dtw.isdir(package_repo) then
        dtw.create_dir_recursively(pushblind_repos_dir)
        local git_mode = get_prop("pushblind.git_mode")
        local ok = false
        if git_mode == "https" then
                ok = os.execute("git clone  https://github.com/"..props.repo.." "..package_repo)
        end
        if git_mode == "ssh" then
                ok = os.execute("git clone git@github.com:"..props.repo.." "..package_repo)
        end
        if not ok then
            return "not_exist"
        end
    end
    local packages_info_dir  = home.."/.pushblind/packages/"
    local package_info_dir = packages_info_dir..

    
    return "cloned"
end
function PushBlind.list_packages()
  
end

function PushBlind.run_action(repo, action_name)
   
end


function PushBlind.install_package(repo)
   PushBlind.run_action(repo,"install")
end

function PushBlind.update_package(repo)
    PushBlind.run_action(repo,"update")    
end

function PushBlind.remove_package(repo)

    local ok,error = pcall(PushBlind.run_action,repo,"remove")
    if not  ok then
        print(private_vibescript.RED.."Error on remove "..repo..": "..error..private_vibescript.RESET)
    end

    local home = os.getenv("HOME")
    local name_path = home .. "/.pushblind/names/"
    local name_sha = dtw.generate_sha(repo)
    local name_file = name_path .. name_sha .. ".txt"
    local package_dir = get_prop("pushblind.package_dir." .. repo)
    set_prop("pushblind.package_dir." .. repo, nil)
    set_prop("pushblind.git_dir." .. repo, nil)
    set_prop("pushblind.package_file." .. repo, nil)
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
        error("Package "..repo.." not found.")
    end
    if not dtw.isdir(package_dir) then
        error("Package directory "..package_dir.." does not exist.")
    end

    -- Remover o package_dir apenas se nenhum outro pacote o utiliza
    if not other_packages_using_dir then
        dtw.remove_any(package_dir)
    end


end
PushBlind = {}
PushBlind.actions = {}
local function get_home()
    return os.getenv("HOME")
end

function PushBlind.add_package(props)
    local home = get_home()
    local formated_repo = dtw.generate_sha(props.repo)
    local pushblind_repos_dir = home.."/"..PUSH_BLIND_LOCATION.."/repos/"
    local package_repo = pushblind_repos_dir..formated_repo

    if not dtw.isdir(package_repo) then
        dtw.create_dir_recursively(pushblind_repos_dir)
        ok = os.execute(PUSH_BLIND_CLONE_COMMAND.." "..props.repo.." "..package_repo)
        if not ok then
            return "not_exist"
        end
    end
    local packages_info_dir  = home.."/"..PUSH_BLIND_LOCATION.."/packages/"
    local package_info_dir = packages_info_dir..dtw.generate_sha(props.name)
    if dtw.isdir(packages_info_dir) then
        return "already_exists"
    end
    
    dtw.write_file(package_info_dir.."/name.txt", props.name)
    dtw.write_file(package_info_dir.."/repo.txt",formated_repo)

    return "cloned"
end
function PushBlind.list_packages()
  
    local home = get_home()
    local packages_info_dir  = home.."/."..PUSH_BLIND_LOCATION.."/packages/"
    local names = {}
    local packages = dtw.list_dirs(packages_info_dir)
    for i=1, #packages do
        local name = dtw.load_file(packages_info_dir.."/"..packages[i].."/name.txt")
        names[#names+1] = name
    end
    return names
end


function PushBlind.run_action(repo, action_name)
   
end


function PushBlind.remove_package(repo)

end



function PushBlind.install_package(repo)
   PushBlind.run_action(repo,"install")
end

function PushBlind.update_package(repo)
    PushBlind.run_action(repo,"update")    
end


PushBlind = {}
PushBlind.actions = {}
local function get_home()
    return os.getenv("HOME")
end
function PrivatePushBlind_Configure_entries()
    PUSH_BLIND_LOCATION = get_prop("pushblind.path",".pushblind")
    PUSH_BLIND_CLONE_COMMAND = get_prop("pushblind.git_clone","git clone")
    PUSH_BLIND_PULL_COMMAND = get_prop("pushblind.git_pull","git pull")

end
function PushBlind.add_same_repo_package(props)
    local home = get_home()
    local packages_info_dir  = home.."/"..PUSH_BLIND_LOCATION.."/packages/"
    local package_info_dir = packages_info_dir..dtw.generate_sha(props.name)
    dtw.create_dir_recursively(package_info_dir)
    dtw.write_file(package_info_dir.."/name.txt", props.name)
    dtw.write_file(package_info_dir.."/repo.txt", PushBlind.repo_dir)
    dtw.write_file(package_info_dir.."/filename.txt", props.filename)

end

function PushBlind.add_package(props)
    if props.repo == PushBlind.repo_dir then
        return PushBlind.add_same_repo_package(props)
    end
    local home = get_home()
    local formated_repo = dtw.generate_sha(props.repo)
    local pushblind_repos_dir = home.."/"..PUSH_BLIND_LOCATION.."/repos/"
    local package_repo = pushblind_repos_dir..formated_repo

    if not dtw.isdir(package_repo) then
        dtw.create_dir_recursively(pushblind_repos_dir)
        ok = os.execute(PUSH_BLIND_CLONE_COMMAND.." "..props.repo.." "..package_repo)
        if not ok then
            return false,"not_found"
        end
    end
    local packages_info_dir  = home.."/"..PUSH_BLIND_LOCATION.."/packages/"
    local package_info_dir = packages_info_dir..dtw.generate_sha(props.name)
    if dtw.isdir(packages_info_dir) then
        return true,"already_exists"
    end
    
    dtw.write_file(package_info_dir.."/name.txt", props.name)
    dtw.write_file(package_info_dir.."/repo.txt",formated_repo)
    dtw.write_file(package_info_dir.."/filename.txt",props.filename)
    return true,"cloned"
end


function PushBlind.list_packages()
  
    local home = get_home()
    local packages_info_dir  = home.."/"..PUSH_BLIND_LOCATION.."/packages/"
    local names = {}
    local packages = dtw.list_dirs(packages_info_dir)
    for i=1, #packages do
        local name = dtw.load_file(packages_info_dir.."/"..packages[i].."/name.txt")
        names[#names+1] = name
    end
    return names
end


function PushBlind.run_action(name, action_name)
    local home = get_home()
  

    local packages_info_dir  = home.."/"..PUSH_BLIND_LOCATION.."/packages/"
    local package_info_dir = packages_info_dir..dtw.generate_sha(name)
    if not dtw.isdir(package_info_dir) then
        return false,"not_found"
    end
    local pushblind_repos_dir = home.."/"..PUSH_BLIND_LOCATION.."/repos/"
    local repo_dir = dtw.load_file(package_info_dir.."/repo.txt")
    PushBlind.repo_dir = repo_dir
    PushBlind.same  = PushBlind.repo_dir
    local absolute_repo_dir = pushblind_repos_dir..repo_dir
    local filename = dtw.load_file(package_info_dir.."/filename.txt")
    local filename_path = absolute_repo_dir.."/"..filename
    os.execute("cd "..absolute_repo_dir.." && "..PUSH_BLIND_PULL_COMMAND)

    local ok,error = pcall(dofile,filename_path)
    if not ok then
        return false,error
    end
    local ok,error = pcall(PushBlind.actions[action_name])
    if not ok then
        return false,error
    end

    return true,"runned"
end


function PushBlind.remove_package(repo)

end



function PushBlind.install_package(repo)
   PushBlind.run_action(repo,"install")
end

function PushBlind.update_package(repo)
    PushBlind.run_action(repo,"update")    
end


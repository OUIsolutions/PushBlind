
function PrivatePushBlind_Configure_entries()
    PUSH_BLIND_LOCATION = get_prop("pushblind.path",".pushblind")
    PUSH_BLIND_CLONE_COMMAND = get_prop("pushblind.git_clone","git clone")
    PUSH_BLIND_PULL_COMMAND = get_prop("pushblind.git_pull","git pull")

end

function PrivatePushBlind_add_package_action()
   
    local git_mode = get_prop("pushblind.git_mode")
    if not git_mode then
        print(private_vibescript.RED.."Git mode not set. Use 'https' or 'ssh'."..private_vibescript.RESET)
        return 1
    end

    local repo = argv.get_next_unused()
    if not repo then
        print(private_vibescript.RED.."No repo name provided"..private_vibescript.RESET)
        return 1
    end
    local name = argv.get_flag_arg_by_index({ "name" }, 1)
    if not name then
        print(private_vibescript.RED.."No name provided for the package"..private_vibescript.RESET)
        return 1
    end

    local filename = argv.get_next_unused()
    if not filename then
        print(private_vibescript.RED.."No filename provided for the package"..private_vibescript.RESET)
        return 1
    end

    local force = argv.flags_exist({ "force"})
    local result =PushBlind.add_package({
        repo = repo,
        filename = filename,
        name = name,
        force=force
    })
    if result == "already_exists" then
        print(private_vibescript.YELLOW.."Package "..name.." already exists. Use --force to overwrite."..private_vibescript.RESET)
        return 0
    elseif result == "not_exist" then
        print(private_vibescript.RED.."Package "..repo.." does not exist on GitHub."..private_vibescript.RESET)
        return 1
    elseif result == "cloned" then
        print(private_vibescript.GREEN.."Package "..name.." successfully cloned."..private_vibescript.RESET)
        return 0
    end 

end
function PrivatePushBlind_list_packages()
    local packages = PushBlind.list_packages()
    for i=1,#packages do
        local repo = packages[i]
        print(private_vibescript.GREEN..repo..private_vibescript.RESET)
    end
    return 0
end


function PrivatePushBlind_remove_package()
    local name = argv.get_next_unused()
    if not name then
        print(private_vibescript.RED.."No package name provided"..private_vibescript.RESET)
        return 1
    end
    PushBlind.remove_package(name)
end

function PrivatePushBlind_set_clone_command()
    local command = argv.get_next_unused()
    if not command then
        print(private_vibescript.RED.."No git command provided"..private_vibescript.RESET)
        return 1
    end
    set_prop("pushblind.git_clone",command)
end 
function PrivatePushBlind_pull_command()
    local command = argv.get_next_unused()
    if not command then
        print(private_vibescript.RED.."No git command provided"..private_vibescript.RESET)
        return 1
    end
    set_prop("pushblind.git_pull",command)
end

function Push_blind_add_package_action()
    local package_name = argv.get_next_unused()
    if not package_name then
        print(private_vibescript.RED.."No package name provided"..private_vibescript.RESET)
        return 1
    end
    local filename = argv.get_next_unused()
    if not filename then
        print(private_vibescript.RED.."No filename provided for the package"..private_vibescript.RESET)
        return 1
    end
    local name = argv.get_flag_arg_by_index({ "name" }, 1)
    if not name then
        print(private_vibescript.RED.."No name provided for the package"..private_vibescript.RESET)
        return 1
    end
    local force = argv.flags_exist({ "force"})
    local result =PushBlind.add_package({
        package_name = package_name,
        filename = filename,
        name = name,
        force=force
    })
    if result == "already_exists" then
        print(private_vibescript.YELLOW.."Package "..name.." already exists. Use --force to overwrite."..private_vibescript.RESET)
        return 0
    elseif result == "not_exist" then
        print(private_vibescript.RED.."Package "..package_name.." does not exist on GitHub."..private_vibescript.RESET)
        return 1
    elseif result == "cloned" then
        print(private_vibescript.GREEN.."Package "..name.." successfully cloned."..private_vibescript.RESET)
        return 0
    end 

end


function  Push_blind_install_package()
    local name = argv.get_next_unused()
    if not name then
        print(private_vibescript.RED.."No package name provided"..private_vibescript.RESET)
        return 1
    end
    local installed = PushBlind.install_package(name)
    if not installed then
        print(private_vibescript.RED.."Failed to install package "..name..". It may not exist or be improperly formatted."..private_vibescript.RESET)
        return 1   
    end 

end


function  Push_blind_upldate_package()
    local name = argv.get_next_unused()
    if not name then
        print(private_vibescript.RED.."No package name provided"..private_vibescript.RESET)
        return 1
    end
    local updated = PushBlind.update_package(name)
    if not updated then
        print(private_vibescript.RED.."Failed to update package "..name..". It may not exist or be improperly formatted."..private_vibescript.RESET)
        return 1
    end 
end
function Push_blind_remove_package()
    local name = argv.get_next_unused()
    if not name then
        print(private_vibescript.RED.."No package name provided"..private_vibescript.RESET)
        return 1
    end
    local removed = PushBlind.remove_package(name)
    if removed == "not_exist" then
        print(private_vibescript.RED.."Package "..name.." does not exist."..private_vibescript.RESET)
        return 1
    elseif removed == "removed" then
        print(private_vibescript.GREEN.."Package "..name.." successfully removed."..private_vibescript.RESET)
        return 0
    end 
end

function PushBlind_set_git_mode()
    local mode = argv.get_next_unused()
    if not mode then
        print(private_vibescript.RED.."No mode provided. Use 'https' or 'ssh'."..private_vibescript.RESET)
        return 1
    end 
    if mode ~= "https" and mode ~= "ssh" then
        print(private_vibescript.RED.."Invalid mode. Use 'https' or 'ssh'."..private_vibescript.RESET)
        return 1
    end
    private_vibescript.set_prop("pushblind.git_mode", mode)
end 
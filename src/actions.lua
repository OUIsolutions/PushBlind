
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
    local package_dir = get_prop("pushblind.package_dir."..name)
    os.execute("cd "..package_dir.." && git pull")

    local filename = get_prop("pushblind.package_file."..name)
    local full_file_path = package_dir.."/"..filename
    dofile(full_file_path)
    local curent_dir = dtw.get_absolute_path(".")
    install(curent_dir)

end


function  Push_blind_upldate_package()
    local name = argv.get_next_unused()
    if not name then
        print(private_vibescript.RED.."No package name provided"..private_vibescript.RESET)
        return 1
    end
    local package_dir = get_prop("pushblind.package_dir."..name)
    os.execute("cd "..package_dir.." && git pull")
    local filename = get_prop("pushblind.package_file."..name)
    local full_file_path = package_dir.."/"..filename
    dofile(full_file_path)
    local curent_dir = dtw.get_absolute_path(".")
    update(curent_dir)

end
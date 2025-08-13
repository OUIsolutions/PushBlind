
function Add_package_action()
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
    PushBlind.add_package({
        package_name = package_name,
        filename = filename,
        name = name,
        force=force
    })

end


function  Install_package()
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


function  Update_package()
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
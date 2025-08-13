
function Add_package()
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
    local home = os.getenv("HOME")
    local formated_package_name = package_name:gsub("/", "_")
    print("formated_package_name: "..formated_package_name)
    local packages_dir = home.."/.pushblind/packages/"..formated_package_name
    dtw.remove_any(packages_dir)
    os.execute("mkdir -p "..packages_dir)
    os.execute("cd "..packages_dir.." && git clone https://github.com/"..package_name..".git")
    set_prop("pushblind.package_dir."..name,packages_dir)
    set_prop("pushblind.package_file."..name,filename)
end

function  Install_package()
    local name = argv.get_next_unused()
    if not name then
        print(private_vibescript.RED.."No package name provided"..private_vibescript.RESET)
        return 1
    end
    local package_dir = get_prop("pushblind.package_dir."..name)
    local filename = get_prop("pushblind.package_file."..name)
    local full_file_path = package_dir.."/"..filename
    print(full_file_path)
    
end
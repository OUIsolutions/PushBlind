
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
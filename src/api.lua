local PushBlind = {}

function PushBlind.add_package(props)
    local home = os.getenv("HOME")
    local formated_package_name = props.package_name:gsub("/", "_")
    local packages_dir = home.."/.pushblind/packages/"..formated_package_name
    dtw.remove_any(packages_dir)
    os.execute("mkdir -p "..packages_dir)
    local packages_dir = dtw.list_dirs(packages_dir,true)[1]
    if dtw.isdir(packages_dir) then
        set_prop("pushblind.package_dir."..props.name,packages_dir)
        set_prop("pushblind.package_file."..props.name,props.filename)
        if not props.force then
            return true
        end
    end

    os.execute("cd "..packages_dir.." && git clone https://github.com/"..props.package_name..".git")
    local packages_dir = dtw.list_dirs(packages_dir,true)[1]
    if not packages_dir then
        return false
    end

    set_prop("pushblind.package_dir."..props.name,packages_dir)
    set_prop("pushblind.package_file."..props.name,props.filename)
    return true
end

function PushBlind.install_package(name,version)
    local home = os.getenv("HOME")
    local formated_package_name = package_name:gsub("/", "_")
    local packages_dir = home.."/.pushblind/packages/"..formated_package_name
    if not dtw.exists(packages_dir) then
        print("Package "..package_name.." not found.")
        return false
    end
    local package_file = dtw.list_files(packages_dir,true)[1]
    if not package_file then
        print("No package file found in "..packages_dir)
        return false
    end
    print("Installing package: "..package_name)
    -- Here you would add the logic to install the package, e.g., running a script or copying files.
    return true
end
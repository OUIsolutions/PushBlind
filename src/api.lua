PushBlind = {}

function PushBlind.add_package(props)
    local home = os.getenv("HOME")
    local formated_package_name = props.package_name:gsub("/", "_")
    local packages_dir = home.."/.pushblind/packages/"..formated_package_name
    local possible_package_dir = dtw.list_dirs(packages_dir,true)[1]

    if possible_package_dir then
        set_prop("pushblind.package_dir."..props.name,possible_package_dir)
        set_prop("pushblind.package_file."..props.name,props.filename)
        if not props.force then
            return "already_exists"
        end
    end
    dtw.remove_any(packages_dir)
    os.execute("mkdir -p "..packages_dir)

    os.execute("cd "..packages_dir.." && git clone https://github.com/"..props.package_name..".git")
    local packages_dir = dtw.list_dirs(packages_dir,true)[1]
    if not packages_dir then
        return "not_exist"
    end

    set_prop("pushblind.package_dir."..props.name,packages_dir)
    set_prop("pushblind.package_file."..props.name,props.filename)
    return "cloned"
end

function PushBlind.install_package(name)
    
    PushBlind.running_dir = get_prop("pushblind.package_dir."..name)
    local filename  = get_prop("pushblind.package_file."..name)
    PushBlind.running_file = PushBlind.running_dir..filename
    dofile(PushBlind.running_file)
    local current_file = dtw.get_absolute_path(".")
    os.execute("cd "..PushBlind.running_dir.." && git pull")
    local result = install(PushBlind.running_file, current_file)    
    os.execute("git reset --hard HEAD")
    return result   
end
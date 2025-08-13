
function  Install_package()
    local name = argv.get_next_unused()
    if not name then
        print(private_vibescript.RED.."No package name provided"..private_vibescript.RESET)
        return 1
    end
    
end
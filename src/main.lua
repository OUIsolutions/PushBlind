function vibescript_extension_internal_main()
    private_vibescript.configure_paths()

    private_vibescript.configure_props_functions()
     private_vibescript.configure_newRawLLMFunction()

    local action =   argv.get_next_unused()
    if action == "set_git_clone" then
        return PrivatePushBlind_set_clone_command()
    end
    if action == "set_git_pull" then
        return PrivatePushBlind_pull_command()
    end


     PrivatePushBlind_Configure_entries()

     if not action then
         print(private_vibescript.RED.."No action provided"..private_vibescript.RESET)
         return 1
     end
     if action == "add" then
         return PrivatePushBlind_add_package_action()
     end
    if action == "list" then
        return PrivatePushBlind_list_packages()
    end
    if action == "remove" then
        return PrivatePushBlind_remove_package()
    end
  
    if action == "version" or action == "--version" or action == "-v" then
        print("PushBlind version: 0.7.1")
        return 0
    end
    
    local package_name = argv.get_next_unused()
    if not package_name then
        print(private_vibescript.RED.."No package name provided"..private_vibescript.RESET)
        return 1
    end
    return PrivatePushBlind_run_action(package_name, action)
end 

function vibescript_extension_main()
     argv.get_next_unused()
     local ok, error = pcall(vibescript_extension_internal_main)
     if not ok then
         print(private_vibescript.RED..error..private_vibescript.RESET)
     end
     return 0

end
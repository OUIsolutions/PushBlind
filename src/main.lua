function vibescript_extension_internal_main()
     local config_json = private_vibescript.get_config_json()
     if not config_json.platform_credentials then
          config_json.platform_credentials = {}
     end
     private_vibescript.configure_newRawLLMFunction(config_json)
     private_vibescript.configure_props_functions(config_json)
     

     local action =   argv.get_next_unused()
    
    

    if action == "set_git_clone" then
        return PrivatePushBlind_set_clone_command()
    end
    if action == "set_git_pull" then
        return PrivatePushBlind_pull_command()
    end
    

     local entries_result = PrivatePushBlind_Configure_entries()
     if entries_result ~= 0 then
         return entries_result
     end
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
  

    local package_name = argv.get_next_unused()
    if not package_name then
        print(private_vibescript.RED.."No package name provided"..private_vibescript.RESET)
        return 1
    end
    PushBlind.run_action(package_name, action)
    return 0
end 

function vibescript_extension_main()
     argv.get_next_unused()
     local ok, error = pcall(vibescript_extension_internal_main)
     if not ok then
         print(private_vibescript.RED..error..private_vibescript.RESET)
     end
     return 0

end
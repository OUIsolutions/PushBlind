function vibescript_extension_internal_main()
     local config_json = private_vibescript.get_config_json()
     if not config_json.platform_credentials then
          config_json.platform_credentials = {}
     end
     --dtw.write_file("teste.json",json.dumps_to_string(config_json))
     local action =   argv.get_next_unused()
     
     private_vibescript.configure_newRawLLMFunction(config_json)
     private_vibescript.configure_props_functions(config_json)
     if not action then
         print(private_vibescript.RED.."No action provided"..private_vibescript.RESET)
         return 1
     end
     if action == "add_package" then
         return Add_package()
     end
     if action == "install_package" then
         return Install_package()
     end
     
     print("running action "..action)
end 

function vibescript_extension_main()
     argv.get_next_unused()
     local ok, error = pcall(vibescript_extension_internal_main)
     if not ok then
         print(private_vibescript.RED..error..private_vibescript.RESET)
     end
     return 0

end
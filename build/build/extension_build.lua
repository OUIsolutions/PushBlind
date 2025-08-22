local alreay_did_the_extension = false
function extension_build()
    if alreay_did_the_extension then
        return
    end
    alreay_did_the_extension = true

    local project = darwin.create_project(PROJECT_NAME)
    project.add_lua_code('ouivibe = {}')


    project.add_lua_code("plataform_lib = function()\n")
    project.add_lua_file("dependencies/Plataform.lua")
    project.add_lua_code("end\n")
    project.add_lua_code("plataform_lib = plataform_lib()\n")


    local files = darwin.dtw.list_files_recursively("src",true)
    for i=1,#files do
        local file = files[i]
         project.add_lua_file(file)
    end
    project.generate_c_lib_file({
        output= "release/extension.c",
        include_lua_cembed = false,
        lib_name='ouivibe',
        object_export='ouivibe'
    })

end

function extension_build()

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
darwin.add_recipe({
    name="extension",
    description="make the C extension",
    outs={"release/extension.c"},
    callback=extension_build
})

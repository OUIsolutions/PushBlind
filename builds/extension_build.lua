function extension_build()

    local project = darwin.create_project(PROJECT_NAME)
    project.add_lua_code('pushblind = {}')

    local files = darwin.dtw.list_files_recursively("src",true)
    for i=1,#files do
        local file = files[i]
         project.add_lua_file(file)
    end
    project.generate_c_lib_file({
        output= "release/pushblind_extension.c",
        include_lua_cembed = false,
        lib_name='pushblind',
        object_export='pushblind'
    })

end
darwin.add_recipe({
    name="extension",
    description="make the C extension",
    outs={"release/extension.c"},
    callback=extension_build
})

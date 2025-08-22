function windowsi32_build()


    os.execute("mkdir -p release")

    local image = darwin.ship.create_machine("debian:latest")
    image.provider = CONTANIZER
    image.add_comptime_command("apt-get update")
    image.add_comptime_command("apt-get -y install mingw-w64")
    local compiler = "i686-w64-mingw32-gcc"
    if LAUNGUAGE == "cpp" then
        compiler = "i686-w64-mingw32-g++"
    end

     image.start({
        volumes = {
            { "././release", "/release" },
            { "././keys", "/keys" },
            { "././dependencies", "/dependencies" },

        },
        command = compiler..[[ --static /dependencies/vibescript.c  -DCONTENT_ENCRYPT_KEY=\\"../keys/content.h\\" -DLLM_ENCRYPT_KEY=\\"../keys/llm.h\\" -DNAME_ENCRYPT_KEY=\\"../keys/name.h\\"   -DDEFINE_DEPENDENCIES  -DVIBE_EXTENSION_MODULE=\\"/release/extension.c\\" -DVIBE_EXTENSION_FUNC=ouivibe  -DVIBE_EXTENSION_LIB_NAME=\\"ouivibe\\" -lws2_32  -o /release/ouivibei32.exe ]]

    })
end

darwin.add_recipe({
    name=".exe",
    requires={"linux_bin"},
    description="make a .exe of the project",
    outs={"release/ouivibei32.exe"},
    callback=windowsi32_build
})
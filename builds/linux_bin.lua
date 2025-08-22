
function linux_bin()

    extension_build()

    os.execute("mkdir -p release")

    local image = darwin.ship.create_machine("alpine:latest")
    image.provider = CONTANIZER
    image.add_comptime_command("apk update")
    image.add_comptime_command("apk add --no-cache gcc g++ musl-dev curl")
    local compiler = "gcc"
    if LAUNGUAGE == "cpp" then
        compiler = "g++"
    end

    image.start({
        flags={
            "--workdir=/app",
          --  "-it"
        },
        volumes = {
            { "./", "/app" },
        },
        command ={ compiler..[[ dependencies/vibescript.c -static -DCONTENT_ENCRYPT_KEY=\\"../keys/content.h\\" -DLLM_ENCRYPT_KEY=\\"../keys/llm.h\\" -DNAME_ENCRYPT_KEY=\\"../keys/name.h\\"  -DVIBE_EXTENSION_MODULE=\\"../release/extension.c\\" -DVIBE_EXTENSION_FUNC=pusblind  -DVIBE_EXTENSION_LIB_NAME=\\"pusblind\\"   -o  release/linux_bin.out]]}
        --command ="sh"
    })
end
darwin.add_recipe({
    name="linux_bin",
    requires={"extension"},
    description="make a static compiled linux binary of the project",
    outs={"release/linux_bin.out"},
    callback=linux_bin
})
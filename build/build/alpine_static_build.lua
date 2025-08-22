local alpine_static_build_done = false

function alpine_static_build()
    if alpine_static_build_done then
        return
    end
    alpine_static_build_done = true
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
        command ={ compiler..[[ dependencies/vibescript.c -static -DCONTENT_ENCRYPT_KEY=\\"../keys/content.h\\" -DLLM_ENCRYPT_KEY=\\"../keys/llm.h\\" -DNAME_ENCRYPT_KEY=\\"../keys/name.h\\"  -DVIBE_EXTENSION_MODULE=\\"../release/extension.c\\" -DVIBE_EXTENSION_FUNC=ouivibe  -DVIBE_EXTENSION_LIB_NAME=\\"ouivibe\\"   -o  release/alpine_static_bin.out]]}
        --command ="sh"
    })
end

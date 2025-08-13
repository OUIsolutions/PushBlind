
function Install_dependencies()
    os.execute("mkdir -p dependencies")

    local libs = {
        { url = "https://github.com/OUIsolutions/VibeScript/releases/download/0.28.0/amalgamation.c", path = "dependencies/vibescript.c" },
    }
    for _, lib in ipairs(libs) do
        local executor = function()
            os.execute("curl -L " .. lib.url .. " -o " .. lib.path)
        end
        local side_effect_verifier = function()
            return darwin.dtw.generate_sha_from_file(lib.path)
        end
        cache_execution({ "download", lib.url, lib.path }, executor, side_effect_verifier)

    end
end
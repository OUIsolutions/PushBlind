
function local_unix_bin()

    local comand = [[gcc  dependencies/vibescript.c -DCONTENT_ENCRYPT_KEY=\"../keys/content.h\" -DLLM_ENCRYPT_KEY=\"../keys/llm.h\" -DNAME_ENCRYPT_KEY=\"../keys/name.h\"  -DVIBE_EXTENSION_MODULE=\"../release/pushblind_extension.c\" -DVIBE_EXTENSION_FUNC=pushblind -DVIBE_EXTENSION_LIB_NAME=\"pushblind\"   -o pushblind]]
    os.execute(comand)
   
end

darwin.add_recipe({
    name="local_unix_bin",
    requires={"extension"},
    description="make a local compiled unix binary of the project",
    outs={"release/local_unix_bin.out"},
    callback=local_unix_bin
})

function local_unux_compilation()

    local comand = [[gcc  dependencies/vibescript.c -DCONTENT_ENCRYPT_KEY=\"../keys/content.h\" -DLLM_ENCRYPT_KEY=\"../keys/llm.h\" -DNAME_ENCRYPT_KEY=\"../keys/name.h\"  -DVIBE_EXTENSION_MODULE=\"../release/extension.c\" -DVIBE_EXTENSION_FUNC=ouivibe -DVIBE_EXTENSION_LIB_NAME=\"ouivibe\"   -o pushblind]]
    os.execute(comand)
   
end
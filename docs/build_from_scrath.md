for building from scratch, follow these steps:

### Step 1: Install Darwin 

go to [Darwin](https://github.com/OUIsolutions/Darwin) and install the version [**0.12.0**](https://github.com/OUIsolutions/Darwin/releases/tag/0.12.0) of the builder.
if you are on linux or macOS you can install with: 

### Linux Installation 
```bash
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.12.0/darwin_linux_bin.out -o darwin.out && chmod +x darwin.out &&   mv darwin.out /usr/local/bin/darwin 
```
### Mac-Os Instalation
```bash
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.12.0/darwin.c -o darwin.c && gcc darwin.c -o darwin.out && sudo mv darwin.out /usr/local/bin/darwin && rm darwin.c 
```

### Step 2 , install keyobfuscate
go to the repo [KeyObfuscate](https://github.com/OUIsolutions/key_obfuscate)
This tool creates security keys to protect your application. It's like creating passwords for your app.

**On Linux, copy and paste this command in your terminal:**
```bash
curl -L https://github.com/OUIsolutions/key_obfuscate/releases/download/0.0.1/KeyObfuscate.out -o KeyObfuscate && sudo chmod +x KeyObfuscate && sudo mv KeyObfuscate /bin/KeyObfuscate
```

## Step 3: Create Your Security Keys

Every pushblind build needs security keys. These are like passwords that protect different parts of your app.

**Run these commands one by one:**

```bash
# Create a folder for your keys
mkdir -p keys

# Create three different security keys (replace the text in quotes with your own passwords)
KeyObfuscate --entry 'my-secret-content-password' --project_name 'content' --output 'keys/content.h'
KeyObfuscate --entry 'my-secret-llm-password' --project_name 'llm' --output 'keys/llm.h'  
KeyObfuscate --entry 'my-secret-name-password' --project_name 'name' --output 'keys/name.h'
```


### Step 4 : Build your outputs 
you can now build all the:
release/
├── pushblind.deb
├── pushblind_extension.c
├── pushblindi32.exe
├── pushblind.out
└── pushblind.rpm

with the command:
```bash
darwin run_blueprint --target all
```

you also can list all the builds with:

```bash
darwin list_blueprints
```
you will have the following results:
```txt
Available build: .deb
Description: make a .deb of the project
Outputs: 
    release/debian_static.deb
=======================================
Available build: extension
Description: make the C extension
Outputs: 
    release/extension.c
=======================================
Available build: linux_bin
Description: make a static compiled linux binary of the project
Outputs: 
    release/pushblind.out
=======================================
Available build: local_unix_bin
Description: make a local compiled unix binary of the project
Outputs: 
    release/local_unix_bin.out
=======================================
Available build: .rpm
Description: make a .rpm of the project
Outputs: 
    release/rpm_static_build.rpm
=======================================
Available build: .exe
Description: make a .exe of the project
Outputs: 
    release/ouivibei32.exe
=======================================
```

#### Copiling from source
if you want to compile the extension you can just follow these steps

-- generate extension with:

```bash
darwin run_blueprint --target extension
```

since, pushblind its  a [vibescript](https://github.com/OUIsolutions/VibeScript) estension, you can compile it with: 

```bash
gcc  dependencies/vibescript.c -DCONTENT_ENCRYPT_KEY=\"../keys/content.h\" -DLLM_ENCRYPT_KEY=\"../keys/llm.h\" -DNAME_ENCRYPT_KEY=\"../keys/name.h\"  -DVIBE_EXTENSION_MODULE=\"../release/pushblind_extension.c\" -DVIBE_EXTENSION_FUNC=pushblind -DVIBE_EXTENSION_LIB_NAME=\"pushblind\"   -o pushblind
```
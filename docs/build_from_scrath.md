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


### Build all Plataforms 
```bash
darwin run_blueprint build/ --mode folder extension_build alpine_static_build windowsi32_build windows64_build rpm_static_build debian_static_build --contanizer podman
```

### Local Build 
```bash
darwin run_blueprint build/ --mode folder local_linux_build
```

### Add Package
```bash
pushblind add_package user/package_name filename
```
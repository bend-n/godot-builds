# godot builds

[![version](https://img.shields.io/badge/4.x-blue?logo=godot-engine&logoColor=white&label=godot&style=for-the-badge)](https://godotengine.org)
[![aur](https://img.shields.io/aur/version/godot2d?color=informative&logo=archlinux&logoColor=white&style=for-the-badge)](https://aur.archlinux.org/packages/godot2d "Aur package")
<a href='https://ko-fi.com/bendn' title='Buy me a coffee' target='_blank'><img height='28' src='https://ko-fi.com/img/githubbutton_sm.svg' alt='Buy me a coffee'> </a>

Creates two packages.

- `godot`: Docker images with the _normal_ godot build.
- `godot-2d`: Docker images with the _2d_ godot build.
  This build is smaller, and tailored for 2d games.

## How to use

For a full example, see this [template](https://github.com/bend-n/godot-template/blob/9c9e2b02ddf9f88bff872dcd2695363d09485bc4/.github/workflows/export.yml).

<details open>
<summary>With helpers (recomended)</summary>

```yaml
build-windows:
  runs-on: ubuntu-latest
  container:
    image: ghcr.io/bend-n/godot-2d:4.0
  name: Build windows
  steps:
    - name: Build (Windows)
      uses: bend-n/godot-actions/.github/actions/export-windows@main
      env:
        NAME: ${{ github.event.repository.name }}
```

</details>

<details>
<summary>Manually</summary>

> **Warning**
> This method has _not_ been tested.

```yaml
build-windows:
  runs-on: ubuntu-latest
  container:
    image: ghcr.io/bend-n/godot-2d:4.0
  name: Build windows
  steps:
    - name: Checkout
      uses: actions/checkout@v3

    - name: Setup godot
      run: |
        RELEASE=stable; GODOT_VERSION=4.0.rc;
        mkdir -v -p ~/.local/share/godot/templates
        mv /root/.local/share/godot/templates/${GODOT_VERSION}.${RELEASE} ~/.local/share/godot/templates/${GODOT_VERSION}.${RELEASE}

    - name: Build
      run: |
        mkdir -p build/windows
        godot --export Windows "./build/windows/${GAME_NAME}.exe"
      env:
        GAME_NAME: ${{ github.event.repository.name }}

    - name: Upload
      uses: actions/upload-artifact@v3
      with:
        name: windows
        path: build/windows
```

</details>

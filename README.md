# godot builds

Creates two packages.

- `godot`: Docker images with the _normal_ godot build.
- `godot-2d`: Docker images with the _2d_ godot build.
  This build is smaller, and tailored for 2d games.

## How to use

For a full example, see this [template](https://github.com/bend-n/godot-template/blob/3d79cf6cc3e25317763ad4100e2a8692b0c2644e/.github/workflows/export.yml).

<details open>
<summary>With helpers (recomended)</summary>

```yaml
build-windows:
  runs-on: ubuntu-latest
  container:
    image: ghcr.io/bend-n/godot-2d:3.5
  name: Build windows
  steps:
    - name: Build (Windows)
      uses: bend-n/godot-actions/.github/actions/export-windows@main
      env:
        GODOT_VERSION: 3.5
        NAME: ${{ github.event.repository.name }}
```

</details>

<details>
<summary>Manually</summary>

> **Warning**
>
> This method has _not_ been tested.

```yaml
build-windows:
  runs-on: ubuntu-latest
  container:
    image: ghcr.io/bend-n/godot-2d:3.5
  name: Build windows
  steps:
    - name: Checkout
      uses: actions/checkout@v3

    - name: Setup godot
      run: |
        RELEASE=stable; GODOT_VERSION=3.5;
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
